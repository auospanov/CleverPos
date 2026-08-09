using System;
using System.Security.Cryptography;
using System.Text;

namespace CleverPos.License.Core
{
    public static class LicenseSigner
    {
        public static string Sign(LicensePayload payload, string privateKeyXml)
        {
            if (payload == null) throw new ArgumentNullException(nameof(payload));
            if (string.IsNullOrWhiteSpace(privateKeyXml)) throw new ArgumentException("Private key is required.", nameof(privateKeyXml));

            byte[] data = Encoding.UTF8.GetBytes(payload.BuildCanonicalString());
            using (RSACryptoServiceProvider rsa = new RSACryptoServiceProvider())
            {
                rsa.FromXmlString(privateKeyXml);
                byte[] signature = rsa.SignData(data, HashAlgorithmName.SHA256, RSASignaturePadding.Pkcs1);
                return Convert.ToBase64String(signature);
            }
        }

        public static bool Verify(LicensePayload payload, string signatureBase64, string publicKeyXml)
        {
            if (payload == null || string.IsNullOrWhiteSpace(signatureBase64) || string.IsNullOrWhiteSpace(publicKeyXml))
            {
                return false;
            }

            try
            {
                byte[] data = Encoding.UTF8.GetBytes(payload.BuildCanonicalString());
                byte[] signature = Convert.FromBase64String(signatureBase64);
                using (RSACryptoServiceProvider rsa = new RSACryptoServiceProvider())
                {
                    rsa.FromXmlString(publicKeyXml);
                    return rsa.VerifyData(data, signature, HashAlgorithmName.SHA256, RSASignaturePadding.Pkcs1);
                }
            }
            catch
            {
                return false;
            }
        }

        public static string CreateKeyPairXml(out string publicKeyXml, int keySize = 2048)
        {
            using (RSACryptoServiceProvider rsa = new RSACryptoServiceProvider(keySize))
            {
                publicKeyXml = rsa.ToXmlString(false);
                return rsa.ToXmlString(true);
            }
        }
    }
}
