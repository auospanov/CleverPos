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

    [HttpGet("{id:guid}")]
    public async Task<ActionResult<LicenseListItem>> Get(Guid id, CancellationToken cancellationToken)
    {
        if (!IsAdmin())
        {
            return Unauthorized();
        }

        LicenseListItem? item = await _licenses.GetAsync(id, cancellationToken).ConfigureAwait(false);
        return item == null ? NotFound() : Ok(item);
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

    [HttpPost("{id:guid}/clear-computer")]
    public async Task<IActionResult> ClearComputer(Guid id, CancellationToken cancellationToken)
    {
        if (!IsAdmin())
        {
            return Unauthorized();
        }

        bool ok = await _licenses.ClearComputerAsync(id, cancellationToken).ConfigureAwait(false);
        return ok ? NoContent() : NotFound();
    }

    [HttpPost("{id:guid}/payments")]
    public async Task<ActionResult<LicenseListItem>> MarkPaid(
        Guid id,
        [FromBody] MarkPaymentRequest request,
        CancellationToken cancellationToken)
    {
        if (!IsAdmin())
        {
            return Unauthorized();
        }

        try
        {
            LicenseListItem? updated = await _licenses.MarkPaidAsync(id, request, cancellationToken).ConfigureAwait(false);
            return updated == null ? NotFound() : Ok(updated);
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    [HttpPost("{id:guid}/active")]
    public async Task<ActionResult<LicenseListItem>> SetActive(
        Guid id,
        [FromBody] SetActiveRequest request,
        CancellationToken cancellationToken)
    {
        if (!IsAdmin())
        {
            return Unauthorized();
        }

        LicenseListItem? updated = await _licenses.SetActiveAsync(id, request.IsActive, cancellationToken).ConfigureAwait(false);
        return updated == null ? NotFound() : Ok(updated);
    }

    [HttpGet("{id:guid}/licence-file")]
    public async Task<IActionResult> DownloadLicenceFile(
        Guid id,
        [FromQuery] string? computerId,
        CancellationToken cancellationToken)
    {
        if (!IsAdmin())
        {
            return Unauthorized();
        }

        try
        {
            string? content = await _licenses.IssueFileForLicenseAsync(id, computerId, cancellationToken).ConfigureAwait(false);
            if (content == null)
            {
                return NotFound();
            }

            return File(System.Text.Encoding.UTF8.GetBytes(content), "text/plain", "licence.lic");
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(new { message = ex.Message });
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

public class SetActiveRequest
{
    public bool IsActive { get; set; }
}
