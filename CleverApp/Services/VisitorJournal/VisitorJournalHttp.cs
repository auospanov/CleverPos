using System.Net;
using System.Text;
using System.Text.RegularExpressions;

namespace CleverApp.Services.VisitorJournal;

internal static class VisitorJournalHttp
{
    private static readonly HttpClient HttpClient = CreateHttpClient();

    public static string? LastCurlCommand { get; private set; }

    public sealed class HttpResponse
    {
        public int StatusCode { get; init; }
        public string Body { get; init; } = string.Empty;
        public string CurlCommand { get; init; } = string.Empty;
    }

    public static async Task<HttpResponse> SendAsync(
        string baseUrl,
        string method,
        string path,
        string? body,
        string? contentType,
        string? bearerToken = null,
        CancellationToken cancellationToken = default)
    {
        var url = CombineUrl(baseUrl, path);
        var headers = new Dictionary<string, string>
        {
            ["Accept"] = "application/json"
        };

        if (!string.IsNullOrWhiteSpace(bearerToken))
            headers["Authorization"] = $"Bearer {bearerToken}";

        var mediaType = string.IsNullOrWhiteSpace(contentType)
            ? "application/json"
            : contentType.Split(';')[0].Trim();

        if (!string.IsNullOrWhiteSpace(body))
            headers["Content-Type"] = mediaType;

        var curl = VisitorJournalCurlBuilder.Build(method, url, headers, body, maskSecrets: true);
        LastCurlCommand = curl;
        VisitorJournalCurlBuilder.Log(curl);

        try
        {
            using var request = new HttpRequestMessage(new HttpMethod(method), url);
            request.Headers.TryAddWithoutValidation("Accept", "application/json");

            if (!string.IsNullOrWhiteSpace(bearerToken))
                request.Headers.TryAddWithoutValidation("Authorization", $"Bearer {bearerToken}");

            if (!string.IsNullOrWhiteSpace(body))
                request.Content = new StringContent(body, Encoding.UTF8, mediaType);

            using var response = await HttpClient.SendAsync(request, cancellationToken).ConfigureAwait(false);
            var responseBody = await response.Content.ReadAsStringAsync(cancellationToken).ConfigureAwait(false);

            LogHttpResult(url, (int)response.StatusCode, responseBody);

            return new HttpResponse
            {
                StatusCode = (int)response.StatusCode,
                Body = responseBody.Trim(),
                CurlCommand = curl
            };
        }
        catch (Exception ex)
        {
            var message = DescribeException(ex);

            System.Diagnostics.Debug.WriteLine($"[VisitorJournal] FAIL {url}: {message}");
            Console.WriteLine($"[VisitorJournal] FAIL {url}: {message}");
            VisitorJournalCurlBuilder.Log(curl);

            throw new VisitorJournalRequestException($"Ошибка соединения: {message}", curl, ex);
        }
    }

    private static HttpClient CreateHttpClient()
    {
        HttpMessageHandler handler;
#if ANDROID
        handler = new Xamarin.Android.Net.AndroidMessageHandler();
#else
        handler = new HttpClientHandler
        {
            AutomaticDecompression = DecompressionMethods.GZip | DecompressionMethods.Deflate
        };
#endif

        return new HttpClient(handler)
        {
            Timeout = TimeSpan.FromSeconds(30)
        };
    }

    private static void LogHttpResult(string url, int statusCode, string body)
    {
        var preview = body.Length > 400 ? body[..400] + "..." : body;
        preview = Regex.Replace(preview, @"""accessToken""\s*:\s*""[^""]+""", @"""accessToken"":""***""", RegexOptions.IgnoreCase);
        preview = Regex.Replace(preview, @"""refreshToken""\s*:\s*""[^""]+""", @"""refreshToken"":""***""", RegexOptions.IgnoreCase);

        var line = $"[VisitorJournal] HTTP {statusCode} {url} | {preview}";
        System.Diagnostics.Debug.WriteLine(line);
        Console.WriteLine(line);
    }

    private static string DescribeException(Exception ex)
    {
        var parts = new List<string>();
        for (var current = ex; current != null; current = current.InnerException)
        {
            if (!string.IsNullOrWhiteSpace(current.Message))
                parts.Add(current.Message);
        }

        return parts.Count == 0 ? "неизвестная ошибка" : string.Join(" → ", parts);
    }

    private static string CombineUrl(string baseUrl, string path)
    {
        var normalizedBase = baseUrl.TrimEnd('/');
        var normalizedPath = path.StartsWith('/') ? path : "/" + path;
        return normalizedBase + normalizedPath;
    }
}
