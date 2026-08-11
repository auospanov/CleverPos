using System.ComponentModel.DataAnnotations;

namespace CleverPos.License.Api.Models;

/// <summary>Absolute stock snapshot per store/article (model B upsert).</summary>
public class CloudStockBalance
{
    public Guid Id { get; set; } = Guid.NewGuid();

    public Guid LicenseId { get; set; }
    public LicenseRecord License { get; set; } = null!;

    [MaxLength(64)]
    public string StoreId { get; set; } = string.Empty;

    [MaxLength(64)]
    public string ArticleOid { get; set; } = string.Empty;

    [MaxLength(64)]
    public string? Barcode { get; set; }

    [MaxLength(64)]
    public string? Code { get; set; }

    [MaxLength(256)]
    public string? Designation { get; set; }

    public decimal Accounting { get; set; }

    public DateTime UpdatedAtUtc { get; set; } = DateTime.UtcNow;
}

/// <summary>Sale event for KPI aggregates (idempotent by key).</summary>
public class CloudSaleEvent
{
    public Guid Id { get; set; } = Guid.NewGuid();

    public Guid LicenseId { get; set; }
    public LicenseRecord License { get; set; } = null!;

    [MaxLength(64)]
    public string StoreId { get; set; } = string.Empty;

    [MaxLength(64)]
    public string DocumentOid { get; set; } = string.Empty;

    [MaxLength(128)]
    public string? DocumentNumber { get; set; }

    public decimal Total { get; set; }

    [MaxLength(16)]
    public string Day { get; set; } = string.Empty;

    [MaxLength(64)]
    public string? PaymentToken { get; set; }

    [MaxLength(128)]
    public string IdempotencyKey { get; set; } = string.Empty;

    public DateTime AtUtc { get; set; } = DateTime.UtcNow;

    public DateTime ReceivedAtUtc { get; set; } = DateTime.UtcNow;
}

/// <summary>Last heartbeat / sync from a till (store + computer).</summary>
public class CloudTillPresence
{
    public Guid Id { get; set; } = Guid.NewGuid();

    public Guid LicenseId { get; set; }
    public LicenseRecord License { get; set; } = null!;

    [MaxLength(64)]
    public string StoreId { get; set; } = string.Empty;

    [MaxLength(128)]
    public string ComputerId { get; set; } = string.Empty;

    [MaxLength(256)]
    public string? MachineName { get; set; }

    public DateTime LastSeenAtUtc { get; set; } = DateTime.UtcNow;

    public int PendingAckCount { get; set; }
}
