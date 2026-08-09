using CleverPos.License.Api.DTOs;
using CleverPos.License.Api.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CleverPos.License.Api.Pages.Admin;

public class AccessLogModel : PageModel
{
    private readonly LicenseService _licenses;

    public AccessLogModel(LicenseService licenses)
    {
        _licenses = licenses;
    }

    public IReadOnlyList<AccessLogItem> Logs { get; private set; } = Array.Empty<AccessLogItem>();

    [BindProperty(SupportsGet = true)]
    public Guid? LicenseId { get; set; }

    public async Task OnGetAsync(CancellationToken cancellationToken)
    {
        Logs = await _licenses.ListAccessLogsAsync(LicenseId, 300, cancellationToken).ConfigureAwait(false);
    }
}
