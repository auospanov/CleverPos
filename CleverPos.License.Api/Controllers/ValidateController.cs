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
<<<<<<< HEAD
        ValidateLicenseResponse result = await _licenses.RenewAsync(request ?? new ValidateLicenseRequest(), cancellationToken)
            .ConfigureAwait(false);
        if (!result.Allowed)
        {
            return StatusCode(StatusCodes.Status403Forbidden, result);
        }

=======
        ValidateLicenseRequest payload = request ?? new ValidateLicenseRequest();
        payload.ClientIp = HttpContext.Connection.RemoteIpAddress?.ToString();
        ValidateLicenseResponse result = await _licenses.ValidateAsync(payload, cancellationToken).ConfigureAwait(false);
>>>>>>> 51c4e42556c3063557d3d40d426316d29c69bacf
        return Ok(result);
    }

    [HttpPost("validate")]
    public Task<ActionResult<ValidateLicenseResponse>> Validate(
        [FromBody] ValidateLicenseRequest request,
        CancellationToken cancellationToken)
        => Renew(request, cancellationToken);
}
