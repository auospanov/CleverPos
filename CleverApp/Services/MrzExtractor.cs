using System.Text;
using System.Text.RegularExpressions;

namespace CleverApp.Services;

public static class MrzExtractor
{
    private static readonly Regex MrzChars = new(@"^[A-Z0-9<]+$", RegexOptions.Compiled);

    /// <summary>Нормализация строки OCR для MRZ: убрать пробелы и мусорные символы вокруг.</summary>
    public static string NormalizeMrzCandidate(string line)
    {
        var t = line.Trim();
        t = Regex.Replace(t, @"\s+", "");
        return t.ToUpperInvariant();
    }

    /// <summary>Оценка «полезности» текста для MRZ: длина + бонус за TD1-блок.</summary>
    public static int MrzQualityScore(string? ocrText)
    {
        if (string.IsNullOrWhiteSpace(ocrText))
            return 0;

        var score = Math.Min(ocrText.Length, 4000);
        if (TryFindMrzTd1Block(ocrText) is not null)
            score += 500;
        else if (TryFindMrzLine(ocrText) is not null)
            score += 120;

        return score;
    }

    /// <summary>Выбор лучшего из двух OCR по MRZ-качеству.</summary>
    public static string? PickBetterOcr(string? a, string? b)
    {
        if (string.IsNullOrWhiteSpace(b))
            return string.IsNullOrWhiteSpace(a) ? null : a;
        if (string.IsNullOrWhiteSpace(a))
            return b;

        var sa = MrzQualityScore(a);
        var sb = MrzQualityScore(b);
        if (sb > sa + 8)
            return b;
        if (sa > sb + 8)
            return a;

        return b!.Length > a!.Length ? b : a;
    }

    /// <summary>Ищет одну строку MRZ (≥30 символов A-Z0-9&lt;).</summary>
    public static string? TryFindMrzLine(string? ocrText)
    {
        if (string.IsNullOrWhiteSpace(ocrText))
            return null;

        foreach (var raw in ocrText.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries))
        {
            var t = NormalizeMrzCandidate(raw);
            if (t.Length < 30)
                continue;
            var head = t[..30];
            if (MrzChars.IsMatch(head))
                return head;
        }

        return null;
    }

    /// <summary>Ищет блок TD1: три последовательные строки по 30 символов A-Z0-9&lt;.</summary>
    public static string? TryFindMrzTd1Block(string? ocrText)
    {
        if (string.IsNullOrWhiteSpace(ocrText))
            return null;

        var normalized = ocrText
            .Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries)
            .Select(NormalizeMrzCandidate)
            .Where(s => s.Length > 0)
            .ToList();

        for (var i = 0; i + 2 < normalized.Count; i++)
        {
            var a = TakeMrz30(normalized[i]);
            var b = TakeMrz30(normalized[i + 1]);
            var c = TakeMrz30(normalized[i + 2]);
            if (a is null || b is null || c is null)
                continue;
            if (!MrzChars.IsMatch(a) || !MrzChars.IsMatch(b) || !MrzChars.IsMatch(c))
                continue;

            // TD1: первая строка часто начинается с I< или ID (OCR может дать лишние символы в начале)
            var sb = new StringBuilder();
            sb.AppendLine(a);
            sb.AppendLine(b);
            sb.AppendLine(c);
            return sb.ToString().TrimEnd();
        }

        return null;
    }

    private static string? TakeMrz30(string s)
    {
        if (s.Length < 30)
            return null;
        var head = s[..30];
        return MrzChars.IsMatch(head) ? head : null;
    }
}
