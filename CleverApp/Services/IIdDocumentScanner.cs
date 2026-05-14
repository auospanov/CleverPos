namespace CleverApp.Services;

/// <summary>
/// Распознавание удостоверения с фото: PDF417 (ML Kit) и при необходимости OCR (ML Kit).
/// Реализация с ML Kit доступна только на Android.
/// </summary>
public interface IIdDocumentScanner
{
    /// <param name="imageStream">Поток изображения (JPEG/PNG и т.п.).</param>
    Task<IdScanResult> ScanAsync(Stream imageStream, System.Threading.CancellationToken cancellationToken = default);
}

public sealed class IdScanResult
{
    public string? Pdf417Raw { get; init; }
    public string? OcrText { get; init; }
    /// <summary>Кратко: PDF417, OCR, PDF417+OCR, None.</summary>
    public string Source { get; init; } = "None";
    /// <summary>Первая «сильная» строка MRZ (для эвристик) или первая строка блока TD1.</summary>
    public string? MrzLine { get; init; }
    /// <summary>TD1 MRZ: три строки по 30 символов (разделитель \n), если удалось собрать.</summary>
    public string? MrzBlock { get; init; }
    /// <summary>Разбор 3-й строки MRZ (фамилия / имя латиницей), если <see cref="MrzBlock"/> задан.</summary>
    public string? MrzSurnameLatin { get; init; }
    public string? MrzGivenNamesLatin { get; init; }
}
