using CleverApp.Services;
using ZXing;

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

                PreviewImage.Source = ImageSource.FromStream(() => new MemoryStream(imageBytes));
                PreviewImage.IsVisible = true;

                var barcode = PhotoBarcodeZxing.DecodeBarcodes(imageBytes, new List<BarcodeFormat>
                {
                    BarcodeFormat.EAN_13,
                    BarcodeFormat.EAN_8,
                    BarcodeFormat.CODE_128,
                    BarcodeFormat.CODE_39,
                    BarcodeFormat.QR_CODE,
                    BarcodeFormat.UPC_A,
                    BarcodeFormat.UPC_E,
                    BarcodeFormat.ITF
                });

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
