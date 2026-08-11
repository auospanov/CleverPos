using System.ComponentModel.DataAnnotations;

namespace CleverPos.License.Api.Models;

/// <summary>Владелец сети магазинов (вход через Google / Apple / Telegram).</summary>
public class OwnerAccount
{
    public Guid Id { get; set; } = Guid.NewGuid();

    [MaxLength(32)]
    public string Provider { get; set; } = string.Empty; // google | apple | telegram

    [MaxLength(128)]
    public string ProviderKey { get; set; } = string.Empty;

    [MaxLength(256)]
    public string? Email { get; set; }

    [MaxLength(256)]
    public string? DisplayName { get; set; }

    [MaxLength(512)]
    public string? AvatarUrl { get; set; }

    public bool IsActive { get; set; } = true;

    public DateTime CreatedAtUtc { get; set; } = DateTime.UtcNow;

    public DateTime LastLoginAtUtc { get; set; } = DateTime.UtcNow;

    public ICollection<OwnerLicenseLink> LicenseLinks { get; set; } = new List<OwnerLicenseLink>();
}

public class OwnerLicenseLink
{
    public Guid Id { get; set; } = Guid.NewGuid();

    public Guid OwnerId { get; set; }
    public OwnerAccount Owner { get; set; } = null!;

    public Guid LicenseId { get; set; }
    public LicenseRecord License { get; set; } = null!;

    /// <summary>Owner | Manager (позже).</summary>
    [MaxLength(32)]
    public string Role { get; set; } = "Owner";

    public DateTime LinkedAtUtc { get; set; } = DateTime.UtcNow;
}
