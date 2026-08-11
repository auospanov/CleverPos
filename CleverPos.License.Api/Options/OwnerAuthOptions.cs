namespace CleverPos.License.Api.Options;

public class OwnerAuthOptions
{
    public const string SectionName = "OwnerAuth";

    public string JwtIssuer { get; set; } = "https://api.dominium.kz";
    public string JwtAudience { get; set; } = "cabinet.dominium.kz";
    public string JwtSigningKey { get; set; } = "CHANGE-ME-OWNER-JWT-KEY-32CHARS-MIN";
    public int JwtExpireHours { get; set; } = 72;

    public string GoogleClientId { get; set; } = string.Empty;
    public string AppleClientId { get; set; } = string.Empty;
    public string TelegramBotToken { get; set; } = string.Empty;
    public string TelegramBotUsername { get; set; } = string.Empty;

    /// <summary>Public cabinet origin for OAuth / GIS (cabinet.dominium.kz).</summary>
    public string CabinetPublicOrigin { get; set; } = "https://cabinet.dominium.kz";
}
