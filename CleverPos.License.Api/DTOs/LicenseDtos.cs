namespace CleverPos.License.Api.DTOs;

public class ValidateLicenseRequest
{
    public string LicenseKey { get; set; } = string.Empty;
    public string ComputerId { get; set; } = string.Empty;
    public string? MachineName { get; set; }
}

public class ValidateLicenseResponse
{
    public bool Allowed { get; set; }
    public string Message { get; set; } = string.Empty;
    public DateTime? ExpiresAtUtc { get; set; }
}

public class CreateLicenseRequest
{
    public string? LicenseKey { get; set; }
    public string? CompanyName { get; set; }
    public int MaxActivations { get; set; } = 1;
    public DateTime? ExpiresAtUtc { get; set; }
    public string? BindComputerId { get; set; }
    public string? BindMachineName { get; set; }
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
    public IReadOnlyList<string> ComputerIds { get; set; } = Array.Empty<string>();
}
