using System.ComponentModel.DataAnnotations;

namespace CleverPos.License.Api.Models;

public class LicensePayment
{
    public Guid Id { get; set; } = Guid.NewGuid();

    public Guid LicenseId { get; set; }

    public LicenseRecord License { get; set; } = null!;

    public int PeriodYear { get; set; }

    public int PeriodMonth { get; set; }

    public decimal? Amount { get; set; }

    public DateTime PaidAtUtc { get; set; } = DateTime.UtcNow;

    [MaxLength(512)]
    public string? Comment { get; set; }
}
