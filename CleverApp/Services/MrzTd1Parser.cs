namespace CleverApp.Services;

/// <summary>Разбор 3-й строки TD1 MRZ: <c>SURNAME&lt;&lt;GIVEN&lt;NAMES&lt;&lt;&lt;...</c></summary>
public static class MrzTd1Parser
{
    public static (string? Surname, string? GivenNames) TryParseLine3(string? line30)
    {
        if (string.IsNullOrWhiteSpace(line30) || line30.Length < 3)
            return (null, null);

        var s = line30.Trim();
        if (s.Length > 30)
            s = s[..30];

        var sep = "<<";
        var idx = s.IndexOf(sep, StringComparison.Ordinal);
        if (idx < 1)
            return (null, null);

        var surname = s[..idx].Replace('<', ' ').Trim();
        var rest = s[(idx + sep.Length)..];
        var given = rest.Replace('<', ' ').Trim();
        if (string.IsNullOrEmpty(surname))
            return (null, null);

        return (surname, string.IsNullOrEmpty(given) ? null : given);
    }
}
