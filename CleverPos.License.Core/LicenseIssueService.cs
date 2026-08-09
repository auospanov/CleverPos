using System;

namespace CleverPos.License.Core
{
    /// <summary>
    /// High-level issue/renew helper used by LicenseGenerator UI and License.Api.
    /// </summary>
    public static class LicenseIssueService
    {
        public static string IssueSignedLicenceFile(
            LicensePayload payload,
            string privateKeyXml = null)
        {
            if (payload == null) throw new ArgumentNullException(nameof(payload));
            if (payload.IssuedAtUtc == default)
            {
                payload.IssuedAtUtc = DateTime.UtcNow;
            }

            if (payload.ValidUntilUtc == default)
            {
                payload.ValidUntilUtc = LicensePeriod.ValidUntilExclusiveForCurrentMonthUtc();
            }

            string key = string.IsNullOrWhiteSpace(privateKeyXml)
                ? LicenseSigningKeys.DefaultPrivateKeyXml
                : privateKeyXml;

            return LicenseFileCodec.BuildSignedFile(payload, key);
        }

        public static LicenseReadResult VerifyLocal(
            string fileContent,
            string publicKeyXml = null,
            DateTime? nowUtc = null)
        {
            string key = string.IsNullOrWhiteSpace(publicKeyXml)
                ? LicenseSigningKeys.DefaultPublicKeyXml
                : publicKeyXml;

            return LicenseFileCodec.ReadAndVerify(fileContent, key, nowUtc);
        }
    }
}
