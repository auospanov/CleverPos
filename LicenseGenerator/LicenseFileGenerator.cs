using System;
using System.IO;
using CleverPos.License.Core;

namespace LicenseGenerator
{
    /// <summary>
    /// Thin wrapper around CleverPos.License.Core for the WinForms tool.
    /// </summary>
    public static class LicenseFileGenerator
    {
        public static void GenerateLicenseFile(string filePath, LicenseData data)
        {
            var payload = new LicensePayload
            {
                LicenseKey = string.IsNullOrWhiteSpace(data.LicenseKey) ? data.HardwareId : data.LicenseKey,
                HardwareId = data.HardwareId ?? string.Empty,
                Company = data.Company ?? string.Empty,
                Nif = data.Nif ?? string.Empty,
                Address = data.Address ?? string.Empty,
                Email = data.Email ?? string.Empty,
                Telephone = data.Telephone ?? string.Empty,
                Reseller = string.IsNullOrWhiteSpace(data.Reseller) ? "CleverPos" : data.Reseller,
                IssuedAtUtc = DateTime.UtcNow,
                ValidUntilUtc = data.ValidUntilUtc == default
                    ? LicensePeriod.ValidUntilExclusiveForCurrentMonthUtc()
                    : data.ValidUntilUtc.ToUniversalTime()
            };

            string content = LicenseIssueService.IssueSignedLicenceFile(payload);
            File.WriteAllText(filePath, content);
        }

        public class LicenseData
        {
            public string LicenseKey { get; set; }
            public string HardwareId { get; set; }
            public string Company { get; set; }
            public string Nif { get; set; }
            public string Address { get; set; }
            public string Email { get; set; }
            public string Telephone { get; set; }
            public string Reseller { get; set; }
            public DateTime ValidUntilUtc { get; set; }
        }
    }
}
