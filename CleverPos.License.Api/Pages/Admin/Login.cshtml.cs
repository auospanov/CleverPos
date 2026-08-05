using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CleverPos.License.Api.Pages.Admin;

[AllowAnonymous]
public class LoginModel : PageModel
{
    private readonly IConfiguration _configuration;

    public LoginModel(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    [BindProperty]
    public string AdminKey { get; set; } = string.Empty;

    public string? ErrorMessage { get; set; }

    public void OnGet()
    {
    }

    public async Task<IActionResult> OnPostAsync()
    {
        string expected = _configuration["AdminApiKey"] ?? string.Empty;
        if (string.IsNullOrWhiteSpace(expected) || !string.Equals(expected, AdminKey, StringComparison.Ordinal))
        {
            ErrorMessage = "Неверный ключ администратора.";
            return Page();
        }

        var claims = new List<Claim>
        {
            new(ClaimTypes.Name, "admin"),
            new(ClaimTypes.Role, "Admin")
        };
        var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
        await HttpContext.SignInAsync(
            CookieAuthenticationDefaults.AuthenticationScheme,
            new ClaimsPrincipal(identity));

        return RedirectToPage("/Admin/Index");
    }
}
