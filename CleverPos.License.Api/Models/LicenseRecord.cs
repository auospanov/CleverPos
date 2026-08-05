using System.ComponentModel.DataAnnotations;

namespace CleverPos.License.Api.Models;

public class LicenseRecord
{
    public Guid Id { get; set; } = Guid.NewGuid();

    [MaxLength(128)]
    public string LicenseKey { get; set; } = string.Empty;

    [MaxLength(256)]
    public string? CompanyName { get; set; }

    public int MaxActivations { get; set; } = 1;

    public DateTime? ExpiresAtUtc { get; set; }

    public bool IsActive { get; set; } = true;

    public DateTime CreatedAtUtc { get; set; } = DateTime.UtcNow;

    public ICollection<LicenseActivation> Activations { get; set; } = new List<LicenseActivation>();
}
