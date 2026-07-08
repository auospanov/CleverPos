using CleverApp.Services;
using CleverApp.Services.VisitorJournal;

namespace CleverApp;

public partial class VisitorHomePage : ContentPage
{
    private List<VisitReasonDto> _reasons = new();

    private VisitorJournalService VisitorJournal =>
        Application.Current?.Handler?.MauiContext?.Services.GetService<VisitorJournalService>()
        ?? new VisitorJournalService();

    public VisitorHomePage()
    {
        InitializeComponent();
        WelcomeLabel.Text = string.IsNullOrWhiteSpace(VisitorSessionStore.Username)
            ? "Добро пожаловать"
            : $"Добро пожаловать, {VisitorSessionStore.Username}";
    }

    protected override async void OnAppearing()
    {
        base.OnAppearing();

        if (!VisitorSessionStore.IsAuthenticated)
        {
            Application.Current!.MainPage = new NavigationPage(new LoginPage());
            return;
        }

        await LoadReasonsAsync();
    }

    private async Task LoadReasonsAsync()
    {
        _reasons = (await VisitorJournal.GetReasonsAsync()).OrderBy(r => r.SortOrder).ThenBy(r => r.Id).ToList();
        ReasonPicker.ItemsSource = _reasons.Select(r => r.Name).ToList();

        if (_reasons.Count > 0)
            ReasonPicker.SelectedIndex = 0;
    }

    private async void OnScanIdClicked(object? sender, EventArgs e)
    {
        if (_reasons.Count == 0)
        {
            await DisplayAlert("Справочник", "Не удалось загрузить причины визита.", "OK");
            return;
        }

        if (ReasonPicker.SelectedIndex < 0)
        {
            await DisplayAlert("Справочник", "Выберите причину визита.", "OK");
            return;
        }

        if (!await CameraPermissionHelper.EnsureGrantedAsync(this))
            return;

        var reasonId = _reasons[ReasonPicker.SelectedIndex].Id;
        await Navigation.PushAsync(new ScanPage(reasonId));
    }

    private async void OnLogoutClicked(object? sender, EventArgs e)
    {
        var confirm = await DisplayAlert("Выход", "Выйти из учётной записи?", "Да", "Нет");
        if (!confirm)
            return;

        VisitorJournal.Logout();
        Application.Current!.MainPage = new NavigationPage(new LoginPage());
    }
}
