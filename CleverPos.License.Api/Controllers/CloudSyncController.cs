using CleverPos.License.Api.Services;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CleverPos.License.Api.Controllers;

[ApiController]
[Route("api/cloud")]
public class CloudSyncController : ControllerBase
{
    private readonly CloudSyncService _sync;

    public CloudSyncController(CloudSyncService sync)
    {
        _sync = sync;
    }

    /// <summary>POS outbox flush — auth by licenseKey + activated computerId.</summary>
    [HttpPost("sync")]
    [AllowAnonymous]
    public async Task<IActionResult> Sync([FromBody] CloudSyncBatchRequest request, CancellationToken ct)
    {
        (bool ok, string message, int accepted, IReadOnlyList<string> keys) =
            await _sync.IngestAsync(request, ct).ConfigureAwait(false);
        if (!ok)
        {
            return Unauthorized(new { message, accepted = 0, acceptedKeys = Array.Empty<string>() });
        }

        return Ok(new { message, accepted, acceptedKeys = keys });
    }

    [HttpGet("dashboard/{licenseId:guid}")]
    [Authorize(AuthenticationSchemes =
        OwnerAuthService.OwnerCookieScheme + "," +
        OwnerAuthService.OwnerJwtScheme + "," +
        CookieAuthenticationDefaults.AuthenticationScheme)]
    public async Task<IActionResult> Dashboard(Guid licenseId, CancellationToken ct)
    {
        CloudDashboardDto dto = await _sync.GetDashboardForLicenseAsync(licenseId, ct).ConfigureAwait(false);
        return Ok(dto);
    }
}
