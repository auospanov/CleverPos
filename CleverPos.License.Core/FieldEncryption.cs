using System;
using System.Security.Cryptography;
using System.Text;

namespace CleverPos.License.Core
{
    /// <summary>
    /// TripleDES field encryption compatible with LogicPOS CryptographyUtils.
    /// </summary>
    public static class FieldEncryption
    {
        private const string DefaultKey = "6f6a40b4419af34d562a95a1a7c5306d7b03";

        public static string Encrypt(string toEncrypt, bool useHashing = true)
        {
            return Encrypt(toEncrypt ?? string.Empty, useHashing, DefaultKey);
        }

        public static string Encrypt(string toEncrypt, bool useHashing, string key)
        {
            byte[] keyArray;
            byte[] toEncryptArray = Encoding.UTF8.GetBytes(toEncrypt ?? string.Empty);

            if (useHashing)
            {
                using (MD5 hashmd5 = MD5.Create())
                {
                    keyArray = hashmd5.ComputeHash(Encoding.UTF8.GetBytes(key));
                }
            }
            else
            {
                keyArray = Encoding.UTF8.GetBytes(key);
            }

            using (TripleDES tdes = TripleDES.Create())
            {
                tdes.Key = keyArray;
                tdes.Mode = CipherMode.ECB;
                tdes.Padding = PaddingMode.PKCS7;
                using (ICryptoTransform transform = tdes.CreateEncryptor())
                {
                    byte[] resultArray = transform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
                    return Convert.ToBase64String(resultArray);
                }
            }
        }

        public static string Decrypt(string cipherString, bool useHashing = true)
        {
            return Decrypt(cipherString, useHashing, DefaultKey);
        }

        public static string Decrypt(string cipherString, bool useHashing, string key)
        {
            if (string.IsNullOrEmpty(cipherString))
            {
                return cipherString ?? string.Empty;
            }

            byte[] keyArray;
            byte[] toEncryptArray = Convert.FromBase64String(cipherString);

            if (useHashing)
            {
                using (MD5 hashmd5 = MD5.Create())
                {
                    keyArray = hashmd5.ComputeHash(Encoding.UTF8.GetBytes(key));
                }
            }
            else
            {
                keyArray = Encoding.UTF8.GetBytes(key);
            }

            using (TripleDES tdes = TripleDES.Create())
            {
                tdes.Key = keyArray;
                tdes.Mode = CipherMode.ECB;
                tdes.Padding = PaddingMode.PKCS7;
                using (ICryptoTransform transform = tdes.CreateDecryptor())
                {
                    byte[] resultArray = transform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
                    return Encoding.UTF8.GetString(resultArray);
                }
            }
        }
    }
}
