using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json.Serialization;
using CleverPos.License.Api.Data;
using CleverPos.License.Api.Models;
using CleverPos.License.Api.Options;
using Google.Apis.Auth;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Protocols;
using Microsoft.IdentityModel.Protocols.OpenIdConnect;
using Microsoft.IdentityModel.Tokens;

namespace CleverPos.License.Api.Services;

public class OwnerAuthService
{
    public const string OwnerCookieScheme = "OwnerCookie";
    public const string OwnerJwtScheme = "OwnerJwt";

    private readonly LicenseDbContext _db;
    private readonly OwnerAuthOptions _options;
    private readonly ILogger<OwnerAuthService> _logger;

    public OwnerAuthService(
        LicenseDbContext db,
        IOptions<OwnerAuthOptions> options,
        ILogger<OwnerAuthService> logger)
    {
        _db = db;
        _options = options.Value;
        _logger = logger;
    }

    public async Task<(OwnerAccount Owner, string Jwt)?> SignInWithGoogleAsync(string idToken, CancellationToken ct)
    {
        if (string.IsNullOrWhiteSpace(_options.GoogleClientId))
        {
            throw new InvalidOperationException("OwnerAuth:GoogleClientId не настроен.");
        }

        GoogleJsonWebSignature.Payload payload = await GoogleJsonWebSignature.ValidateAsync(
            idToken,
            new GoogleJsonWebSignature.ValidationSettings
            {
                Audience = new[] { _options.GoogleClientId }
            }).ConfigureAwait(false);

        string email = payload.Email ?? string.Empty;
        string sub = payload.Subject ?? string.Empty;
        if (string.IsNullOrWhiteSpace(sub))
        {
            return null;
        }

        OwnerAccount owner = await UpsertOwnerAsync(
            "google",
            sub,
            email,
            payload.Name,
            payload.Picture,
            ct).ConfigureAwait(false);

        return (owner, IssueJwt(owner));
    }

    public async Task<(OwnerAccount Owner, string Jwt)?> SignInWithAppleAsync(
        string idToken,
        string? fallbackEmail,
        string? fallbackDisplayName,
        CancellationToken ct)
    {
        if (string.IsNullOrWhiteSpace(_options.AppleClientId))
        {
            throw new InvalidOperationException("OwnerAuth:AppleClientId не настроен.");
        }

        ClaimsPrincipal? principal = await ValidateAppleIdTokenAsync(idToken, ct).ConfigureAwait(false);
        if (principal == null)
        {
            return null;
        }

        string sub = principal.FindFirstValue("sub")
            ?? principal.FindFirstValue(ClaimTypes.NameIdentifier)
            ?? string.Empty;
        if (string.IsNullOrWhiteSpace(sub))
        {
            return null;
        }

        string email = principal.FindFirstValue("email")
            ?? principal.FindFirstValue(ClaimTypes.Email)
            ?? fallbackEmail
            ?? string.Empty;
        string display = fallbackDisplayName
            ?? principal.FindFirstValue("name")
            ?? principal.FindFirstValue(ClaimTypes.Name)
            ?? string.Empty;

        OwnerAccount owner = await UpsertOwnerAsync(
            "apple",
            sub,
            email,
            string.IsNullOrWhiteSpace(display) ? null : display,
            null,
            ct).ConfigureAwait(false);

        return (owner, IssueJwt(owner));
    }

    private async Task<ClaimsPrincipal?> ValidateAppleIdTokenAsync(string idToken, CancellationToken ct)
    {
        try
        {
            ConfigurationManager<OpenIdConnectConfiguration> configManager = new(
                "https://appleid.apple.com/.well-known/openid-configuration",
                new OpenIdConnectConfigurationRetriever(),
                new HttpDocumentRetriever());

            OpenIdConnectConfiguration discovery = await configManager.GetConfigurationAsync(ct).ConfigureAwait(false);
            TokenValidationParameters parameters = new()
            {
                ValidateIssuer = true,
                ValidIssuer = "https://appleid.apple.com",
                ValidateAudience = true,
                ValidAudience = _options.AppleClientId,
                ValidateLifetime = true,
                ValidateIssuerSigningKey = true,
                IssuerSigningKeys = discovery.SigningKeys,
                NameClaimType = "sub"
            };

            JwtSecurityTokenHandler handler = new();
            return handler.ValidateToken(idToken, parameters, out _);
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Apple id_token validation failed");
            return null;
        }
    }

    public async Task<(OwnerAccount Owner, string Jwt)?> SignInWithTelegramAsync(
        TelegramAuthPayload payload,
        CancellationToken ct)
    {
        if (string.IsNullOrWhiteSpace(_options.TelegramBotToken))
        {
            throw new InvalidOperationException("OwnerAuth:TelegramBotToken не настроен.");
        }

        if (!VerifyTelegramHash(payload, _options.TelegramBotToken))
        {
            _logger.LogWarning("Telegram hash verification failed");
            return null;
        }

        long authDate = payload.AuthDate;
        if (authDate > 0)
        {
            DateTime when = DateTimeOffset.FromUnixTimeSeconds(authDate).UtcDateTime;
            if (DateTime.UtcNow - when > TimeSpan.FromMinutes(10))
            {
                return null;
            }
        }

        string providerKey = payload.Id.ToString();
        string email = !string.IsNullOrWhiteSpace(payload.Username)
            ? payload.Username.Trim() + "@telegram.local"
            : "telegram_" + providerKey + "@telegram.local";
        string display = string.Join(" ", new[] { payload.FirstName, payload.LastName }.Where(s => !string.IsNullOrWhiteSpace(s)));

        OwnerAccount owner = await UpsertOwnerAsync(
            "telegram",
            providerKey,
            email,
            string.IsNullOrWhiteSpace(display) ? payload.Username : display,
            payload.PhotoUrl,
            ct).ConfigureAwait(false);

        return (owner, IssueJwt(owner));
    }

    public async Task<OwnerAccount?> GetOwnerAsync(Guid ownerId, CancellationToken ct)
    {
        return await _db.OwnerAccounts
            .Include(o => o.LicenseLinks)
            .ThenInclude(l => l.License)
            .FirstOrDefaultAsync(o => o.Id == ownerId && o.IsActive, ct)
            .ConfigureAwait(false);
    }

    public async Task<(bool Ok, string Message)> LinkLicenseAsync(Guid ownerId, string licenseKey, CancellationToken ct)
    {
        string key = (licenseKey ?? string.Empty).Trim();
        if (string.IsNullOrWhiteSpace(key))
        {
            return (false, "Укажите ключ лицензии.");
        }

        LicenseRecord? license = await _db.Licenses
            .FirstOrDefaultAsync(l => l.LicenseKey == key, ct)
            .ConfigureAwait(false);
        if (license == null || !license.IsActive)
        {
            return (false, "Лицензия не найдена или отключена.");
        }

        bool exists = await _db.OwnerLicenseLinks
            .AnyAsync(x => x.OwnerId == ownerId && x.LicenseId == license.Id, ct)
            .ConfigureAwait(false);
        if (exists)
        {
            return (true, "Лицензия уже привязана.");
        }

        _db.OwnerLicenseLinks.Add(new OwnerLicenseLink
        {
            OwnerId = ownerId,
            LicenseId = license.Id,
            Role = "Owner"
        });
        await _db.SaveChangesAsync(ct).ConfigureAwait(false);
        return (true, "Лицензия привязана.");
    }

    public List<Claim> BuildOwnerClaims(OwnerAccount owner)
    {
        return new List<Claim>
        {
            new(ClaimTypes.NameIdentifier, owner.Id.ToString()),
            new(ClaimTypes.Email, owner.Email ?? string.Empty),
            new(ClaimTypes.Name, owner.DisplayName ?? owner.Email ?? owner.Id.ToString()),
            new("provider", owner.Provider),
            new(ClaimTypes.Role, "Owner")
        };
    }

    public string IssueJwt(OwnerAccount owner)
    {
        SymmetricSecurityKey key = new(Encoding.UTF8.GetBytes(EnsureJwtKey(_options.JwtSigningKey)));
        SigningCredentials creds = new(key, SecurityAlgorithms.HmacSha256);
        DateTime expires = DateTime.UtcNow.AddHours(Math.Max(1, _options.JwtExpireHours));

        JwtSecurityToken token = new(
            issuer: _options.JwtIssuer,
            audience: _options.JwtAudience,
            claims: BuildOwnerClaims(owner),
            notBefore: DateTime.UtcNow,
            expires: expires,
            signingCredentials: creds);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    private async Task<OwnerAccount> UpsertOwnerAsync(
        string provider,
        string providerKey,
        string? email,
        string? displayName,
        string? avatarUrl,
        CancellationToken ct)
    {
        OwnerAccount? owner = await _db.OwnerAccounts
            .FirstOrDefaultAsync(o => o.Provider == provider && o.ProviderKey == providerKey, ct)
            .ConfigureAwait(false);

        if (owner == null && !string.IsNullOrWhiteSpace(email))
        {
            owner = await _db.OwnerAccounts
                .FirstOrDefaultAsync(o => o.Email == email, ct)
                .ConfigureAwait(false);
        }

        if (owner == null)
        {
            owner = new OwnerAccount
            {
                Provider = provider,
                ProviderKey = providerKey,
                Email = string.IsNullOrWhiteSpace(email) ? null : email.Trim(),
                DisplayName = displayName,
                AvatarUrl = avatarUrl
            };
            _db.OwnerAccounts.Add(owner);
        }
        else
        {
            owner.Provider = provider;
            owner.ProviderKey = providerKey;
            if (!string.IsNullOrWhiteSpace(email))
            {
                owner.Email = email.Trim();
            }

            if (!string.IsNullOrWhiteSpace(displayName))
            {
                owner.DisplayName = displayName;
            }

            if (!string.IsNullOrWhiteSpace(avatarUrl))
            {
                owner.AvatarUrl = avatarUrl;
            }

            owner.LastLoginAtUtc = DateTime.UtcNow;
            owner.IsActive = true;
        }

        await _db.SaveChangesAsync(ct).ConfigureAwait(false);
        return owner;
    }

    private static string EnsureJwtKey(string key)
    {
        if (string.IsNullOrWhiteSpace(key) || key.Length < 32)
        {
            return "CHANGE-ME-OWNER-JWT-KEY-32CHARS-MIN-X";
        }

        return key;
    }

    /// <summary>Telegram Login Widget hash check (HMAC-SHA256 of bot token).</summary>
    public static bool VerifyTelegramHash(TelegramAuthPayload payload, string botToken)
    {
        if (string.IsNullOrWhiteSpace(payload.Hash) || string.IsNullOrWhiteSpace(botToken))
        {
            return false;
        }

        var fields = new SortedDictionary<string, string>(StringComparer.Ordinal);
        void Add(string key, string? value)
        {
            if (!string.IsNullOrEmpty(value))
            {
                fields[key] = value;
            }
        }

        Add("auth_date", payload.AuthDate > 0 ? payload.AuthDate.ToString() : null);
        Add("first_name", payload.FirstName);
        Add("id", payload.Id.ToString());
        Add("last_name", payload.LastName);
        Add("photo_url", payload.PhotoUrl);
        Add("username", payload.Username);

        string dataCheckString = string.Join("\n", fields.Select(kv => kv.Key + "=" + kv.Value));
        byte[] secretKey;
        using (SHA256 sha = SHA256.Create())
        {
            secretKey = sha.ComputeHash(Encoding.UTF8.GetBytes(botToken));
        }

        using HMACSHA256 hmac = new(secretKey);
        byte[] hashBytes = hmac.ComputeHash(Encoding.UTF8.GetBytes(dataCheckString));
        string calculated = Convert.ToHexString(hashBytes).ToLowerInvariant();
        return string.Equals(calculated, payload.Hash.Trim().ToLowerInvariant(), StringComparison.Ordinal);
    }
}

public class TelegramAuthPayload
{
    [JsonPropertyName("id")]
    public long Id { get; set; }

    [JsonPropertyName("firstName")]
    public string? FirstName { get; set; }

    [JsonPropertyName("lastName")]
    public string? LastName { get; set; }

    [JsonPropertyName("username")]
    public string? Username { get; set; }

    [JsonPropertyName("photoUrl")]
    public string? PhotoUrl { get; set; }

    [JsonPropertyName("authDate")]
    public long AuthDate { get; set; }

    [JsonPropertyName("hash")]
    public string Hash { get; set; } = string.Empty;
}
