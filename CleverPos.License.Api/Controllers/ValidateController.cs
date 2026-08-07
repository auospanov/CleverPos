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

    [HttpPost("validate")]
    public async Task<ActionResult<ValidateLicenseResponse>> Validate(
        [FromBody] ValidateLicenseRequest request,
        CancellationToken cancellationToken)
    {
        ValidateLicenseRequest payload = request ?? new ValidateLicenseRequest();
        payload.ClientIp = HttpContext.Connection.RemoteIpAddress?.ToString();
        ValidateLicenseResponse result = await _licenses.ValidateAsync(payload, cancellationToken).ConfigureAwait(false);
        return Ok(result);
    }
}
