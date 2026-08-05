using Newtonsoft.Json.Linq;
using System;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace LogicPOS.PaymentTerminals.Halyk
{
    /// <summary>
    /// Halyk PAX / Smart POS (cashier mode). HTTP on 8080 (PAX A800/A930) or 8090 (Aisino).
    /// Amount is integer tenge. Tries common ECR JSON bodies used by KZ 1C drivers.
    /// </summary>
    public class HalykPosClient
    {
        private readonly HttpClient _httpClient;
        private readonly string _baseUrl;

        public HalykPosClient(string host, int port)
        {
            if (port <= 0)
            {
                port = 8080;
            }

            _baseUrl = "http://" + host.Trim().TrimEnd('/') + ":" + port;
            _httpClient = new HttpClient { Timeout = TimeSpan.FromSeconds(180) };
        }

        public string BaseUrl => _baseUrl;

        public async Task<PaymentTerminalChargeResult> PurchaseAsync(int amountTenge, CancellationToken cancellationToken = default)
        {
            string[] payloads =
            {
                "{\"amount\":" + amountTenge + "}",
                "{\"operation\":\"sale\",\"amount\":" + amountTenge + "}",
                "{\"method\":\"purchase\",\"params\":{\"amount\":" + amountTenge + "}}"
            };

            string[] paths = { "/", "/purchase", "/sale", "/pos/sale" };

            Exception lastError = null;
            string lastBody = null;

            foreach (string path in paths)
            {
                foreach (string payload in payloads)
                {
                    cancellationToken.ThrowIfCancellationRequested();
                    try
                    {
                        string url = _baseUrl + path;
                        using (HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Post, url))
                        {
                            request.Content = new StringContent(payload, Encoding.UTF8, "application/json");
                            using (HttpResponseMessage response = await _httpClient.SendAsync(request, cancellationToken).ConfigureAwait(false))
                            {
                                string content = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                                lastBody = content;

                                if ((int)response.StatusCode == 404 || (int)response.StatusCode == 405)
                                {
                                    continue;
                                }

                                PaymentTerminalChargeResult parsed = ParseResponse(content, response.IsSuccessStatusCode);
                                if (parsed.Status == PaymentTerminalChargeStatus.Success
                                    || !LooksLikeUnsupported(content, (int)response.StatusCode))
                                {
                                    parsed.Message = (parsed.Message ?? string.Empty) + " [" + path + "]";
                                    return parsed;
                                }
                            }
                        }
                    }
                    catch (OperationCanceledException)
                    {
                        throw;
                    }
                    catch (Exception ex)
                    {
                        lastError = ex;
                    }
                }
            }

            return new PaymentTerminalChargeResult
            {
                Status = PaymentTerminalChargeStatus.Failed,
                Message = lastError != null
                    ? "Halyk: " + GetInnermostMessage(lastError)
                    : "Halyk не принял запрос оплаты. Ответ: " + Truncate(lastBody, 240),
                Exception = lastError
            };
        }

        public async Task<PaymentTerminalTestResult> ProbeAsync(CancellationToken cancellationToken = default)
        {
            try
            {
                using (HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get, _baseUrl + "/"))
                using (HttpResponseMessage response = await _httpClient.SendAsync(request, cancellationToken).ConfigureAwait(false))
                {
                    string content = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                    return new PaymentTerminalTestResult
                    {
                        Success = true,
                        Message = string.Format("Halyk ответил HTTP {0}: {1}", (int)response.StatusCode, Truncate(content, 200))
                    };
                }
            }
            catch (Exception ex)
            {
                return new PaymentTerminalTestResult
                {
                    Success = false,
                    Message = "Нет связи с Halyk: " + GetInnermostMessage(ex) + ". Включите «Режим кассы» на терминале (пароль часто 000000)."
                };
            }
        }

        private static bool LooksLikeUnsupported(string content, int statusCode)
        {
            if (statusCode == 404 || statusCode == 405)
            {
                return true;
            }

            if (string.IsNullOrWhiteSpace(content))
            {
                return false;
            }

            return content.IndexOf("not found", StringComparison.OrdinalIgnoreCase) >= 0
                || content.IndexOf("unknown method", StringComparison.OrdinalIgnoreCase) >= 0;
        }

        private static PaymentTerminalChargeResult ParseResponse(string content, bool httpOk)
        {
            if (string.IsNullOrWhiteSpace(content))
            {
                return new PaymentTerminalChargeResult
                {
                    Status = httpOk ? PaymentTerminalChargeStatus.Success : PaymentTerminalChargeStatus.Failed,
                    Message = httpOk ? "Halyk OK (empty body)" : "Пустой ответ Halyk"
                };
            }

            try
            {
                JObject root = JObject.Parse(content);
                JToken data = root["data"] ?? root["result"] ?? root["params"] ?? root;

                int? code = data.Value<int?>("result")
                    ?? data.Value<int?>("resultCode")
                    ?? data.Value<int?>("code")
                    ?? root.Value<int?>("result");

                string status = data.Value<string>("status") ?? root.Value<string>("status");
                string message = data.Value<string>("msg")
                    ?? data.Value<string>("message")
                    ?? root.Value<string>("message");

                bool failed = (code.HasValue && code.Value != 0)
                    || string.Equals(status, "fail", StringComparison.OrdinalIgnoreCase)
                    || string.Equals(status, "error", StringComparison.OrdinalIgnoreCase)
                    || (!httpOk && !code.HasValue && string.IsNullOrEmpty(status));

                if (failed)
                {
                    return new PaymentTerminalChargeResult
                    {
                        Status = PaymentTerminalChargeStatus.Failed,
                        Message = message ?? ("Halyk error: " + Truncate(content, 200))
                    };
                }

                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Success,
                    Message = message ?? "Halyk OK",
                    TransactionId = data.Value<string>("transactionId")
                        ?? data.Value<string>("rrn")
                        ?? data.Value<string>("tagRRN"),
                    Rrn = data.Value<string>("rrn") ?? data.Value<string>("tagRRN") ?? data.Value<string>("RRN"),
                    AuthorizationCode = data.Value<string>("authorizationCode")
                        ?? data.Value<string>("authCode")
                        ?? data.Value<string>("approvalCode")
                };
            }
            catch
            {
                if (!httpOk)
                {
                    return new PaymentTerminalChargeResult
                    {
                        Status = PaymentTerminalChargeStatus.Failed,
                        Message = Truncate(content, 240)
                    };
                }

                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Success,
                    Message = Truncate(content, 240)
                };
            }
        }

        private static string Truncate(string value, int max)
        {
            if (string.IsNullOrEmpty(value) || value.Length <= max)
            {
                return value ?? string.Empty;
            }

            return value.Substring(0, max) + "...";
        }

        private static string GetInnermostMessage(Exception ex)
        {
            Exception current = ex;
            while (current.InnerException != null)
            {
                current = current.InnerException;
            }

            return current.Message ?? ex.Message;
        }
    }
}
