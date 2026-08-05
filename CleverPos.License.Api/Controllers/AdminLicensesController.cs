using CleverPos.License.Api.DTOs;
using CleverPos.License.Api.Services;
using Microsoft.AspNetCore.Mvc;

namespace CleverPos.License.Api.Controllers;

[ApiController]
[Route("api/admin/licenses")]
public class AdminLicensesController : ControllerBase
{
    private readonly LicenseService _licenses;
    private readonly IConfiguration _configuration;

    public AdminLicensesController(LicenseService licenses, IConfiguration configuration)
    {
        _licenses = licenses;
        _configuration = configuration;
    }

    [HttpGet]
    public async Task<ActionResult<IReadOnlyList<LicenseListItem>>> List(CancellationToken cancellationToken)
    {
        if (!IsAdmin())
        {
            return Unauthorized();
        }

        return Ok(await _licenses.ListAsync(cancellationToken).ConfigureAwait(false));
    }

    [HttpPost]
    public async Task<ActionResult<LicenseListItem>> Create(
        [FromBody] CreateLicenseRequest request,
        CancellationToken cancellationToken)
    {
        if (!IsAdmin())
        {
            return Unauthorized();
        }

        try
        {
            LicenseListItem created = await _licenses.CreateAsync(request, cancellationToken).ConfigureAwait(false);
            return Created($"/api/admin/licenses/{created.Id}", created);
        }
        catch (InvalidOperationException ex)
        {
            return Conflict(new { message = ex.Message });
        }
    }

    private bool IsAdmin()
    {
        string expected = _configuration["AdminApiKey"] ?? string.Empty;
        if (string.IsNullOrWhiteSpace(expected))
        {
            return false;
        }

        if (!Request.Headers.TryGetValue("X-Admin-Key", out var provided))
        {
            return false;
        }

        return string.Equals(expected, provided.ToString(), StringComparison.Ordinal);
    }
}
