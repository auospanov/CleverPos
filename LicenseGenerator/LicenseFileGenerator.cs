using System;
using System.IO;
using System.Text;

namespace LicenseGenerator
{
    /// <summary>
    /// Класс для генерации файла лицензии licence.lic
    /// </summary>
    public static class LicenseFileGenerator
    {
        /// <summary>
        /// Генерирует файл licence.lic с зашифрованными значениями
        /// </summary>
        public static void GenerateLicenseFile(string filePath, LicenseData data)
        {
            var sb = new StringBuilder();
            
            sb.AppendLine("[Licence]");
            sb.AppendLine($"HardwareId={CryptographyUtils.Encrypt(data.HardwareId, true)}");
            sb.AppendLine($"Company={CryptographyUtils.Encrypt(data.Company, true)}");
            sb.AppendLine($"Nif={CryptographyUtils.Encrypt(data.Nif, true)}");
            sb.AppendLine($"Address={CryptographyUtils.Encrypt(data.Address, true)}");
            sb.AppendLine($"Email={CryptographyUtils.Encrypt(data.Email, true)}");
            sb.AppendLine($"Telephone={CryptographyUtils.Encrypt(data.Telephone, true)}");
            sb.AppendLine($"Reseller={CryptographyUtils.Encrypt(data.Reseller, true)}");

            File.WriteAllText(filePath, sb.ToString(), Encoding.UTF8);
        }

        /// <summary>
        /// Класс для хранения данных лицензии
        /// </summary>
        public class LicenseData
        {
            public string HardwareId { get; set; }
            public string Company { get; set; }
            public string Nif { get; set; }
            public string Address { get; set; }
            public string Email { get; set; }
            public string Telephone { get; set; }
            public string Reseller { get; set; }
        }
    }
}

