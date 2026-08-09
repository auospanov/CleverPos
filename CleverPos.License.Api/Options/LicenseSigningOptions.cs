using CleverPos.License.Core;

namespace CleverPos.License.Api.Options;

public class LicenseSigningOptions
{
    public const string SectionName = "LicenseSigning";

    /// <summary>RSA private key XML. Empty = use CleverPos.License.Core default.</summary>
    public string PrivateKeyXml { get; set; } = string.Empty;

    public string ResolvePrivateKeyXml()
    {
        return string.IsNullOrWhiteSpace(PrivateKeyXml)
            ? LicenseSigningKeys.DefaultPrivateKeyXml
            : PrivateKeyXml;
    }
}
