using CleverPos.License.Api.DTOs;
using CleverPos.License.Api.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CleverPos.License.Api.Controllers;

[ApiController]
[AllowAnonymous]
[Route("api/licenses")]
public class ValidateController : ControllerBase
{
    private readonly LicenseService _licenses;

    public ValidateController(LicenseService licenses)
    {
        _licenses = licenses;
    }

    /// <summary>Продление / выдача подписанного licence.lic (используется кассой при истечении срока).</summary>
    [HttpPost("renew")]
    public async Task<ActionResult<ValidateLicenseResponse>> Renew(
        [FromBody] ValidateLicenseRequest request,
        CancellationToken cancellationToken)
    {
        ValidateLicenseRequest payload = request ?? new ValidateLicenseRequest();
        payload.ClientIp = HttpContext.Connection.RemoteIpAddress?.ToString();

        ValidateLicenseResponse result = await _licenses.RenewAsync(payload, cancellationToken).ConfigureAwait(false);
        if (!result.Allowed)
        {
            return StatusCode(StatusCodes.Status403Forbidden, result);
        }

        return Ok(result);
    }

    [HttpPost("validate")]
    public Task<ActionResult<ValidateLicenseResponse>> Validate(
        [FromBody] ValidateLicenseRequest request,
        CancellationToken cancellationToken)
        => Renew(request, cancellationToken);
}
