using Newtonsoft.Json.Linq;
using System;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace LogicPOS.PaymentTerminals.Halyk
{
    /// <summary>
    /// Halyk PAX / Aisino «Режим кассы».
    /// Live device (192.168.1.180:8080) accepts ECR JSON:
    ///   POST /  {"task":"purchase","data":{"amount":N}}  — starts payment (waits for card)
    ///   POST /  {"task":"cancel"} / abort — may return -240 / 200, but still returns terminalId
    /// GET is rejected («Ошибка метода запроса»).
    /// ShopUchet has no Halyk client; payment shape matches Jusan ECR.
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

            _baseUrl = "http://" + host.Trim().TrimEnd('/') + ":" + port + "/";
            _httpClient = new HttpClient { Timeout = TimeSpan.FromSeconds(180) };
        }

        public string BaseUrl => _baseUrl;

        public async Task<PaymentTerminalChargeResult> PurchaseAsync(int amountTenge, CancellationToken cancellationToken = default)
        {
            string body = "{\"task\":\"purchase\",\"data\":{\"amount\":" + amountTenge + "}}";
            return await SendTaskAsync(body, cancellationToken).ConfigureAwait(false);
        }

        public async Task<PaymentTerminalChargeResult> RefundAsync(int amountTenge, string tagRrn, CancellationToken cancellationToken = default)
        {
            string body = "{\"task\":\"refund\",\"data\":{\"amount\":" + amountTenge + ",\"tagRRN\":\"" + Escape(tagRrn) + "\"}}";
            return await SendTaskAsync(body, cancellationToken).ConfigureAwait(false);
        }

        /// <summary>
        /// Connectivity only: any JSON reply with terminalId means ECR is up.
        /// Do not use purchase here (it blocks on card UI).
        /// </summary>
        public async Task<PaymentTerminalTestResult> ProbeAsync(CancellationToken cancellationToken = default)
        {
            // Fast no-charge probes — device returns terminalId even for unknown/unsupported tasks.
            string[] probes =
            {
                "{\"task\":\"abort\"}",
                "{\"task\":\"cancel\"}",
                "{\"task\":\"status\"}"
            };

            Exception lastError = null;
            string lastBody = null;

            foreach (string body in probes)
            {
                cancellationToken.ThrowIfCancellationRequested();
                try
                {
                    using (CancellationTokenSource linked = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken))
                    {
                        linked.CancelAfter(TimeSpan.FromSeconds(8));
                        using (HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Post, _baseUrl))
                        {
                            request.Content = new StringContent(body, Encoding.UTF8, "application/json");
                            using (HttpResponseMessage response = await _httpClient.SendAsync(request, linked.Token).ConfigureAwait(false))
                            {
                                string content = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                                lastBody = content;

                                string terminalId;
                                string msg;
                                string resultCode;
                                if (TryParseEcr(content, out terminalId, out msg, out resultCode))
                                {
                                    return new PaymentTerminalTestResult
                                    {
                                        Success = true,
                                        Message = string.Format(
                                            "Halyk на связи, terminalId={0} (HTTP {1}). Оплата: task=purchase.",
                                            string.IsNullOrEmpty(terminalId) ? "?" : terminalId,
                                            (int)response.StatusCode)
                                    };
                                }

                                if (response.IsSuccessStatusCode)
                                {
                                    return new PaymentTerminalTestResult
                                    {
                                        Success = true,
                                        Message = string.Format("Halyk HTTP {0}: {1}", (int)response.StatusCode, Truncate(content, 200))
                                    };
                                }
                            }
                        }
                    }
                }
                catch (OperationCanceledException) when (!cancellationToken.IsCancellationRequested)
                {
                    // probe timeout — try next body
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

            if (!string.IsNullOrEmpty(lastBody))
            {
                return new PaymentTerminalTestResult
                {
                    Success = false,
                    Message = "Halyk ответил, но без terminalId: " + Truncate(lastBody, 200)
                };
            }

            return new PaymentTerminalTestResult
            {
                Success = false,
                Message = lastError != null
                    ? "Нет связи с Halyk: " + GetInnermostMessage(lastError) + ". Включите «Режим кассы» (пароль часто 000000)."
                    : "Нет ответа от Halyk."
            };
        }

        private async Task<PaymentTerminalChargeResult> SendTaskAsync(string jsonBody, CancellationToken cancellationToken)
        {
            try
            {
                using (HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Post, _baseUrl))
                {
                    request.Content = new StringContent(jsonBody, Encoding.UTF8, "application/json");
                    using (HttpResponseMessage response = await _httpClient.SendAsync(request, cancellationToken).ConfigureAwait(false))
                    {
                        string content = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                        return ParseChargeResponse(content, response.IsSuccessStatusCode);
                    }
                }
            }
            catch (OperationCanceledException)
            {
                throw;
            }
            catch (Exception ex)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = "Ошибка Halyk: " + GetInnermostMessage(ex),
                    Exception = ex
                };
            }
        }

        private static bool TryParseEcr(string content, out string terminalId, out string msg, out string resultCode)
        {
            terminalId = null;
            msg = null;
            resultCode = null;
            if (string.IsNullOrWhiteSpace(content))
            {
                return false;
            }

            try
            {
                JObject root = JObject.Parse(content);
                JToken data = root["data"] ?? root;
                terminalId = data.Value<string>("terminalId") ?? root.Value<string>("terminalId");
                msg = data.Value<string>("msg") ?? data.Value<string>("message");
                JToken resultToken = data["result"] ?? root["result"];
                resultCode = resultToken != null ? resultToken.ToString() : null;
                return !string.IsNullOrWhiteSpace(terminalId);
            }
            catch
            {
                return false;
            }
        }

        private static PaymentTerminalChargeResult ParseChargeResponse(string content, bool httpOk)
        {
            if (string.IsNullOrWhiteSpace(content))
            {
                return new PaymentTerminalChargeResult
                {
                    Status = httpOk ? PaymentTerminalChargeStatus.Success : PaymentTerminalChargeStatus.Failed,
                    Message = httpOk ? "Halyk OK (empty body)" : "Пустой ответ Halyk"
                };
            }

            string terminalId;
            string msg;
            string resultCode;
            if (!TryParseEcr(content, out terminalId, out msg, out resultCode))
            {
                return new PaymentTerminalChargeResult
                {
                    Status = httpOk ? PaymentTerminalChargeStatus.Success : PaymentTerminalChargeStatus.Failed,
                    Message = Truncate(content, 240)
                };
            }

            int codeNum;
            bool hasCode = int.TryParse(resultCode, out codeNum);
            // 0 = success; 1008 = busy; -240 / 200 = unsupported / bad request for non-pay tasks
            bool failed = (hasCode && codeNum != 0)
                || string.Equals(msg, "fail", StringComparison.OrdinalIgnoreCase);

            if (failed)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = string.Format("Halyk [{0}]: {1}", resultCode, msg ?? Truncate(content, 160))
                };
            }

            try
            {
                JObject root = JObject.Parse(content);
                JToken data = root["data"] ?? root;
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Success,
                    Message = msg ?? "Halyk OK",
                    TransactionId = data.Value<string>("transactionId")
                        ?? data.Value<string>("rrn")
                        ?? data.Value<string>("tagRRN"),
                    Rrn = data.Value<string>("rrn") ?? data.Value<string>("tagRRN") ?? data.Value<string>("RRN"),
                    AuthorizationCode = data.Value<string>("authorizationCode")
                        ?? data.Value<string>("authCode")
                        ?? data.Value<string>("approvalCode"),
                    PaymentMethodChannel = content.IndexOf("cardNo", StringComparison.OrdinalIgnoreCase) >= 0 ? "Card" : "Qr"
                };
            }
            catch
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Success,
                    Message = msg ?? "Halyk OK"
                };
            }
        }

        private static string Escape(string value)
        {
            return (value ?? string.Empty).Replace("\\", "\\\\").Replace("\"", "\\\"");
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
