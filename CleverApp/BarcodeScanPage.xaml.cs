using CleverApp.Services;
using SkiaSharp;
using ZXing;
using ZXing.Common;

namespace CleverApp
{
    public partial class BarcodeScanPage : ContentPage
    {
        private readonly BarcodeSenderService _sender = new();
        private bool _isSending;
        private string? _pendingBarcode;

        public BarcodeScanPage()
        {
            InitializeComponent();
        }

        private async void OnScanClicked(object? sender, EventArgs e)
        {
            if (_isSending) return;

            if (!await CameraPermissionHelper.EnsureGrantedAsync(this))
                return;

            try
            {
                _pendingBarcode = null;
                SendBtn.IsEnabled = false;
                BarcodeLabel.Text = "Штрихкод: —";
                StatusLabel.Text = "Сканирование...";
                PreviewImage.IsVisible = false;

                var photo = await MediaPicker.CapturePhotoAsync();
                if (photo == null)
                {
                    StatusLabel.Text = "Сканирование отменено";
                    return;
                }

                await using var readStream = await photo.OpenReadAsync();
                using var buffer = new MemoryStream();
                await readStream.CopyToAsync(buffer);
                var imageBytes = buffer.ToArray();

                using var original = SKBitmap.Decode(imageBytes);
                if (original is null)
                {
                    StatusLabel.Text = "Ошибка изображения";
                    return;
                }

                PreviewImage.Source = ImageSource.FromStream(() => new MemoryStream(imageBytes));
                PreviewImage.IsVisible = true;

                const int targetWidth = 1200;
                var targetHeight = Math.Max(400, (int)(original.Height * (targetWidth / (double)original.Width)));
                using var resized = original.Resize(new SKImageInfo(targetWidth, targetHeight), SKFilterQuality.High);

                if (resized is null)
                {
                    StatusLabel.Text = "Ошибка обработки изображения";
                    return;
                }

                var barcode = TryDecodeBarcode(resized);
                if (string.IsNullOrWhiteSpace(barcode))
                {
                    StatusLabel.Text = "Штрихкод не распознан. Снимите ближе, без бликов, штрихкод целиком в кадре.";
                    return;
                }

                _pendingBarcode = barcode.Trim();
                BarcodeLabel.Text = $"Штрихкод: {_pendingBarcode}";
                StatusLabel.Text = "Распознано. Нажмите «Отправить на сервер».";
                SendBtn.IsEnabled = true;
            }
            catch (Exception ex)
            {
                StatusLabel.Text = ex.Message;
            }
        }

        private static string? TryDecodeBarcode(SKBitmap bitmap)
        {
            var reader = new MultiFormatReader
            {
                Hints = new Dictionary<DecodeHintType, object>
                {
                    {
                        DecodeHintType.POSSIBLE_FORMATS, new List<BarcodeFormat>
                        {
                            BarcodeFormat.EAN_13,
                            BarcodeFormat.EAN_8,
                            BarcodeFormat.CODE_128,
                            BarcodeFormat.CODE_39,
                            BarcodeFormat.QR_CODE,
                            BarcodeFormat.UPC_A,
                            BarcodeFormat.UPC_E,
                            BarcodeFormat.ITF
                        }
                    },
                    { DecodeHintType.TRY_HARDER, true },
                    { DecodeHintType.ALSO_INVERTED, true },
                    { DecodeHintType.PURE_BARCODE, false }
                }
            };

            var zones = new[]
            {
                new SKRectI(0, 0, bitmap.Width, bitmap.Height),
                new SKRectI(0, bitmap.Height / 3, bitmap.Width, bitmap.Height * 2 / 3),
                new SKRectI(0, bitmap.Height / 2, bitmap.Width, bitmap.Height)
            };

            foreach (var zone in zones)
            {
                using var cropped = Crop(bitmap, zone);
                var decoded = Decode(reader, cropped, invert: false) ?? Decode(reader, cropped, invert: true);
                if (!string.IsNullOrWhiteSpace(decoded))
                    return decoded;
            }

            return null;
        }

        private static SKBitmap Crop(SKBitmap source, SKRectI rect)
        {
            var width = Math.Max(1, rect.Width);
            var height = Math.Max(1, rect.Height);
            var cropped = new SKBitmap(width, height);

            using var canvas = new SKCanvas(cropped);
            canvas.DrawBitmap(
                source,
                new SKRect(rect.Left, rect.Top, rect.Right, rect.Bottom),
                new SKRect(0, 0, width, height));

            return cropped;
        }

        private static string? Decode(MultiFormatReader reader, SKBitmap bitmap, bool invert)
        {
            try
            {
                var pixels = bitmap.Pixels;
                var rgb = new byte[bitmap.Width * bitmap.Height * 3];

                for (var i = 0; i < pixels.Length; i++)
                {
                    var r = pixels[i].Red;
                    var g = pixels[i].Green;
                    var b = pixels[i].Blue;

                    if (invert)
                    {
                        r = (byte)(255 - r);
                        g = (byte)(255 - g);
                        b = (byte)(255 - b);
                    }

                    var offset = i * 3;
                    rgb[offset] = r;
                    rgb[offset + 1] = g;
                    rgb[offset + 2] = b;
                }

                var source = new RGBLuminanceSource(rgb, bitmap.Width, bitmap.Height);
                var binaryBitmap = new BinaryBitmap(new HybridBinarizer(source));
                var result = reader.decode(binaryBitmap);
                return result?.Text;
            }
            catch
            {
                return null;
            }
        }

        private async void OnSendClicked(object? sender, EventArgs e)
        {
            if (_isSending || string.IsNullOrWhiteSpace(_pendingBarcode)) return;

            if (!DiscoveredServerStore.HasServer)
            {
                await DisplayAlert("Ошибка", "Сервер не найден. Сначала найдите сервер.", "OK");
                return;
            }

            _isSending = true;
            ScanBtn.IsEnabled = false;
            SendBtn.IsEnabled = false;
            StatusLabel.Text = "Отправка на сервер...";

            try
            {
                using var cts = new CancellationTokenSource(TimeSpan.FromSeconds(10));
                var result = await _sender.SendAsync(
                    DiscoveredServerStore.Ip,
                    DiscoveredServerStore.Port,
                    _pendingBarcode,
                    cts.Token).ConfigureAwait(true);

                if (result.Success)
                {
                    await DisplayAlert("Готово", $"Штрихкод отправлен на сервер:\n{_pendingBarcode}", "OK");
                    await Navigation.PopAsync();
                    return;
                }

                var msg = result.ErrorMessage ?? "Не удалось отправить штрихкод на сервер.";
                StatusLabel.Text = msg;
                await DisplayAlert("Ошибка отправки", msg, "OK");
            }
            catch (Exception ex)
            {
                StatusLabel.Text = $"Ошибка: {ex.Message}";
                await DisplayAlert("Ошибка", ex.Message, "OK");
            }
            finally
            {
                _isSending = false;
                if (Navigation.NavigationStack.LastOrDefault() == this)
                {
                    ScanBtn.IsEnabled = true;
                    SendBtn.IsEnabled = !string.IsNullOrWhiteSpace(_pendingBarcode);
                }
            }
        }

        private async void OnBackClicked(object? sender, EventArgs e)
        {
            await Navigation.PopAsync();
        }
    }
}
