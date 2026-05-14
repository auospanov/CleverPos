namespace CleverApp.Services;

/// <summary>Заглушка для платформ без нативного ML Kit (iOS, Windows, Mac Catalyst).</summary>
public sealed class UnsupportedIdDocumentScanner : IIdDocumentScanner
{
    public Task<IdScanResult> ScanAsync(Stream imageStream, System.Threading.CancellationToken cancellationToken = default)
    {
        _ = imageStream;
        return Task.FromResult(new IdScanResult
        {
            Source = "Unsupported",
            OcrText = "ML Kit (штрихкод + OCR) в этом проекте подключён только для Android. Соберите и запустите на устройстве с Android."
        });
    }
}
