using System.Text;
using CleverApp.Services;
using CleverApp.Services.VisitorJournal;
using Microsoft.Maui.Devices;

namespace CleverApp
{
    public partial class ScanPage : ContentPage
    {
        private readonly int _visitReasonId;

        public ScanPage(int visitReasonId)
        {
            _visitReasonId = visitReasonId;
            InitializeComponent();
        }

        private VisitorJournalService VisitorJournal =>
            Application.Current?.Handler?.MauiContext?.Services.GetService<VisitorJournalService>()
            ?? new VisitorJournalService();

        private async void OnScanClicked(object sender, EventArgs e)
        {
            if (!await CameraPermissionHelper.EnsureGrantedAsync(this))
                return;

            try
            {
                resultLabel.Text = "Сканирование...";

                var photo = await MediaPicker.CapturePhotoAsync();
                if (photo == null)
                {
                    resultLabel.Text = "Сканирование отменено";
                    return;
                }

                await using var readStream = await photo.OpenReadAsync();
                using var buffer = new MemoryStream();
                await readStream.CopyToAsync(buffer);

                var scanned = await TryScanDocumentAsync(buffer).ConfigureAwait(true);
                if (scanned == null)
                {
                    resultLabel.Text = DeviceInfo.Current.Platform == DevicePlatform.Android
                        ? "ML Kit и ZXing не распознали PDF417 на этом снимке. Попробуйте ближе к свету, без бликов, штрихкод целиком в кадре."
                        : "PDF417 не найден (на этой платформе ML Kit не подключён — только Android).";
                    return;
                }

                var display = FormatScannedDisplay(scanned);
                resultLabel.Text = display + "\n\nОтправка в журнал посетителей...";

                var insertResult = await VisitorJournal.InsertVisitorAsync(
                    scanned.LastName ?? string.Empty,
                    scanned.FirstName ?? string.Empty,
                    scanned.MiddleName,
                    _visitReasonId).ConfigureAwait(true);

                resultLabel.Text = insertResult.Success
                    ? display + $"\n\n✔ Записано в журнал №{insertResult.Entry?.RowNumber} ({insertResult.Entry?.VisitReasonName})"
                    : display + $"\n\n✖ Журнал: {insertResult.ErrorMessage}";
            }
            catch (Exception ex)
            {
                resultLabel.Text = ex.Message;
            }
        }

        private async Task<ScannedIdData?> TryScanDocumentAsync(MemoryStream buffer)
        {
            IdScanResult? ml = null;
            var scanner = Application.Current?.Handler?.MauiContext?.Services.GetService<IIdDocumentScanner>();
            if (scanner is not null)
            {
                buffer.Position = 0;
                ml = await scanner.ScanAsync(buffer, CancellationToken.None).ConfigureAwait(false);
                if (ShouldPreferMlKitResult(ml))
                {
                    var fromMl = BuildScannedIdData(ml, null);
                    if (fromMl != null)
                        return fromMl;
                }
            }

            var rawResult = PhotoBarcodeZxing.DecodePdf417(buffer.ToArray());
            if (!string.IsNullOrWhiteSpace(rawResult))
            {
                var fromPdf = BuildScannedIdData(ml, rawResult);
                if (fromPdf != null)
                    return fromPdf;
            }

            if (ml != null)
                return BuildScannedIdData(ml, null);

            return null;
        }

        private static ScannedIdData? BuildScannedIdData(IdScanResult? ml, string? pdf417Raw)
        {
            var data = new ScannedIdData();

            if (ml != null)
            {
                var sourceText = ml.OcrText ?? ml.MrzBlock ?? ml.MrzLine ?? string.Empty;
                var parsed = ParseMrzFromOcr(sourceText);
                data.IIN = parsed.IIN;

                if (!string.IsNullOrWhiteSpace(ml.MrzSurnameLatin))
                    data.LastName = ml.MrzSurnameLatin.Trim().ToUpperInvariant();

                if (!string.IsNullOrWhiteSpace(ml.MrzGivenNamesLatin))
                    ApplyGivenNames(data, ml.MrzGivenNamesLatin);

                if (string.IsNullOrWhiteSpace(data.LastName) && !string.IsNullOrWhiteSpace(parsed.FullName))
                    ApplyFullName(data, parsed.FullName);
            }

            if (!string.IsNullOrWhiteSpace(pdf417Raw))
            {
                var pdf = ParsePdf417Data(pdf417Raw);
                if (string.IsNullOrWhiteSpace(data.IIN))
                    data.IIN = pdf.IIN;

                if (string.IsNullOrWhiteSpace(data.LastName) && !string.IsNullOrWhiteSpace(pdf.FullName))
                    ApplyFullName(data, pdf.FullName);
            }

            if (string.IsNullOrWhiteSpace(data.IIN))
                return null;

            if (string.IsNullOrWhiteSpace(data.LastName) && string.IsNullOrWhiteSpace(data.FirstName))
                return null;

            return data;
        }

        private static void ApplyGivenNames(ScannedIdData data, string givenNames)
        {
            var parts = givenNames.Trim().Split(' ', StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length == 0)
                return;

            data.FirstName = parts[0].ToUpperInvariant();
            if (parts.Length > 1)
                data.MiddleName = string.Join(' ', parts.Skip(1)).ToUpperInvariant();
        }

        private static void ApplyFullName(ScannedIdData data, string fullName)
        {
            var parts = fullName.Trim().Split(' ', StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length == 0)
                return;

            data.LastName = parts[0].ToUpperInvariant();
            if (parts.Length > 1)
                data.FirstName = parts[1].ToUpperInvariant();
            if (parts.Length > 2)
                data.MiddleName = string.Join(' ', parts.Skip(2)).ToUpperInvariant();
        }

        private static string FormatScannedDisplay(ScannedIdData data)
        {
            var sb = new StringBuilder();
            sb.AppendLine("✔ Документ распознан");
            sb.AppendLine();

            if (!string.IsNullOrWhiteSpace(data.IIN))
                sb.AppendLine($"ИИН: {data.IIN}");

            if (!string.IsNullOrWhiteSpace(data.LastName))
                sb.AppendLine($"Фамилия: {data.LastName}");

            if (!string.IsNullOrWhiteSpace(data.FirstName))
                sb.AppendLine($"Имя: {data.FirstName}");

            if (!string.IsNullOrWhiteSpace(data.MiddleName))
                sb.AppendLine($"Отчество: {data.MiddleName}");

            return sb.ToString().TrimEnd();
        }

        private static bool ShouldPreferMlKitResult(IdScanResult ml)
        {
            if (ml.Source == "Unsupported")
                return false;

            if (!string.IsNullOrWhiteSpace(ml.Pdf417Raw))
                return true;

            if (!string.IsNullOrWhiteSpace(ml.MrzLine))
                return true;

            if (!string.IsNullOrWhiteSpace(ml.MrzBlock))
                return true;

            if (!string.IsNullOrWhiteSpace(ml.MrzSurnameLatin) || !string.IsNullOrWhiteSpace(ml.MrzGivenNamesLatin))
                return true;

            if (!string.IsNullOrWhiteSpace(ml.OcrText) && ml.OcrText.Trim().Length >= 8)
                return true;

            return false;
        }

        private static IdData ParseMrzFromOcr(string raw)
        {
            var result = new IdData();

            if (string.IsNullOrWhiteSpace(raw))
                return result;

            var lines = raw
                .Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries)
                .Select(x => x.Trim())
                .Where(x => !string.IsNullOrWhiteSpace(x))
                .ToList();

            foreach (var lineRaw in lines)
            {
                var line = lineRaw
                    .Replace(" ", "")
                    .Replace("«", "<")
                    .Replace("‹", "<");

                if (line.StartsWith("IDKAZ", StringComparison.OrdinalIgnoreCase))
                {
                    var digits = new string(line.Where(char.IsDigit).ToArray());
                    if (digits.Length >= 12)
                        result.IIN = digits.Substring(digits.Length - 12);
                }

                if (line.Contains("<<"))
                {
                    var nameLine = line
                        .Replace("0", "O")
                        .Replace("«", "<")
                        .Replace("‹", "<");

                    var parts = nameLine.Split(new[] { "<<" }, StringSplitOptions.None);

                    if (parts.Length >= 2)
                    {
                        var lastName = new string(parts[0]
                            .Where(c => char.IsLetter(c) && c <= 127)
                            .ToArray())
                            .ToUpper();

                        var firstName = new string(parts[1]
                            .Where(c => char.IsLetter(c) && c <= 127)
                            .ToArray())
                            .ToUpper();

                        if (!string.IsNullOrWhiteSpace(lastName) &&
                            !string.IsNullOrWhiteSpace(firstName))
                        {
                            result.FullName = $"{lastName} {firstName}";
                        }
                    }
                }
            }

            return result;
        }

        private static IdData ParsePdf417Data(string raw)
        {
            var parts = raw.Split(new[] { '\n', '|', ';' },
                StringSplitOptions.RemoveEmptyEntries);

            var result = new IdData();

            foreach (var p in parts)
            {
                var clean = p.Trim();

                if (clean.Length == 12 && clean.All(char.IsDigit))
                    result.IIN = clean;

                if (clean.Contains("<<", StringComparison.Ordinal))
                    result.FullName = clean.Replace("<", " ", StringComparison.Ordinal);

                if (clean.Split(' ', StringSplitOptions.RemoveEmptyEntries).Length >= 2 && result.FullName is null)
                    result.FullName = clean;
            }

            return result;
        }
    }

    public sealed class ScannedIdData
    {
        public string? IIN { get; set; }
        public string? LastName { get; set; }
        public string? FirstName { get; set; }
        public string? MiddleName { get; set; }
    }

    public class IdData
    {
        public string? IIN { get; set; }
        public string? FullName { get; set; }
    }
}
