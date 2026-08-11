using CleverPos.License.Api.Options;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace CleverPos.License.Api.Controllers;

[ApiController]
[AllowAnonymous]
[Route("api/updates")]
public class UpdatesController : ControllerBase
{
    private readonly AppUpdateOptions _options;

    public UpdatesController(IOptions<AppUpdateOptions> options)
    {
        _options = options.Value ?? new AppUpdateOptions();
    }

    /// <summary>Latest CleverPos build for POS auto-update.</summary>
    [HttpGet("latest")]
    public ActionResult<AppUpdateInfoResponse> Latest()
    {
        string downloadUrl = (_options.DownloadUrl ?? string.Empty).Trim();
        if (!string.IsNullOrEmpty(downloadUrl) && downloadUrl.StartsWith("/", StringComparison.Ordinal))
        {
            string baseUrl = $"{Request.Scheme}://{Request.Host.Value}";
            downloadUrl = baseUrl.TrimEnd('/') + downloadUrl;
        }

        return Ok(new AppUpdateInfoResponse
        {
            Version = string.IsNullOrWhiteSpace(_options.LatestVersion) ? "1.4.0" : _options.LatestVersion.Trim(),
            DownloadUrl = downloadUrl,
            Sha256 = string.IsNullOrWhiteSpace(_options.Sha256) ? null : _options.Sha256.Trim(),
            ReleaseNotes = _options.ReleaseNotes,
            Mandatory = _options.Mandatory
        });
    }
}

public class AppUpdateInfoResponse
{
    public string Version { get; set; } = "1.4.0";
    public string? DownloadUrl { get; set; }
    public string? Sha256 { get; set; }
    public string? ReleaseNotes { get; set; }
    public bool Mandatory { get; set; }
}
