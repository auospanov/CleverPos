using System;

namespace CleverPos.License.Core
{
    public sealed class LicensePayload
    {
        public string LicenseKey { get; set; } = string.Empty;
        public string HardwareId { get; set; } = string.Empty;
        public string Company { get; set; } = string.Empty;
        public string Nif { get; set; } = string.Empty;
        public string Address { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Telephone { get; set; } = string.Empty;
        public string Reseller { get; set; } = "CleverPos";
        public DateTime ValidUntilUtc { get; set; }
        public DateTime IssuedAtUtc { get; set; } = DateTime.UtcNow;

        public string BuildCanonicalString()
        {
            return string.Join("\n", new[]
            {
                "v1",
                "LicenseKey=" + (LicenseKey ?? string.Empty).Trim(),
                "HardwareId=" + (HardwareId ?? string.Empty).Trim(),
                "Company=" + (Company ?? string.Empty).Trim(),
                "ValidUntilUtc=" + ValidUntilUtc.ToUniversalTime().ToString("o"),
                "IssuedAtUtc=" + IssuedAtUtc.ToUniversalTime().ToString("o")
            });
        }
    }

    public sealed class LicenseReadResult
    {
        public bool Success { get; set; }
        public string Message { get; set; } = string.Empty;
        public LicensePayload Payload { get; set; } = null;
        public bool HasSignature { get; set; }
        public bool SignatureValid { get; set; }
        public bool IsExpired { get; set; }
    }
}
