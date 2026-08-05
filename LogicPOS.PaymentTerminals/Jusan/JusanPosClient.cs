using Newtonsoft.Json.Linq;
using System;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace LogicPOS.PaymentTerminals.Jusan
{
    /// <summary>
    /// Jusan / Jysan Smart POS — same protocol as ShopUchet frmPosTerminalProcess.SendJusan.
    /// POST http://{host}:8080/  {"task":"purchase","data":{"amount": &lt;tenge&gt;}}
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
            string body = "{\"task\":\"refund\",\"data\":{\"amount\":" + amountTenge + ",\"tagRRN\":\"" + Escape(tagRrn) + "\"}}";
            return await SendTaskAsync(body, cancellationToken).ConfigureAwait(false);
        }

        public async Task<PaymentTerminalTestResult> ProbeAsync(CancellationToken cancellationToken = default)
        {
            try
            {
                using (HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get, _baseUrl))
                using (HttpResponseMessage response = await _httpClient.SendAsync(request, cancellationToken).ConfigureAwait(false))
                {
                    string content = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                    return new PaymentTerminalTestResult
                    {
                        Success = true,
                        Message = string.Format("Jusan ответил HTTP {0}: {1}", (int)response.StatusCode, Truncate(content, 200))
                    };
                }
            }
            catch (Exception ex)
            {
                return new PaymentTerminalTestResult
                {
                    Success = false,
                    Message = "Нет связи с Jusan: " + GetInnermostMessage(ex)
                };
            }
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
            int resultCode = data.Value<int?>("result") ?? -1;
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
                AuthorizationCode = data.Value<string>("authCode") ?? data.Value<string>("authorizationCode")
            };
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
