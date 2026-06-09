using System.Text;
using CleverApp.Services;
using Microsoft.Maui.Devices;

namespace CleverApp
{
    public partial class ScanPage : ContentPage
    {
        public ScanPage()
        {
            InitializeComponent();
        }

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

                var scanner = Application.Current?.Handler?.MauiContext?.Services.GetService<IIdDocumentScanner>();
                if (scanner is not null)
                {
                    buffer.Position = 0;
                    var ml = await scanner.ScanAsync(buffer, CancellationToken.None).ConfigureAwait(true);
                    if (ShouldPreferMlKitResult(ml))
                    {
                        resultLabel.Text = FormatMlKitScanResult(ml);
                        return;
                    }
                }

                var rawResult = PhotoBarcodeZxing.DecodePdf417(buffer.ToArray());
                if (!string.IsNullOrWhiteSpace(rawResult))
                {
                    var parsed = ParsePdf417Data(rawResult);
                    resultLabel.Text = BuildResultText(rawResult, parsed);
                    return;
                }

                resultLabel.Text = DeviceInfo.Current.Platform == DevicePlatform.Android
                    ? "ML Kit и ZXing не распознали PDF417 на этом снимке. Попробуйте ближе к свету, без бликов, штрихкод целиком в кадре."
                    : "PDF417 не найден (на этой платформе ML Kit не подключён — только Android).";
            }
            catch (Exception ex)
            {
                resultLabel.Text = ex.Message;
            }
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

        private static string FormatMlKitScanResult(IdScanResult ml)
        {
            var sb = new StringBuilder();

            sb.AppendLine($"Источник: {ml.Source}");
            sb.AppendLine();

            var sourceText = "";

            if (!string.IsNullOrWhiteSpace(ml.OcrText))
                sourceText = ml.OcrText;

            if (string.IsNullOrWhiteSpace(sourceText) &&
                !string.IsNullOrWhiteSpace(ml.MrzBlock))
                sourceText = ml.MrzBlock;

            if (string.IsNullOrWhiteSpace(sourceText) &&
                !string.IsNullOrWhiteSpace(ml.MrzLine))
                sourceText = ml.MrzLine;

            var parsed = ParseMrzFromOcr(sourceText);

            if (!string.IsNullOrWhiteSpace(parsed.IIN))
                sb.AppendLine($"ИИН: {parsed.IIN}");

            if (!string.IsNullOrWhiteSpace(parsed.FullName))
                sb.AppendLine($"ФИО: {parsed.FullName}");

            sb.AppendLine();
            sb.AppendLine("=== OCR ===");
            sb.AppendLine(ml.OcrText ?? "");

            return sb.ToString();
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
                    var digits = new string(line
                        .Where(char.IsDigit)
                        .ToArray());

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

        private static IdData ParseSimpleMrzLikeData(string raw)
        {
            var result = new IdData();

            if (string.IsNullOrWhiteSpace(raw))
                return result;

            var lines = raw
                .Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries)
                .Select(x => x.Trim())
                .Where(x => !string.IsNullOrWhiteSpace(x))
                .ToList();

            for (int i = 0; i < lines.Count; i++)
            {
                var line = lines[i]
                    .Replace(" ", "")
                    .Replace("«", "<")
                    .Replace("‹", "<");

                if (line.Contains("KAZ"))
                {
                    var kazIndex = line.IndexOf("KAZ", StringComparison.Ordinal);

                    if (kazIndex > 0)
                    {
                        var beforeKaz = line.Substring(0, kazIndex);
                        var digits = new string(beforeKaz.Where(char.IsDigit).ToArray());

                        if (digits.Length >= 12)
                            result.IIN = digits.Substring(0, 12);
                    }

                    if (i + 1 < lines.Count)
                    {
                        var nameLine = lines[i + 1]
                            .Replace("0", "O")
                            .Replace("1", "I")
                            .Replace("8", "B")
                            .Replace("v", "V")
                            .Replace("«", "<")
                            .Replace("‹", "<")
                            .Trim();

                        if (nameLine.Contains("<<"))
                        {
                            var parts = nameLine.Split(new[] { "<<" }, StringSplitOptions.None);

                            var lastName = parts.Length > 0 ? parts[0] : "";
                            var firstName = parts.Length > 1 ? parts[1] : "";

                            lastName = new string(lastName
                                .Where(c => char.IsLetter(c) && c <= 127)
                                .ToArray())
                                .ToUpper();

                            firstName = new string(firstName
                                .Where(c => char.IsLetter(c) && c <= 127)
                                .ToArray())
                                .ToUpper();

                            result.FullName = $"{lastName} {firstName}".Trim();
                        }
                    }

                    break;
                }
            }

            return result;
        }

        private static string FormatMlKitScanResultOld(IdScanResult ml)
        {
            var sb = new StringBuilder();
            sb.AppendLine($"Источник: {ml.Source}");

            if (!string.IsNullOrWhiteSpace(ml.Pdf417Raw))
            {
                var parsed = ParsePdf417Data(ml.Pdf417Raw);
                sb.AppendLine();
                sb.AppendLine("— PDF417 (ML Kit) —");
                if (!string.IsNullOrWhiteSpace(parsed.IIN))
                    sb.AppendLine($"ИИН: {parsed.IIN}");
                if (!string.IsNullOrWhiteSpace(parsed.FullName))
                    sb.AppendLine($"ФИО: {parsed.FullName}");
                sb.AppendLine("Сырые данные PDF417:");
                sb.AppendLine(ml.Pdf417Raw);
            }

            if (!string.IsNullOrWhiteSpace(ml.MrzBlock))
            {
                sb.AppendLine();
                sb.AppendLine("— MRZ TD1 (по OCR, 3×30) —");
                sb.AppendLine(ml.MrzBlock.Trim());
            }
            else if (!string.IsNullOrWhiteSpace(ml.MrzLine))
            {
                sb.AppendLine();
                sb.AppendLine("— MRZ (по OCR, одна строка) —");
                sb.AppendLine(ml.MrzLine);
            }

            if (!string.IsNullOrWhiteSpace(ml.MrzSurnameLatin) || !string.IsNullOrWhiteSpace(ml.MrzGivenNamesLatin))
            {
                sb.AppendLine();
                sb.AppendLine("— MRZ: фамилия / имя (латиница, 3-я строка) —");
                if (!string.IsNullOrWhiteSpace(ml.MrzSurnameLatin))
                    sb.AppendLine($"Фамилия: {ml.MrzSurnameLatin}");
                if (!string.IsNullOrWhiteSpace(ml.MrzGivenNamesLatin))
                    sb.AppendLine($"Имя(а): {ml.MrzGivenNamesLatin}");
            }

            if (!string.IsNullOrWhiteSpace(ml.OcrText))
            {
                sb.AppendLine();
                sb.AppendLine("— OCR (ML Kit) —");
                sb.AppendLine(
                    "На удостоверении и латиница, и кириллица. У on-device ML Kit отдельные OCR-модели " +
                    "только для латиницы, китайского, деванагари, японского и корейского; отдельной кириллической модели нет, " +
                    "поэтому русские/казахские строки часто превращаются в «похожие» латинские буквы, а мелкий текст и латиницу " +
                    "может портить блик/фокус. Для точных полей опирайтесь на PDF417 и MRZ.");
                sb.AppendLine(ml.OcrText.Trim());
            }

            return sb.ToString();
        }

        private static string BuildResultText(string raw, IdData parsed)
        {
            var sb = new StringBuilder();
            sb.AppendLine("PDF417 найден (ZXing fallback)");

            if (!string.IsNullOrWhiteSpace(parsed.IIN))
                sb.AppendLine($"ИИН: {parsed.IIN}");

            if (!string.IsNullOrWhiteSpace(parsed.FullName))
                sb.AppendLine($"ФИО: {parsed.FullName}");

            sb.AppendLine();
            sb.AppendLine("Сырые данные:");
            sb.Append(raw);
            return sb.ToString();
        }

        public static IdCardResult ParseMrz(string mrzBlock)
        {
            var result = new IdCardResult();

            var lines = mrzBlock
                .Split('\n', StringSplitOptions.RemoveEmptyEntries)
                .Select(x => x.Trim())
                .ToList();

            if (lines.Count < 2)
                return result;

            var dataLine = lines[1];
            var digits = new string(dataLine.Where(char.IsDigit).ToArray());
            if (digits.Length >= 12)
                result.IIN = digits.Substring(0, 12);

            var nameLine = lines.Last();
            var parts = nameLine.Split("<<");

            result.LastName = parts.Length > 0 ? parts[0].Replace("<", "") : "";
            result.FirstName = parts.Length > 1 ? parts[1].Replace("<", "") : "";

            return result;
        }

        public static IdCardResult ParsePdf417(string raw)
        {
            var result = new IdCardResult();

            var parts = raw.Split(new[] { '\n', '|', ';' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (var p in parts)
            {
                var clean = p.Trim();

                if (clean.Length == 12 && clean.All(char.IsDigit))
                    result.IIN = clean;

                if (clean.Contains("<<"))
                {
                    var nameParts = clean.Split("<<");
                    result.LastName = nameParts[0].Replace("<", "");
                    if (nameParts.Length > 1)
                        result.FirstName = nameParts[1].Replace("<", "");
                }
            }

            return result;
        }

        private string BuildFinalResult(IdScanResult ml)
        {
            IdCardResult? parsed = null;

            if (!string.IsNullOrWhiteSpace(ml.Pdf417Raw))
                parsed = ParsePdf417(ml.Pdf417Raw);
            else if (!string.IsNullOrWhiteSpace(ml.MrzBlock))
                parsed = ParseMrz(ml.MrzBlock);
            else
                return "❌ Не удалось распознать документ";

            var sb = new StringBuilder();

            sb.AppendLine("✔ Документ распознан");
            sb.AppendLine();

            if (!string.IsNullOrWhiteSpace(parsed.IIN))
                sb.AppendLine($"ИИН: {parsed.IIN}");

            if (!string.IsNullOrWhiteSpace(parsed.LastName))
                sb.AppendLine($"Фамилия: {parsed.LastName}");

            if (!string.IsNullOrWhiteSpace(parsed.FirstName))
                sb.AppendLine($"Имя: {parsed.FirstName}");

            return sb.ToString();
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

    public class IdData
    {
        public string? IIN { get; set; }
        public string? FullName { get; set; }
    }

    public class IdCardResult
    {
        public string? IIN { get; set; }
        public string? LastName { get; set; }
        public string? FirstName { get; set; }
        public string? DocumentNumber { get; set; }
        public DateTime? BirthDate { get; set; }
    }
}
