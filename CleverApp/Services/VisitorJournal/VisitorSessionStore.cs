namespace CleverApp.Services.VisitorJournal;

/// <summary>
/// Токены Keycloak после POST /api/VisitorJournal/auth.
/// </summary>
public static class VisitorSessionStore
{
    private const string AccessTokenKey = "visitor_journal_access_token";
    private const string RefreshTokenKey = "visitor_journal_refresh_token";
    private const string UsernameKey = "visitor_journal_username";

    public static string? AccessToken
    {
        get
        {
            var value = Preferences.Get(AccessTokenKey, string.Empty);
            return string.IsNullOrWhiteSpace(value) ? null : value;
        }
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                Preferences.Remove(AccessTokenKey);
            else
                Preferences.Set(AccessTokenKey, value);
        }
    }

    public static string? RefreshToken
    {
        get
        {
            var value = Preferences.Get(RefreshTokenKey, string.Empty);
            return string.IsNullOrWhiteSpace(value) ? null : value;
        }
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                Preferences.Remove(RefreshTokenKey);
            else
                Preferences.Set(RefreshTokenKey, value);
        }
    }

    public static string Username
    {
        get => Preferences.Get(UsernameKey, string.Empty);
        set => Preferences.Set(UsernameKey, value ?? string.Empty);
    }

    public static bool IsAuthenticated => !string.IsNullOrWhiteSpace(AccessToken);

    public static void SaveTokens(string username, string accessToken, string refreshToken)
    {
        Username = username;
        AccessToken = accessToken;
        RefreshToken = refreshToken;
    }

    public static void ClearSession()
    {
        Preferences.Remove(AccessTokenKey);
        Preferences.Remove(RefreshTokenKey);
    }
}
