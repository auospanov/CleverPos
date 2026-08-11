using Newtonsoft.Json.Linq;
using System;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace LogicPOS.PaymentTerminals.Jusan
{
    /// <summary>
    /// Jusan / Jysan Smart POS — protocol from ShopUchet frmPosTerminalProcess.SendJusan / ProcessPaymentJusan.
    /// POST http://{host}:8080/
    ///   {"task":"purchase","data":{"amount":N}}
    ///   {"task":"refund","data":{"amount":N,"tagRRN":"..."}}
    ///   {"task":"cancel"} — abort in-progress op (ShopUchet expects result 1010)
    /// Probe must be POST (GET often rejected like Halyk).
    /// Success: data.result == 0; card → tagRRN, QR → paymentId.
    /// </summary>
    public class JusanPosClient
    {
        private readonly HttpClient _httpClient;
        private readonly string _baseUrl;

        public JusanPosClient(string host, int port)
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
            // ShopUchet omits quotes around tagRRN (bug); we send valid JSON string.
            string body = "{\"task\":\"refund\",\"data\":{\"amount\":" + amountTenge + ",\"tagRRN\":\"" + Escape(tagRrn) + "\"}}";
            return await SendTaskAsync(body, cancellationToken).ConfigureAwait(false);
        }

        public async Task<PaymentTerminalTestResult> ProbeAsync(CancellationToken cancellationToken = default)
        {
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
                                if (TryGetTerminalId(content, out terminalId))
                                {
                                    return new PaymentTerminalTestResult
                                    {
                                        Success = true,
                                        Message = string.Format(
                                            "Jusan на связи, terminalId={0} (HTTP {1}). Оплата: task=purchase.",
                                            terminalId,
                                            (int)response.StatusCode)
                                    };
                                }

                                // Any HTTP reply from ECR proves connectivity (same lesson as Halyk).
                                if ((int)response.StatusCode == 400
                                    && !string.IsNullOrEmpty(content)
                                    && content.IndexOf("метода запроса", StringComparison.OrdinalIgnoreCase) >= 0)
                                {
                                    continue;
                                }

                                if (response.IsSuccessStatusCode || !string.IsNullOrWhiteSpace(content))
                                {
                                    return new PaymentTerminalTestResult
                                    {
                                        Success = true,
                                        Message = string.Format("Jusan HTTP {0}: {1}", (int)response.StatusCode, Truncate(content, 200))
                                    };
                                }
                            }
                        }
                    }
                }
                catch (OperationCanceledException) when (!cancellationToken.IsCancellationRequested)
                {
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

            return new PaymentTerminalTestResult
            {
                Success = false,
                Message = lastError != null
                    ? "Нет связи с Jusan: " + GetInnermostMessage(lastError)
                    : (string.IsNullOrEmpty(lastBody)
                        ? "Нет ответа от Jusan."
                        : "Jusan ответил: " + Truncate(lastBody, 200))
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
                        return ParseResponse(content);
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
                    Message = "Ошибка Jusan: " + GetInnermostMessage(ex),
                    Exception = ex
                };
            }
        }

        private static PaymentTerminalChargeResult ParseResponse(string content)
        {
            if (string.IsNullOrWhiteSpace(content))
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = "Пустой ответ Jusan"
                };
            }

            JObject root;
            try
            {
                root = JObject.Parse(content);
            }
            catch
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = "Не JSON от Jusan: " + Truncate(content, 200)
                };
            }

            JToken data = root["data"] ?? root;
            // ShopUchet reads data.result as string then TryStrToInt
            int resultCode = -1;
            JToken resultToken = data["result"];
            if (resultToken != null)
            {
                if (resultToken.Type == JTokenType.Integer)
                {
                    resultCode = resultToken.Value<int>();
                }
                else
                {
                    int.TryParse(resultToken.ToString(), out resultCode);
                }
            }

            if (resultCode != 0)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = data.Value<string>("msg") ?? ("Jusan result=" + resultCode)
                };
            }

            string rrn = data.Value<string>("tagRRN");
            string paymentId = data.Value<string>("paymentId");
            bool isCard = content.IndexOf("cardNo", StringComparison.OrdinalIgnoreCase) >= 0;

            return new PaymentTerminalChargeResult
            {
                Status = PaymentTerminalChargeStatus.Success,
                Message = isCard ? "Jusan CARD OK" : "Jusan QR OK",
                TransactionId = isCard ? rrn : paymentId,
                Rrn = rrn,
                AuthorizationCode = data.Value<string>("authCode") ?? data.Value<string>("authorizationCode"),
                PaymentMethodChannel = isCard ? "Card" : "Qr"
            };
        }

        private static bool TryGetTerminalId(string content, out string terminalId)
        {
            terminalId = null;
            if (string.IsNullOrWhiteSpace(content))
            {
                return false;
            }

            try
            {
                JObject root = JObject.Parse(content);
                JToken data = root["data"] ?? root;
                terminalId = data.Value<string>("terminalId") ?? root.Value<string>("terminalId");
                return !string.IsNullOrWhiteSpace(terminalId);
            }
            catch
            {
                return false;
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
