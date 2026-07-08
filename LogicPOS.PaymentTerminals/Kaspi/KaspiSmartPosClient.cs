using Newtonsoft.Json.Linq;
using System;
using System.Globalization;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace LogicPOS.PaymentTerminals.Kaspi
{
    public class KaspiSmartPosClient
    {
        private readonly string _baseUrl;
        private readonly bool _useHttps;
        private readonly bool _ignoreSslErrors;
        private readonly HttpClient _httpClient;

        public KaspiSmartPosClient(string host, int port, bool useHttps, bool ignoreSslErrors)
        {
            if (string.IsNullOrWhiteSpace(host))
            {
                throw new ArgumentException("Host is required", nameof(host));
            }

            if (port <= 0)
            {
                port = 8080;
            }

            _useHttps = useHttps;
            _ignoreSslErrors = ignoreSslErrors;
            string scheme = useHttps ? "https" : "http";
            _baseUrl = $"{scheme}://{host.Trim()}:{port}";

            HttpClientHandler handler = new HttpClientHandler();
            if (ignoreSslErrors)
            {
                handler.ServerCertificateCustomValidationCallback = (message, cert, chain, errors) => true;
            }

            _httpClient = new HttpClient(handler)
            {
                Timeout = TimeSpan.FromSeconds(30)
            };
        }

        public string BaseUrl => _baseUrl;

        public async Task<KaspiRegisterResult> RegisterAsync(string clientName, CancellationToken cancellationToken = default)
        {
            if (string.IsNullOrWhiteSpace(clientName))
            {
                return new KaspiRegisterResult { Success = false, Message = "PosClientName is required" };
            }

            string url = $"{_baseUrl}/v2/register?name={Uri.EscapeDataString(clientName)}";
            string body = await SendAsync(HttpMethod.Get, url, null, cancellationToken).ConfigureAwait(false);
            KaspiApiResponse response = KaspiApiResponse.FromJson(body);

            if (!response.IsSuccess)
            {
                string message = response.ErrorText;
                if (response.Data != null)
                {
                    message = response.Data.Value<string>("message") ?? message;
                }

                return new KaspiRegisterResult { Success = false, Message = message ?? $"statusCode={response.StatusCode}" };
            }

            return new KaspiRegisterResult
            {
                Success = true,
                AccessToken = response.Data?.Value<string>("accessToken"),
                RefreshToken = response.Data?.Value<string>("refreshToken"),
                ExpirationDate = ParseKaspiDate(response.Data?.Value<string>("expirationDate")),
                Message = "OK"
            };
        }

        public async Task<KaspiRegisterResult> RevokeAsync(string clientName, string refreshToken, CancellationToken cancellationToken = default)
        {
            string url = $"{_baseUrl}/v2/revoke?name={Uri.EscapeDataString(clientName)}&refreshToken={Uri.EscapeDataString(refreshToken ?? string.Empty)}";
            string body = await SendAsync(HttpMethod.Get, url, null, cancellationToken).ConfigureAwait(false);
            KaspiApiResponse response = KaspiApiResponse.FromJson(body);

            if (!response.IsSuccess)
            {
                string message = response.ErrorText;
                if (response.Data != null)
                {
                    message = response.Data.Value<string>("message") ?? message;
                }

                return new KaspiRegisterResult { Success = false, Message = message ?? $"statusCode={response.StatusCode}" };
            }

            return new KaspiRegisterResult
            {
                Success = true,
                AccessToken = response.Data?.Value<string>("accessToken"),
                RefreshToken = response.Data?.Value<string>("refreshToken"),
                ExpirationDate = ParseKaspiDate(response.Data?.Value<string>("expirationDate")),
                Message = "OK"
            };
        }

        public async Task<KaspiPaymentStatusResult> StartPaymentAsync(string accessToken, int amountTiyn, bool ownCheque, CancellationToken cancellationToken = default)
        {
            string url = $"{_baseUrl}/v2/payment?amount={amountTiyn}&owncheque={ownCheque.ToString().ToLowerInvariant()}";
            string body = await SendAsync(HttpMethod.Get, url, accessToken, cancellationToken).ConfigureAwait(false);
            return ParseStatusResponse(body);
        }

        public async Task<KaspiPaymentStatusResult> GetStatusAsync(string accessToken, string processId, CancellationToken cancellationToken = default)
        {
            string url = $"{_baseUrl}/v2/status?processId={Uri.EscapeDataString(processId ?? string.Empty)}";
            string body = await SendAsync(HttpMethod.Get, url, accessToken, cancellationToken).ConfigureAwait(false);
            return ParseStatusResponse(body);
        }

        public async Task<KaspiPaymentStatusResult> WaitForPaymentAsync(
            string accessToken,
            string processId,
            int pollIntervalMs,
            int timeoutSeconds,
            Action<string> log,
            CancellationToken cancellationToken = default)
        {
            DateTime deadline = DateTime.UtcNow.AddSeconds(timeoutSeconds <= 0 ? 120 : timeoutSeconds);

            while (DateTime.UtcNow < deadline)
            {
                cancellationToken.ThrowIfCancellationRequested();

                KaspiPaymentStatusResult status = await GetStatusAsync(accessToken, processId, cancellationToken).ConfigureAwait(false);
                if (!status.Success && status.Status == null)
                {
                    log?.Invoke(status.Message ?? "Status request failed");
                    await Task.Delay(pollIntervalMs, cancellationToken).ConfigureAwait(false);
                    continue;
                }

                log?.Invoke(FormatStatusLine(status));

                if (string.Equals(status.Status, "success", StringComparison.OrdinalIgnoreCase))
                {
                    status.Success = true;
                    return status;
                }

                if (string.Equals(status.Status, "fail", StringComparison.OrdinalIgnoreCase))
                {
                    status.Success = false;
                    return status;
                }

                if (string.Equals(status.Status, "unknown", StringComparison.OrdinalIgnoreCase))
                {
                    status.Success = false;
                    status.Message = status.Message ?? "Transaction status unknown";
                    return status;
                }

                await Task.Delay(pollIntervalMs, cancellationToken).ConfigureAwait(false);
            }

            return new KaspiPaymentStatusResult
            {
                Success = false,
                ProcessId = processId,
                Status = "timeout",
                Message = "Payment timeout"
            };
        }

        public async Task<bool> ProbeAsync(CancellationToken cancellationToken = default)
        {
            try
            {
                string url = $"{_baseUrl}/v2/register?name={Uri.EscapeDataString("CleverPos-Probe")}";
                await SendAsync(HttpMethod.Get, url, null, cancellationToken, TimeSpan.FromSeconds(3)).ConfigureAwait(false);
                return true;
            }
            catch
            {
                return false;
            }
        }

        private async Task<string> SendAsync(HttpMethod method, string url, string accessToken, CancellationToken cancellationToken, TimeSpan? timeout = null)
        {
            using (HttpRequestMessage request = new HttpRequestMessage(method, url))
            {
                if (!string.IsNullOrWhiteSpace(accessToken))
                {
                    request.Headers.TryAddWithoutValidation("accesstoken", accessToken);
                }

                using (CancellationTokenSource linked = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken))
                {
                    if (timeout.HasValue)
                    {
                        linked.CancelAfter(timeout.Value);
                    }

                    using (HttpResponseMessage response = await _httpClient.SendAsync(request, linked.Token).ConfigureAwait(false))
                    {
                        string content = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                        if (!response.IsSuccessStatusCode && string.IsNullOrWhiteSpace(content))
                        {
                            throw new HttpRequestException($"HTTP {(int)response.StatusCode} {response.ReasonPhrase}");
                        }

                        return content;
                    }
                }
            }
        }

        private static KaspiPaymentStatusResult ParseStatusResponse(string body)
        {
            KaspiApiResponse response = KaspiApiResponse.FromJson(body);
            if (!response.IsSuccess)
            {
                string message = response.ErrorText;
                if (response.Data != null)
                {
                    message = response.Data.Value<string>("message") ?? message;
                }

                return new KaspiPaymentStatusResult
                {
                    Success = false,
                    Message = message ?? $"statusCode={response.StatusCode}"
                };
            }

            JObject data = response.Data;
            JObject chequeInfo = data?["chequeInfo"] as JObject;

            return new KaspiPaymentStatusResult
            {
                Success = true,
                ProcessId = data?.Value<string>("processId"),
                Status = data?.Value<string>("status"),
                SubStatus = data?.Value<string>("subStatus"),
                TransactionId = data?.Value<string>("transactionId"),
                Rrn = chequeInfo?.Value<string>("rrn"),
                AuthorizationCode = chequeInfo?.Value<string>("authorizationCode"),
                Message = data?.Value<string>("message")
            };
        }

        private static string FormatStatusLine(KaspiPaymentStatusResult status)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(status.Status ?? "?");
            if (!string.IsNullOrWhiteSpace(status.SubStatus))
            {
                sb.Append(" / ").Append(status.SubStatus);
            }

            if (!string.IsNullOrWhiteSpace(status.Message))
            {
                sb.Append(": ").Append(status.Message);
            }

            return sb.ToString();
        }

        private static DateTime? ParseKaspiDate(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                return null;
            }

            if (DateTime.TryParse(value, CultureInfo.InvariantCulture, DateTimeStyles.AssumeLocal, out DateTime parsed))
            {
                return parsed;
            }

            return null;
        }

        public static int ConvertAmountToTiyn(decimal amount)
        {
            return (int)Math.Round(amount * 100m, MidpointRounding.AwayFromZero);
        }
    }
}
