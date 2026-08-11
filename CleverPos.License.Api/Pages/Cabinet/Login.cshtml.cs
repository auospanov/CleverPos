using CleverPos.License.Api.Options;
using CleverPos.License.Api.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Options;

namespace CleverPos.License.Api.Pages.Cabinet;

public class LoginModel : PageModel
{
    private readonly OwnerAuthOptions _options;

    public LoginModel(IOptions<OwnerAuthOptions> options)
    {
        _options = options.Value;
    }

    public string? ErrorMessage { get; set; }
    public string GoogleClientId => _options.GoogleClientId;
    public string AppleClientId => _options.AppleClientId;
    public string TelegramBotUsername => _options.TelegramBotUsername;
    public string AppleRedirectUri =>
        (_options.CabinetPublicOrigin ?? "https://cabinet.dominium.kz").TrimEnd('/') + "/cabinet/login";

    public async Task<IActionResult> OnGetAsync()
    {
        AuthenticateResult auth = await HttpContext.AuthenticateAsync(OwnerAuthService.OwnerCookieScheme)
            .ConfigureAwait(false);
        if (auth.Succeeded)
        {
            return RedirectToPage("/Cabinet/Index");
        }

        return Page();
    }
}
