using System.ComponentModel.DataAnnotations;

namespace CleverPos.License.Api.Models;

public class LicenseAccessLog
{
    public Guid Id { get; set; } = Guid.NewGuid();

    public Guid? LicenseId { get; set; }

    public LicenseRecord? License { get; set; }

    [MaxLength(128)]
    public string LicenseKey { get; set; } = string.Empty;

    [MaxLength(128)]
    public string ComputerId { get; set; } = string.Empty;

    [MaxLength(256)]
    public string? MachineName { get; set; }

    [MaxLength(256)]
    public string? CompanyName { get; set; }

    public bool Allowed { get; set; }

    [MaxLength(512)]
    public string Message { get; set; } = string.Empty;

    [MaxLength(64)]
    public string? ClientIp { get; set; }

    [MaxLength(32)]
    public string Source { get; set; } = "validate";

    public DateTime CreatedAtUtc { get; set; } = DateTime.UtcNow;
}
