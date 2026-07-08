using System.Text;
using System.Text.Json;
using System.Text.RegularExpressions;

namespace CleverApp.Services.VisitorJournal;

internal static class VisitorJournalCurlBuilder
{
    public static string Build(
        string method,
        string url,
        IReadOnlyDictionary<string, string> headers,
        string? body,
        bool maskSecrets = true)
    {
        var safeBody = maskSecrets ? MaskSecretsInBody(body) : body;
        var sb = new StringBuilder();
        sb.Append("curl -X ").Append(method.ToUpperInvariant());
        sb.Append(" \"").Append(url).Append('"');

        foreach (var header in headers)
        {
            var value = maskSecrets ? MaskHeaderValue(header.Key, header.Value) : header.Value;
            sb.Append(" -H \"").Append(header.Key).Append(": ").Append(EscapeForShell(value)).Append('"');
        }

        if (!string.IsNullOrWhiteSpace(safeBody))
            sb.Append(" -d \"").Append(EscapeForShell(safeBody)).Append('"');

        return sb.ToString();
    }

    public static void Log(string curl)
    {
        const string prefix = "[VisitorJournal CURL] ";
        System.Diagnostics.Debug.WriteLine(prefix + curl);
        Console.WriteLine(prefix + curl);
    }

    private static string MaskHeaderValue(string name, string value)
    {
        if (name.Equals("Authorization", StringComparison.OrdinalIgnoreCase) &&
            value.StartsWith("Bearer ", StringComparison.OrdinalIgnoreCase))
        {
            var token = value["Bearer ".Length..];
            if (token.Length <= 12)
                return "Bearer ***";
            return $"Bearer {token[..6]}...{token[^4..]}";
        }

        return value;
    }

    private static string? MaskSecretsInBody(string? body)
    {
        if (string.IsNullOrWhiteSpace(body))
            return body;

        try
        {
            using var doc = JsonDocument.Parse(body);
            if (doc.RootElement.ValueKind != JsonValueKind.Object)
                return body;

            var dict = new Dictionary<string, object?>();
            foreach (var prop in doc.RootElement.EnumerateObject())
            {
                if (prop.Name.Equals("password", StringComparison.OrdinalIgnoreCase))
                    dict[prop.Name] = "***";
                else
                    dict[prop.Name] = prop.Value.ValueKind switch
                    {
                        JsonValueKind.String => prop.Value.GetString(),
                        JsonValueKind.Number => prop.Value.GetRawText(),
                        JsonValueKind.True => true,
                        JsonValueKind.False => false,
                        _ => prop.Value.GetRawText()
                    };
            }

            return JsonSerializer.Serialize(dict);
        }
        catch
        {
            return Regex.Replace(body, @"""password""\s*:\s*""[^""]*""", @"""password"":""***""", RegexOptions.IgnoreCase);
        }
    }

    private static string EscapeForShell(string value) =>
        value.Replace("\\", "\\\\").Replace("\"", "\\\"");
}

internal sealed class VisitorJournalRequestException : Exception
{
    public string CurlCommand { get; }

    public VisitorJournalRequestException(string message, string curlCommand, Exception? inner = null)
        : base(message, inner)
    {
        CurlCommand = curlCommand;
    }
}
