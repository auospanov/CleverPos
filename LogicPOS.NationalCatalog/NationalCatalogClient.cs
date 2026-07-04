using LogicPOS.NationalCatalog.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace LogicPOS.NationalCatalog
{
    public class NationalCatalogClient
    {
        private readonly string _baseUrl;
        private readonly string _apiKey;
        private readonly HttpClient _httpClient;

        public NationalCatalogClient(string baseUrl, string apiKey)
        {
            _baseUrl = NormalizeBaseUrl(baseUrl);
            _apiKey = apiKey ?? string.Empty;
            _httpClient = new HttpClient { Timeout = TimeSpan.FromSeconds(60) };
        }

        public string BaseUrl => _baseUrl;

        public bool HasApiKey => !string.IsNullOrWhiteSpace(_apiKey);

        public string MaskedApiKey
        {
            get
            {
                if (string.IsNullOrWhiteSpace(_apiKey))
                {
                    return "(пусто)";
                }

                if (_apiKey.Length <= 8)
                {
                    return "****";
                }

                return _apiKey.Substring(0, 4) + "…" + _apiKey.Substring(_apiKey.Length - 4);
            }
        }

        /// <summary>
        /// API is served under /gwp on nationalcatalog.kz; bare host returns the SPA HTML.
        /// </summary>
        internal static string NormalizeBaseUrl(string baseUrl)
        {
            string url = (baseUrl ?? "https://nationalcatalog.kz/gwp").Trim().TrimEnd('/');
            if (string.Equals(url, "https://nationalcatalog.kz", System.StringComparison.OrdinalIgnoreCase)
                || string.Equals(url, "http://nationalcatalog.kz", System.StringComparison.OrdinalIgnoreCase)
                || string.Equals(url, "https://nct.kz", System.StringComparison.OrdinalIgnoreCase)
                || string.Equals(url, "http://nct.kz", System.StringComparison.OrdinalIgnoreCase))
            {
                return url + "/gwp";
            }

            return url;
        }

        public async Task<NktCreateRequestResponse> CreateRequestAsync(NktProductRequestPayload payload, CancellationToken cancellationToken = default)
        {
            return await SendJsonAsync<NktCreateRequestResponse>(
                HttpMethod.Post,
                "/portal/api/v1/products/requests",
                payload,
                cancellationToken).ConfigureAwait(false);
        }

        public async Task UpdateRequestAsync(long requestId, NktProductRequestPayload payload, CancellationToken cancellationToken = default)
        {
            await SendJsonAsync<object>(
                HttpMethod.Put,
                $"/portal/api/v1/products/requests/{requestId}",
                payload,
                cancellationToken).ConfigureAwait(false);
        }

        public async Task SendToModerationAsync(long requestId, CancellationToken cancellationToken = default)
        {
            await SendJsonAsync<object>(
                HttpMethod.Put,
                $"/portal/api/v1/products/requests/{requestId}/moderation",
                null,
                cancellationToken).ConfigureAwait(false);
        }

        public async Task<NktStatusResponse> GetStatusAsync(long requestId, CancellationToken cancellationToken = default)
        {
            return await SendJsonAsync<NktStatusResponse>(
                HttpMethod.Get,
                $"/portal/api/v1/products/requests/{requestId}/status",
                null,
                cancellationToken).ConfigureAwait(false);
        }

        public async Task PublishAsync(long requestId, CancellationToken cancellationToken = default)
        {
            await SendJsonAsync<object>(
                HttpMethod.Put,
                $"/portal/api/v1/products/requests/{requestId}/publish",
                null,
                cancellationToken).ConfigureAwait(false);
        }

        public async Task<NktRequestDetailsResponse> GetRequestDetailsAsync(long requestId, CancellationToken cancellationToken = default)
        {
            return await SendJsonAsync<NktRequestDetailsResponse>(
                HttpMethod.Get,
                $"/portal/api/v1/products/requests/{requestId}/details",
                null,
                cancellationToken).ConfigureAwait(false);
        }

        public async Task<NktRequestListResponse> ListRequestsAsync(int page, int size, string status = null, CancellationToken cancellationToken = default)
        {
            string url = $"/portal/api/v1/products/requests?page={page}&size={size}";
            if (!string.IsNullOrWhiteSpace(status))
            {
                url += "&status=" + Uri.EscapeDataString(status);
            }

            return await SendJsonAsync<NktRequestListResponse>(
                HttpMethod.Get,
                url,
                null,
                cancellationToken).ConfigureAwait(false);
        }

        public async Task<List<NktAttributeDefinition>> GetAttributesAsync(string oktru, CancellationToken cancellationToken = default)
        {
            string url = "/portal/api/v1/products/requests/attributes?oktru=" + Uri.EscapeDataString(oktru ?? string.Empty);
            List<NktAttributeDefinition> items = await SendJsonAsync<List<NktAttributeDefinition>>(
                HttpMethod.Get,
                url,
                null,
                cancellationToken).ConfigureAwait(false);

            return items ?? new List<NktAttributeDefinition>();
        }

        public async Task<List<NktDictionaryItem>> GetDictionaryRootsAsync(string dictionaryCode, CancellationToken cancellationToken = default)
        {
            List<NktDictionaryItem> items = await SendJsonAsync<List<NktDictionaryItem>>(
                HttpMethod.Get,
                $"/portal/api/v1/dictionaries/{Uri.EscapeDataString(dictionaryCode)}/roots",
                null,
                cancellationToken).ConfigureAwait(false);

            return items ?? new List<NktDictionaryItem>();
        }

        public async Task<IReadOnlyList<NktDictionaryItem>> GetDictionaryChildrenAsync(string dictionaryCode, long parentId, CancellationToken cancellationToken = default)
        {
            List<NktDictionaryItem> items = await SendJsonAsync<List<NktDictionaryItem>>(
                HttpMethod.Get,
                $"/portal/api/v1/dictionaries/{Uri.EscapeDataString(dictionaryCode)}/children/{parentId}",
                null,
                cancellationToken).ConfigureAwait(false);

            return items ?? new List<NktDictionaryItem>();
        }

        public async Task<NktDictionaryItemsPage> GetDictionaryItemsAsync(string dictionaryCode, int page, int size, CancellationToken cancellationToken = default)
        {
            string url = $"/portal/api/v1/dictionaries/{Uri.EscapeDataString(dictionaryCode)}/items?page={page}&size={size}";
            string body = await SendRawAsync(HttpMethod.Get, url, null, cancellationToken).ConfigureAwait(false);
            if (string.IsNullOrWhiteSpace(body))
            {
                return new NktDictionaryItemsPage { Content = new List<NktDictionaryItem>() };
            }

            try
            {
                JToken token = JToken.Parse(body);
                if (token.Type == JTokenType.Array)
                {
                    return new NktDictionaryItemsPage
                    {
                        Content = token.ToObject<List<NktDictionaryItem>>() ?? new List<NktDictionaryItem>(),
                        TotalPages = page
                    };
                }

                NktDictionaryItemsPage pageResult = token.ToObject<NktDictionaryItemsPage>();
                if (pageResult?.Content == null)
                {
                    pageResult = pageResult ?? new NktDictionaryItemsPage();
                    pageResult.Content = new List<NktDictionaryItem>();
                }

                return pageResult;
            }
            catch (JsonException ex)
            {
                throw NationalCatalogApiException.FromParseError(HttpMethod.Get, _baseUrl + url, body, ex);
            }
        }

        private async Task<string> SendRawAsync(HttpMethod method, string relativePath, object payload, CancellationToken cancellationToken)
        {
            string fullUrl = _baseUrl + relativePath;
            string requestBody = null;

            using (HttpRequestMessage request = new HttpRequestMessage(method, fullUrl))
            {
                request.Headers.TryAddWithoutValidation("X-API-KEY", _apiKey);

                if (payload != null)
                {
                    requestBody = JsonConvert.SerializeObject(payload);
                    request.Content = new StringContent(requestBody, Encoding.UTF8, "application/json");
                }

                using (HttpResponseMessage response = await _httpClient.SendAsync(request, cancellationToken).ConfigureAwait(false))
                {
                    string body = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                    if (!response.IsSuccessStatusCode)
                    {
                        throw NationalCatalogApiException.FromHttpError(method, fullUrl, requestBody, (int)response.StatusCode, body);
                    }

                    return body;
                }
            }
        }

        private async Task<T> SendJsonAsync<T>(HttpMethod method, string relativePath, object payload, CancellationToken cancellationToken)
        {
            string fullUrl = _baseUrl + relativePath;
            string requestBody = null;

            using (HttpRequestMessage request = new HttpRequestMessage(method, fullUrl))
            {
                request.Headers.TryAddWithoutValidation("X-API-KEY", _apiKey);

                if (payload != null)
                {
                    requestBody = JsonConvert.SerializeObject(payload);
                    request.Content = new StringContent(requestBody, Encoding.UTF8, "application/json");
                }

                using (HttpResponseMessage response = await _httpClient.SendAsync(request, cancellationToken).ConfigureAwait(false))
                {
                    string body = await response.Content.ReadAsStringAsync().ConfigureAwait(false);

                    if (!response.IsSuccessStatusCode)
                    {
                        throw NationalCatalogApiException.FromHttpError(method, fullUrl, requestBody, (int)response.StatusCode, body);
                    }

                    if (typeof(T) == typeof(object) || string.IsNullOrWhiteSpace(body))
                    {
                        return default;
                    }

                    try
                    {
                        return JsonConvert.DeserializeObject<T>(body);
                    }
                    catch (JsonException ex)
                    {
                        throw NationalCatalogApiException.FromParseError(method, fullUrl, body, ex);
                    }
                }
            }
        }
    }

    public class NationalCatalogApiException : Exception
    {
        public string Method { get; }
        public string Url { get; }
        public string RequestBody { get; }
        public int? StatusCode { get; }
        public string ResponseBody { get; }

        public NationalCatalogApiException(
            string message,
            string method,
            string url,
            string requestBody,
            int? statusCode,
            string responseBody,
            Exception innerException = null)
            : base(message, innerException)
        {
            Method = method;
            Url = url;
            RequestBody = requestBody;
            StatusCode = statusCode;
            ResponseBody = responseBody;
        }

        public static NationalCatalogApiException FromHttpError(
            HttpMethod method,
            string url,
            string requestBody,
            int statusCode,
            string responseBody)
        {
            string message = BuildMessage(method.Method, url, requestBody, statusCode, responseBody, null);
            return new NationalCatalogApiException(message, method.Method, url, requestBody, statusCode, responseBody);
        }

        public static NationalCatalogApiException FromParseError(
            HttpMethod method,
            string url,
            string responseBody,
            Exception parseError)
        {
            string message = BuildMessage(method.Method, url, null, null, responseBody, parseError.Message);
            return new NationalCatalogApiException(message, method.Method, url, null, null, responseBody, parseError);
        }

        private static string BuildMessage(
            string method,
            string url,
            string requestBody,
            int? statusCode,
            string responseBody,
            string parseError)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(parseError ?? string.Format("NKT API HTTP {0}", statusCode));
            sb.AppendLine();
            sb.AppendLine("Запрос:");
            sb.Append(method).Append(' ').AppendLine(url);
            sb.AppendLine("Header: X-API-KEY: <nationalCatalogApiKey из App.config>");
            if (!string.IsNullOrWhiteSpace(requestBody))
            {
                sb.Append("Body: ").AppendLine(Truncate(requestBody, 400));
            }

            sb.AppendLine();
            sb.AppendLine("curl:");
            sb.Append("curl -X ").Append(method)
                .Append(" -H \"X-API-KEY: YOUR_API_KEY\"");
            if (!string.IsNullOrWhiteSpace(requestBody))
            {
                sb.Append(" -H \"Content-Type: application/json\" -d '")
                    .Append(Truncate(requestBody.Replace("'", "'\\''"), 300))
                    .Append("'");
            }

            sb.Append(" \"").Append(url).AppendLine("\"");

            if (statusCode.HasValue)
            {
                sb.AppendLine();
                sb.Append("HTTP ").AppendLine(statusCode.Value.ToString());
            }

            if (!string.IsNullOrWhiteSpace(responseBody))
            {
                sb.Append("Ответ: ").Append(Truncate(responseBody, 300));
            }

            return sb.ToString().TrimEnd();
        }

        private static string Truncate(string value, int max)
        {
            if (string.IsNullOrEmpty(value) || value.Length <= max)
            {
                return value;
            }

            return value.Substring(0, max) + "...";
        }
    }
}
