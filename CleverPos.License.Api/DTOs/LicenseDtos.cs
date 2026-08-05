namespace CleverPos.License.Api.DTOs;

public class ValidateLicenseRequest
{
    public string LicenseKey { get; set; } = string.Empty;
    public string ComputerId { get; set; } = string.Empty;
    public string? MachineName { get; set; }
    public string? CompanyName { get; set; }
}

public class ValidateLicenseResponse
{
    public bool Allowed { get; set; }
    public string Message { get; set; } = string.Empty;
    public DateTime? ExpiresAtUtc { get; set; }
    public bool CurrentMonthPaid { get; set; }
}

public class CreateLicenseRequest
{
    public string? LicenseKey { get; set; }
    public string? CompanyName { get; set; }
    public int MaxActivations { get; set; } = 1;
    public DateTime? ExpiresAtUtc { get; set; }
    public string? BindComputerId { get; set; }
    public string? BindMachineName { get; set; }
    public decimal? FirstMonthAmount { get; set; }
    public bool MarkCurrentMonthPaid { get; set; } = true;
}

public class MarkPaymentRequest
{
    public int? Year { get; set; }
    public int? Month { get; set; }
    public decimal? Amount { get; set; }
    public string? Comment { get; set; }
}

public class ComputerBindingDto
{
    public Guid ActivationId { get; set; }
    public string ComputerId { get; set; } = string.Empty;
    public string? MachineName { get; set; }
    public DateTime ActivatedAtUtc { get; set; }
    public DateTime LastSeenAtUtc { get; set; }
}

public class PaymentDto
{
    public Guid Id { get; set; }
    public int Year { get; set; }
    public int Month { get; set; }
    public decimal? Amount { get; set; }
    public DateTime PaidAtUtc { get; set; }
    public string? Comment { get; set; }
}

public class LicenseListItem
{
    public Guid Id { get; set; }
    public string LicenseKey { get; set; } = string.Empty;
    public string? CompanyName { get; set; }
    public int MaxActivations { get; set; }
    public int ActiveComputers { get; set; }
    public bool IsActive { get; set; }
    public DateTime? ExpiresAtUtc { get; set; }
    public bool CurrentMonthPaid { get; set; }
    public int? PaidThroughYear { get; set; }
    public int? PaidThroughMonth { get; set; }
    public IReadOnlyList<string> ComputerIds { get; set; } = Array.Empty<string>();
    public IReadOnlyList<ComputerBindingDto> Computers { get; set; } = Array.Empty<ComputerBindingDto>();
    public IReadOnlyList<PaymentDto> Payments { get; set; } = Array.Empty<PaymentDto>();
}
