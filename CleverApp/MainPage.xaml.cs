using System.Net;
using CleverApp.Services;

namespace CleverApp
{
    public partial class MainPage : ContentPage
    {
        private BarcodeServerDiscoveryService? _discovery;

        public MainPage()
        {
            InitializeComponent();
        }

        protected override void OnAppearing()
        {
            base.OnAppearing();

            _discovery = Application.Current?.Handler?.MauiContext?.Services.GetService<BarcodeServerDiscoveryService>();
            if (_discovery != null)
            {
                _discovery.ServerFound -= OnServerFound;
                _discovery.ServerFound += OnServerFound;
                _discovery.DiscoveryFailed -= OnDiscoveryFailed;
                _discovery.DiscoveryFailed += OnDiscoveryFailed;
            }

            if (DiscoveredServerStore.HasServer)
            {
                StatusLabel.Text = "Сервер подключён";
                ServerLabel.Text = $"IP ПК: {DiscoveredServerStore.Ip}";
                ServerLabel.IsVisible = true;
            }
        }

        private void OnSearchServerClicked(object? sender, EventArgs e)
        {
            if (_discovery == null)
            {
                _discovery = Application.Current?.Handler?.MauiContext?.Services.GetService<BarcodeServerDiscoveryService>();
            }
            if (_discovery == null) return;

            StatusLabel.Text = "Поиск сервера...";
            ServerLabel.Text = "Слушаем UDP broadcast с ПК (порт 8888)";
            ServerLabel.IsVisible = true;

            _discovery.Stop();
            _discovery.ServerFound -= OnServerFound;
            _discovery.ServerFound += OnServerFound;
            _discovery.DiscoveryFailed -= OnDiscoveryFailed;
            _discovery.DiscoveryFailed += OnDiscoveryFailed;
            _discovery.Start();
        }

        private void OnManualConnectClicked(object? sender, EventArgs e)
        {
            var ip = ManualIpEntry.Text?.Trim();
            if (string.IsNullOrEmpty(ip) || !IPAddress.TryParse(ip, out _))
            {
                DisplayAlert("IP адрес", "Введите корректный IP, например 192.168.1.10", "OK");
                return;
            }

            // Без HTTP-запроса: только сохраняем IP (как после UDP broadcast)
            RegisterServer(ip);
        }

        private async Task OpenPageWithCameraAsync(Func<ContentPage> createPage, bool requireServer)
        {
            if (requireServer && !DiscoveredServerStore.HasServer)
            {
                await DisplayAlert("Сервер не найден", "Сначала нажмите «Найти сервер» или подключитесь по IP.", "OK");
                return;
            }

            if (!await CameraPermissionHelper.EnsureGrantedAsync(this))
                return;

            await Navigation.PushAsync(createPage());
        }

        private async void OnLiveBarcodeClicked(object? sender, EventArgs e)
        {
            await OpenPageWithCameraAsync(() => new LiveBarcodeScanPage(), requireServer: true);
        }

        private async void OnScanBarcodeClicked(object? sender, EventArgs e)
        {
            await OpenPageWithCameraAsync(() => new BarcodeScanPage(), requireServer: true);
        }

        private async void OnOpenScannerClicked(object sender, EventArgs e)
        {
            await OpenPageWithCameraAsync(() => new ScanPage(), requireServer: false);
        }

        private void OnServerFound(object? sender, (string Ip, int Port) e)
        {
            // UDP broadcast прислал IP — дальше то же, что «Подключить по IP»
            RegisterServer(e.Ip);
        }

        /// <summary>
        /// Общий метод для UDP-поиска и ручного IP. HTTP (порт 5000) — только при отправке штрихкода.
        /// </summary>
        private void RegisterServer(string ip)
        {
            DiscoveredServerStore.Set(ip, DiscoveredServerStore.DefaultHttpPort);
            StatusLabel.Text = "Сервер подключён";
            ServerLabel.Text = $"IP ПК: {ip}";
            ServerLabel.IsVisible = true;
        }

        private void OnDiscoveryFailed(object? sender, string message)
        {
            StatusLabel.Text = "Сервер не найден";
            ServerLabel.Text = message;
            ServerLabel.IsVisible = true;
        }
    }
}
