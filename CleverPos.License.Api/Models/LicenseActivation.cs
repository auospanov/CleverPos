using System.ComponentModel.DataAnnotations;

namespace CleverPos.License.Api.Models;

public class LicenseActivation
{
    public Guid Id { get; set; } = Guid.NewGuid();

    public Guid LicenseId { get; set; }

    public LicenseRecord License { get; set; } = null!;

    [MaxLength(128)]
    public string ComputerId { get; set; } = string.Empty;

    [MaxLength(256)]
    public string? MachineName { get; set; }

    public DateTime ActivatedAtUtc { get; set; } = DateTime.UtcNow;

    public DateTime LastSeenAtUtc { get; set; } = DateTime.UtcNow;

    public bool IsActive { get; set; } = true;
}
