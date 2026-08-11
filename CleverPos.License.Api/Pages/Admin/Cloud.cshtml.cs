using CleverPos.License.Api.Data;
using CleverPos.License.Api.Services;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;

namespace CleverPos.License.Api.Pages.Admin;

public class CloudModel : PageModel
{
    private readonly LicenseDbContext _db;
    private readonly CloudSyncService _cloud;

    public CloudModel(LicenseDbContext db, CloudSyncService cloud)
    {
        _db = db;
        _cloud = cloud;
    }

    public List<Block> Blocks { get; set; } = new();

    public async Task OnGetAsync(CancellationToken ct)
    {
        var licenses = await _db.Licenses
            .OrderBy(l => l.CompanyName)
            .ToListAsync(ct)
            .ConfigureAwait(false);

        foreach (var license in licenses)
        {
            Blocks.Add(new Block
            {
                LicenseKey = license.LicenseKey,
                CompanyName = license.CompanyName,
                Dashboard = await _cloud.GetDashboardForLicenseAsync(license.Id, ct).ConfigureAwait(false)
            });
        }
    }

    public class Block
    {
        public string LicenseKey { get; set; } = string.Empty;
        public string? CompanyName { get; set; }
        public CloudDashboardDto Dashboard { get; set; } = new();
    }
}
