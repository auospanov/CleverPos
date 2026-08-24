using System;

namespace CleverPos.License.Core
{
    public sealed class LicensePayload
    {
        /// <summary>
        /// HardwareId for admin-issued files before the first POS renew binds a real computer.
        /// </summary>
        public const string UnboundHardwareId = "*";

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

        public static bool IsUnboundHardwareId(string hardwareId)
        {
            if (string.IsNullOrWhiteSpace(hardwareId))
            {
                return true;
            }

            string value = hardwareId.Trim();
            return value == UnboundHardwareId
                   || string.Equals(value, "UNBOUND", StringComparison.OrdinalIgnoreCase);
        }

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
