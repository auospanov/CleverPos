using CleverApp.Configuration;
using CleverApp.Services.VisitorJournal;

namespace CleverApp;

public partial class LoginPage : ContentPage
{
    private VisitorJournalService VisitorJournal =>
        Application.Current?.Handler?.MauiContext?.Services.GetService<VisitorJournalService>()
        ?? new VisitorJournalService();

    public LoginPage()
    {
        InitializeComponent();
        ApiUrlLabel.Text = $"API ({AppConfig.ApiEnvironment}): {AppConfig.ApiBaseUrl}";
    }

    private void OnTogglePasswordVisibility(object? sender, EventArgs e)
    {
        PasswordEntry.IsPassword = !PasswordEntry.IsPassword;
        TogglePasswordBtn.Text = PasswordEntry.IsPassword ? "👁" : "🙈";
    }

    private async void OnLoginClicked(object? sender, EventArgs e)
    {
        ErrorLabel.IsVisible = false;

        var login = LoginEntry.Text?.Trim() ?? string.Empty;
        var password = PasswordEntry.Text ?? string.Empty;
        if (string.IsNullOrWhiteSpace(login) || string.IsNullOrWhiteSpace(password))
        {
            ShowError("Введите логин и пароль.");
            return;
        }

        var result = await VisitorJournal.LoginAsync(login, password);
        if (!result.Success)
        {
            ShowError(result.ErrorMessage ?? "Ошибка входа.");
            return;
        }

        Application.Current!.MainPage = new NavigationPage(new VisitorHomePage());
    }

    private void ShowError(string message)
    {
        ErrorLabel.Text = message;
        ErrorLabel.IsVisible = true;
    }
}
