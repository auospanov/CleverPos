namespace CleverApp
{
    public partial class MainPage : ContentPage
    {
        private CleverApp.Services.BarcodeServerDiscoveryService? _discovery;

        public MainPage()
        {
            InitializeComponent();
        }

        protected override void OnDisappearing()
        {
            base.OnDisappearing();
            _discovery?.Stop();
        }

        private void OnSearchServerClicked(object? sender, EventArgs e)
        {
            _discovery = Application.Current?.Handler?.MauiContext?.Services.GetService<CleverApp.Services.BarcodeServerDiscoveryService>();
            if (_discovery == null) return;

            _discovery.Stop();
            StatusLabel.Text = "Поиск сервера ...";
            ServerLabel.Text = "Сервер не найден";
            ServerLabel.IsVisible = false;

            _discovery.ServerFound -= OnServerFound;
            _discovery.ServerFound += OnServerFound;
            _discovery.Start();
        }
        private async void OnOpenScannerClicked(object sender, EventArgs e)
{
    await Navigation.PushAsync(new ScanPage());
}
        private void OnServerFound(object? sender, (string Ip, int Port) e)
        {
            StatusLabel.Text = "Сервер найден";
            ServerLabel.Text = $"Сервер: {e.Ip}:{e.Port}";
            ServerLabel.IsVisible = true;
        }
    }
}
