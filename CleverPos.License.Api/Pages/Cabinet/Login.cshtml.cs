using System.Security.Claims;
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
    private readonly OwnerAuthService _auth;

    public LoginModel(IOptions<OwnerAuthOptions> options, OwnerAuthService auth)
    {
        _options = options.Value;
        _auth = auth;
    }

    public string? ErrorMessage { get; set; }
    public string GoogleClientId => _options.GoogleClientId;
    public string AppleClientId => _options.AppleClientId;
    public string TelegramBotUsername => _options.TelegramBotUsername;
    public string AppleRedirectUri => GoogleRedirectUri;
    public string GoogleRedirectUri
    {
        get
        {
            string host = Request.Host.Value ?? "api.dominium.kz";
            string scheme = Request.Headers["X-Forwarded-Proto"].FirstOrDefault() ?? Request.Scheme;
            if (host.Contains("dominium.kz", StringComparison.OrdinalIgnoreCase))
            {
                scheme = "https";
            }

            return $"{scheme}://{host}/cabinet/login";
        }
    }

    public async Task<IActionResult> OnGetAsync(string? code, string? state, string? error, CancellationToken ct)
    {
        AuthenticateResult cookie = await HttpContext.AuthenticateAsync(OwnerAuthService.OwnerCookieScheme)
            .ConfigureAwait(false);
        if (cookie.Succeeded)
        {
            return RedirectToPage("/Cabinet/Index");
        }

        if (!string.IsNullOrWhiteSpace(error))
        {
            ErrorMessage = "Ошибка входа: " + error;
            return Page();
        }

        // Same exchange as Famous Town: Google returns ?code=&state=google_signin
        if (!string.IsNullOrWhiteSpace(code)
            && (string.IsNullOrWhiteSpace(state) || state.StartsWith("google_signin", StringComparison.OrdinalIgnoreCase)))
        {
            try
            {
                var result = await _auth.SignInWithGoogleCodeAsync(code, GoogleRedirectUri, ct)
                    .ConfigureAwait(false);
                if (result == null)
                {
                    ErrorMessage = "Google: не удалось обменять код на токен. Проверьте ClientId/Secret и redirect URI.";
                    return Page();
                }

                await SignInOwnerCookieAsync(result.Value.Owner).ConfigureAwait(false);
                return RedirectToPage("/Cabinet/Index");
            }
            catch (Exception ex)
            {
                ErrorMessage = ex.Message;
                return Page();
            }
        }

        return Page();
    }

    private async Task SignInOwnerCookieAsync(Models.OwnerAccount owner)
    {
        ClaimsIdentity identity = new(_auth.BuildOwnerClaims(owner), OwnerAuthService.OwnerCookieScheme);
        await HttpContext.SignInAsync(
            OwnerAuthService.OwnerCookieScheme,
            new ClaimsPrincipal(identity),
            new AuthenticationProperties
            {
                IsPersistent = true,
                ExpiresUtc = DateTimeOffset.UtcNow.AddDays(7)
            }).ConfigureAwait(false);
    }
}
