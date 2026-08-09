using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;

namespace CleverPos.License.Core
{
    public static class LicenseFileCodec
    {
        public static string BuildSignedFile(LicensePayload payload, string privateKeyXml)
        {
            if (payload == null) throw new ArgumentNullException(nameof(payload));

            string signature = LicenseSigner.Sign(payload, privateKeyXml);
            var sb = new StringBuilder();
            sb.AppendLine("[Licence]");
            WriteEncrypted(sb, "LicenseKey", payload.LicenseKey);
            WriteEncrypted(sb, "HardwareId", payload.HardwareId);
            WriteEncrypted(sb, "Company", payload.Company);
            WriteEncrypted(sb, "Nif", payload.Nif);
            WriteEncrypted(sb, "Address", payload.Address);
            WriteEncrypted(sb, "Email", payload.Email);
            WriteEncrypted(sb, "Telephone", payload.Telephone);
            WriteEncrypted(sb, "Reseller", string.IsNullOrWhiteSpace(payload.Reseller) ? "CleverPos" : payload.Reseller);
            WriteEncrypted(sb, "ValidUntilUtc", payload.ValidUntilUtc.ToUniversalTime().ToString("o"));
            WriteEncrypted(sb, "IssuedAtUtc", payload.IssuedAtUtc.ToUniversalTime().ToString("o"));
            sb.AppendLine("Signature=" + signature);
            return sb.ToString();
        }

        public static LicenseReadResult ReadAndVerify(string fileContent, string publicKeyXml, DateTime? nowUtc = null)
        {
            var result = new LicenseReadResult();
            if (string.IsNullOrWhiteSpace(fileContent))
            {
                result.Message = "Файл лицензии пуст.";
                return result;
            }

            Dictionary<string, string> values = ParseIniSection(fileContent, "Licence");
            var payload = new LicensePayload
            {
                LicenseKey = DecryptField(values, "LicenseKey"),
                HardwareId = DecryptField(values, "HardwareId"),
                Company = DecryptField(values, "Company"),
                Nif = DecryptField(values, "Nif"),
                Address = DecryptField(values, "Address"),
                Email = DecryptField(values, "Email"),
                Telephone = DecryptField(values, "Telephone"),
                Reseller = DecryptField(values, "Reseller")
            };

            if (string.IsNullOrWhiteSpace(payload.LicenseKey) && !string.IsNullOrWhiteSpace(payload.HardwareId))
            {
                // Legacy files used HardwareId as the online key.
                payload.LicenseKey = payload.HardwareId.Trim();
            }

            string validUntilRaw = DecryptField(values, "ValidUntilUtc");
            string issuedAtRaw = DecryptField(values, "IssuedAtUtc");
            if (!TryParseUtc(validUntilRaw, out DateTime validUntil))
            {
                result.Payload = payload;
                result.Message = "В файле нет ValidUntilUtc — требуется продление.";
                result.IsExpired = true;
                return result;
            }

            payload.ValidUntilUtc = validUntil;
            if (TryParseUtc(issuedAtRaw, out DateTime issuedAt))
            {
                payload.IssuedAtUtc = issuedAt;
            }

            result.Payload = payload;
            result.HasSignature = values.TryGetValue("Signature", out string signature) && !string.IsNullOrWhiteSpace(signature);
            if (!result.HasSignature)
            {
                result.Message = "Нет подписи — требуется продление.";
                result.IsExpired = true;
                return result;
            }

            result.SignatureValid = LicenseSigner.Verify(payload, signature, publicKeyXml);
            if (!result.SignatureValid)
            {
                result.Message = "Подпись лицензии недействительна.";
                return result;
            }

            result.IsExpired = LicensePeriod.IsExpired(payload.ValidUntilUtc, nowUtc);
            result.Success = !result.IsExpired;
            result.Message = result.IsExpired
                ? "Срок лицензии истёк — требуется продление."
                : "OK";
            return result;
        }

        private static void WriteEncrypted(StringBuilder sb, string key, string value)
        {
            sb.Append(key).Append('=').Append(FieldEncryption.Encrypt(value ?? string.Empty, true)).AppendLine();
        }

        private static string DecryptField(Dictionary<string, string> values, string key)
        {
            if (!values.TryGetValue(key, out string raw) || string.IsNullOrWhiteSpace(raw))
            {
                return string.Empty;
            }

            try
            {
                return FieldEncryption.Decrypt(raw, true);
            }
            catch
            {
                return raw;
            }
        }

        private static bool TryParseUtc(string value, out DateTime utc)
        {
            utc = default;
            if (string.IsNullOrWhiteSpace(value))
            {
                return false;
            }

            if (DateTime.TryParse(value, CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal, out utc))
            {
                utc = DateTime.SpecifyKind(utc, DateTimeKind.Utc);
                return true;
            }

            return false;
        }

        private static Dictionary<string, string> ParseIniSection(string content, string section)
        {
            var map = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
            string[] lines = content.Replace("\r\n", "\n").Replace('\r', '\n').Split('\n');
            bool inSection = false;
            string header = "[" + section + "]";

            foreach (string rawLine in lines)
            {
                string line = rawLine.Trim();
                if (line.Length == 0 || line.StartsWith(";") || line.StartsWith("#"))
                {
                    continue;
                }

                if (line.StartsWith("[") && line.EndsWith("]"))
                {
                    inSection = string.Equals(line, header, StringComparison.OrdinalIgnoreCase);
                    continue;
                }

                if (!inSection)
                {
                    continue;
                }

                int eq = line.IndexOf('=');
                if (eq <= 0)
                {
                    continue;
                }

                string key = line.Substring(0, eq).Trim();
                string value = line.Substring(eq + 1).Trim();
                map[key] = value;
            }

            return map;
        }
    }
}
