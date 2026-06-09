using CleverApp.Services;
using Microsoft.Maui.Devices;
using ZXing.Net.Maui;

namespace CleverApp
{
    public partial class LiveBarcodeScanPage : ContentPage
    {
        private readonly BarcodeSenderService _sender = new();
        private bool _isSending;
        private string? _pendingBarcode;
        private bool _scanLineAnimating;
        private volatile bool _detectionHandled;

        public LiveBarcodeScanPage()
        {
            InitializeComponent();
            ConfigureReaderOptions();
        }

        private void ConfigureReaderOptions()
        {
#if IOS
            cameraBarcodeReaderView.Options = new BarcodeReaderOptions
            {
                Formats = BarcodeFormats.OneDimensional,
                AutoRotate = true,
                Multiple = false,
                TryHarder = true
            };
#else
            cameraBarcodeReaderView.Options = new BarcodeReaderOptions
            {
                Formats = BarcodeFormats.OneDimensional,
                AutoRotate = true,
                Multiple = false
            };
#endif
        }

        protected override async void OnAppearing()
        {
            base.OnAppearing();
            _isSending = false;
            _detectionHandled = false;
            _pendingBarcode = null;
            SendBtn.IsEnabled = false;
            RescanBtn.IsEnabled = false;
            ResultLabel.Text = "";
            ResultLabel.IsVisible = false;
            StatusLabel.Text = "Запуск камеры...";
            cameraBarcodeReaderView.IsVisible = true;

            if (!await CameraPermissionHelper.EnsureGrantedAsync(this))
            {
                await Navigation.PopAsync();
                return;
            }

            var delay = DeviceInfo.Platform == DevicePlatform.iOS ? 700 : 400;
            await Task.Delay(delay);
            StartDetecting();
        }

        protected override void OnDisappearing()
        {
            StopScanLineAnimation();
            cameraBarcodeReaderView.IsDetecting = false;
            base.OnDisappearing();
        }

        private void StartDetecting()
        {
            _detectionHandled = false;
            _pendingBarcode = null;
            SendBtn.IsEnabled = false;
            RescanBtn.IsEnabled = false;
            ResultLabel.Text = "";
            ResultLabel.IsVisible = false;
            StatusLabel.Text = "Наведите штрихкод на рамку";
            ScanLine.TranslationY = 0;
            cameraBarcodeReaderView.IsVisible = true;
            cameraBarcodeReaderView.IsDetecting = true;
            StartScanLineAnimation();
        }

        private void StartScanLineAnimation()
        {
            if (_scanLineAnimating) return;
            _scanLineAnimating = true;
            AnimateScanLineLoop();
        }

        private void StopScanLineAnimation()
        {
            _scanLineAnimating = false;
            ScanLine.AbortAnimation("ScanLineLoop");
        }

        private void AnimateScanLineLoop()
        {
            if (!_scanLineAnimating || !cameraBarcodeReaderView.IsDetecting)
            {
                _scanLineAnimating = false;
                return;
            }

            const double frameHeight = 200;
            const uint duration = 1800;

            ScanLine.TranslationY = 0;
            var animation = new Animation(
                v => ScanLine.TranslationY = v,
                0,
                frameHeight - 3,
                Easing.Linear);

            animation.Commit(
                ScanLine,
                "ScanLineLoop",
                16,
                duration,
                finished: (_, cancelled) =>
                {
                    if (!cancelled && _scanLineAnimating && cameraBarcodeReaderView.IsDetecting)
                        AnimateScanLineLoop();
                    else
                        _scanLineAnimating = false;
                });
        }

        private void BarcodesDetected(object? sender, BarcodeDetectionEventArgs e)
        {
            if (_detectionHandled || _isSending) return;

            var result = e.Results?.FirstOrDefault();
            if (result == null || string.IsNullOrWhiteSpace(result.Value)) return;

            // Только одно срабатывание — иначе сотни событий блокируют UI
            _detectionHandled = true;
            var barcode = result.Value.Trim();

            MainThread.BeginInvokeOnMainThread(() => ApplyDetectedBarcode(barcode));
        }

        private void ApplyDetectedBarcode(string barcode)
        {
            if (_isSending) return;

            _pendingBarcode = barcode;
            cameraBarcodeReaderView.IsDetecting = false;
            StopScanLineAnimation();

            ResultLabel.Text = barcode;
            ResultLabel.IsVisible = true;
            StatusLabel.Text = "Распознано. Нажмите «Отправить на сервер».";
            SendBtn.IsEnabled = true;
            RescanBtn.IsEnabled = true;
        }

        private void OnTorchClicked(object? sender, EventArgs e)
        {
            cameraBarcodeReaderView.IsTorchOn = !cameraBarcodeReaderView.IsTorchOn;
            TorchBtn.Text = cameraBarcodeReaderView.IsTorchOn ? "Выключить вспышку" : "Вспышка";
        }

        private void OnRescanClicked(object? sender, EventArgs e)
        {
            if (_isSending) return;
            StartDetecting();
        }

        private async void OnSendClicked(object? sender, EventArgs e)
        {
            if (_isSending || string.IsNullOrWhiteSpace(_pendingBarcode)) return;

            if (!DiscoveredServerStore.HasServer)
            {
                await DisplayAlert("Ошибка", "Сервер не найден. Сначала найдите сервер или подключитесь по IP.", "OK");
                return;
            }

            _isSending = true;
            StopScanLineAnimation();
            cameraBarcodeReaderView.IsDetecting = false;
            SendBtn.IsEnabled = false;
            RescanBtn.IsEnabled = false;
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
                    SendBtn.IsEnabled = !string.IsNullOrWhiteSpace(_pendingBarcode);
                    RescanBtn.IsEnabled = !string.IsNullOrWhiteSpace(_pendingBarcode);
                }
            }
        }

        private async void OnBackClicked(object? sender, EventArgs e)
        {
            cameraBarcodeReaderView.IsDetecting = false;
            await Navigation.PopAsync();
        }
    }
}
