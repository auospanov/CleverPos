using CleverPos.License.Core;

namespace LicenseGenerator
{
    /// <summary>
    /// Compatibility shim — delegates to CleverPos.License.Core.FieldEncryption.
    /// </summary>
    public static class CryptographyUtils
    {
        public static string Encrypt(string toEncrypt, bool useHashing = true)
        {
            return FieldEncryption.Encrypt(toEncrypt, useHashing);
        }

        public static string Encrypt(string toEncrypt, bool useHashing, string key)
        {
            return FieldEncryption.Encrypt(toEncrypt, useHashing, key);
        }

        public static string Decrypt(string cipherString, bool useHashing = true)
        {
            return FieldEncryption.Decrypt(cipherString, useHashing);
        }

        public static string Decrypt(string cipherString, bool useHashing, string pKey)
        {
            return FieldEncryption.Decrypt(cipherString, useHashing, pKey);
        }
    }
}
