using System.Security.Claims;
using System.Text.Json.Serialization;
using CleverPos.License.Api.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CleverPos.License.Api.Controllers;

[ApiController]
[Route("api/owner")]
public class OwnerAuthController : ControllerBase
{
    private readonly OwnerAuthService _auth;

    public OwnerAuthController(OwnerAuthService auth)
    {
        _auth = auth;
    }

    [HttpPost("auth/google")]
    [AllowAnonymous]
    public async Task<IActionResult> Google([FromBody] GoogleAuthRequest request, CancellationToken ct)
    {
        if (string.IsNullOrWhiteSpace(request.IdToken))
        {
            return BadRequest(new { message = "idToken required" });
        }

        try
        {
            var result = await _auth.SignInWithGoogleAsync(request.IdToken, ct).ConfigureAwait(false);
            if (result == null)
            {
                return Unauthorized(new { message = "Google token invalid" });
            }

            await SignInOwnerCookieAsync(result.Value.Owner).ConfigureAwait(false);
            return Ok(ToAuthResponse(result.Value.Owner, result.Value.Jwt));
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    [HttpPost("auth/apple")]
    [AllowAnonymous]
    public async Task<IActionResult> Apple([FromBody] AppleAuthRequest request, CancellationToken ct)
    {
        if (string.IsNullOrWhiteSpace(request.IdToken))
        {
            return BadRequest(new { message = "idToken required" });
        }

        try
        {
            string? display = string.Join(" ", new[] { request.FirstName, request.LastName }
                .Where(s => !string.IsNullOrWhiteSpace(s))).Trim();
            if (string.IsNullOrWhiteSpace(display))
            {
                display = request.Name;
            }

            var result = await _auth.SignInWithAppleAsync(
                    request.IdToken,
                    request.Email,
                    display,
                    ct)
                .ConfigureAwait(false);
            if (result == null)
            {
                return Unauthorized(new { message = "Apple token invalid" });
            }

            await SignInOwnerCookieAsync(result.Value.Owner).ConfigureAwait(false);
            return Ok(ToAuthResponse(result.Value.Owner, result.Value.Jwt));
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    [HttpPost("auth/telegram")]
    [AllowAnonymous]
    public async Task<IActionResult> Telegram([FromBody] TelegramAuthPayload request, CancellationToken ct)
    {
        try
        {
            var result = await _auth.SignInWithTelegramAsync(request, ct).ConfigureAwait(false);
            if (result == null)
            {
                return Unauthorized(new { message = "Telegram auth invalid" });
            }

            await SignInOwnerCookieAsync(result.Value.Owner).ConfigureAwait(false);
            return Ok(ToAuthResponse(result.Value.Owner, result.Value.Jwt));
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    [HttpGet("me")]
    [Authorize(AuthenticationSchemes = OwnerAuthService.OwnerCookieScheme + "," + OwnerAuthService.OwnerJwtScheme)]
    public async Task<IActionResult> Me(CancellationToken ct)
    {
        if (!TryGetOwnerId(out Guid ownerId))
        {
            return Unauthorized();
        }

        var owner = await _auth.GetOwnerAsync(ownerId, ct).ConfigureAwait(false);
        if (owner == null)
        {
            return Unauthorized();
        }

        return Ok(new
        {
            owner.Id,
            owner.Email,
            owner.DisplayName,
            owner.Provider,
            owner.AvatarUrl,
            licenses = owner.LicenseLinks.Select(l => new
            {
                l.LicenseId,
                l.License.LicenseKey,
                l.License.CompanyName,
                l.License.Bin,
                l.Role,
                l.LinkedAtUtc
            })
        });
    }

    [HttpPost("licenses/link")]
    [Authorize(AuthenticationSchemes = OwnerAuthService.OwnerCookieScheme + "," + OwnerAuthService.OwnerJwtScheme)]
    public async Task<IActionResult> LinkLicense([FromBody] LinkLicenseRequest request, CancellationToken ct)
    {
        if (!TryGetOwnerId(out Guid ownerId))
        {
            return Unauthorized();
        }

        (bool ok, string message) = await _auth.LinkLicenseAsync(ownerId, request.LicenseKey ?? string.Empty, ct)
            .ConfigureAwait(false);
        if (!ok)
        {
            return BadRequest(new { message });
        }

        return Ok(new { message });
    }

    [HttpPost("logout")]
    [Authorize(AuthenticationSchemes = OwnerAuthService.OwnerCookieScheme + "," + OwnerAuthService.OwnerJwtScheme)]
    public async Task<IActionResult> Logout()
    {
        await HttpContext.SignOutAsync(OwnerAuthService.OwnerCookieScheme).ConfigureAwait(false);
        return Ok(new { message = "ok" });
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

    private bool TryGetOwnerId(out Guid ownerId)
    {
        ownerId = Guid.Empty;
        string? id = User.FindFirstValue(ClaimTypes.NameIdentifier);
        return Guid.TryParse(id, out ownerId);
    }

    private static object ToAuthResponse(Models.OwnerAccount owner, string jwt) => new
    {
        token = jwt,
        owner = new
        {
            owner.Id,
            owner.Email,
            owner.DisplayName,
            owner.Provider,
            owner.AvatarUrl
        }
    };
}

public class GoogleAuthRequest
{
    [JsonPropertyName("idToken")]
    public string IdToken { get; set; } = string.Empty;
}

public class AppleAuthRequest
{
    [JsonPropertyName("idToken")]
    public string IdToken { get; set; } = string.Empty;

    [JsonPropertyName("email")]
    public string? Email { get; set; }

    [JsonPropertyName("name")]
    public string? Name { get; set; }

    [JsonPropertyName("firstName")]
    public string? FirstName { get; set; }

    [JsonPropertyName("lastName")]
    public string? LastName { get; set; }
}

public class LinkLicenseRequest
{
    [JsonPropertyName("licenseKey")]
    public string LicenseKey { get; set; } = string.Empty;
}
