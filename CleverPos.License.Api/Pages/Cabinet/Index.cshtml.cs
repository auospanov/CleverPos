using System.Security.Claims;
using CleverPos.License.Api.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CleverPos.License.Api.Pages.Cabinet;

public class IndexModel : PageModel
{
    private readonly OwnerAuthService _auth;
    private readonly CloudSyncService _cloud;

    public IndexModel(OwnerAuthService auth, CloudSyncService cloud)
    {
        _auth = auth;
        _cloud = cloud;
    }

    public string? DisplayName { get; set; }
    public string? Email { get; set; }
    public string? StatusMessage { get; set; }
    public string? ErrorMessage { get; set; }
    public string LicenseKey { get; set; } = string.Empty;
    public List<LicenseRow> Licenses { get; set; } = new();
    public List<DashboardBlock> Dashboards { get; set; } = new();

    public async Task<IActionResult> OnGetAsync(CancellationToken ct)
    {
        if (!TryGetOwnerId(out Guid ownerId))
        {
            return Challenge(OwnerAuthService.OwnerCookieScheme);
        }

        var owner = await _auth.GetOwnerAsync(ownerId, ct).ConfigureAwait(false);
        if (owner == null)
        {
            await HttpContext.SignOutAsync(OwnerAuthService.OwnerCookieScheme).ConfigureAwait(false);
            return RedirectToPage("/Cabinet/Login");
        }

        DisplayName = owner.DisplayName;
        Email = owner.Email;
        Licenses = owner.LicenseLinks
            .OrderBy(l => l.License.CompanyName)
            .Select(l => new LicenseRow
            {
                LicenseId = l.LicenseId,
                LicenseKey = l.License.LicenseKey,
                CompanyName = l.License.CompanyName,
                Bin = l.License.Bin,
                Role = l.Role
            })
            .ToList();

        foreach (LicenseRow lic in Licenses)
        {
            CloudDashboardDto dto = await _cloud.GetDashboardForLicenseAsync(lic.LicenseId, ct).ConfigureAwait(false);
            Dashboards.Add(new DashboardBlock
            {
                CompanyName = lic.CompanyName ?? lic.LicenseKey,
                LicenseId = lic.LicenseId,
                Dashboard = dto
            });
        }

        return Page();
    }

    public async Task<IActionResult> OnPostLinkAsync(CancellationToken ct)
    {
        if (!TryGetOwnerId(out Guid ownerId))
        {
            return Challenge(OwnerAuthService.OwnerCookieScheme);
        }

        (bool ok, string message) = await _auth.LinkLicenseAsync(ownerId, LicenseKey, ct).ConfigureAwait(false);
        if (ok)
        {
            StatusMessage = message;
        }
        else
        {
            ErrorMessage = message;
        }

        return await OnGetAsync(ct).ConfigureAwait(false);
    }

    public async Task<IActionResult> OnPostLogoutAsync()
    {
        await HttpContext.SignOutAsync(OwnerAuthService.OwnerCookieScheme).ConfigureAwait(false);
        return RedirectToPage("/Cabinet/Login");
    }

    private bool TryGetOwnerId(out Guid ownerId)
    {
        ownerId = Guid.Empty;
        string? id = User.FindFirstValue(ClaimTypes.NameIdentifier);
        return Guid.TryParse(id, out ownerId);
    }

    public class LicenseRow
    {
        public Guid LicenseId { get; set; }
        public string LicenseKey { get; set; } = string.Empty;
        public string? CompanyName { get; set; }
        public string? Bin { get; set; }
        public string Role { get; set; } = "Owner";
    }

    public class DashboardBlock
    {
        public Guid LicenseId { get; set; }
        public string CompanyName { get; set; } = string.Empty;
        public CloudDashboardDto Dashboard { get; set; } = new();
    }
}
