using System.Text.Json;

namespace CleverApp.Configuration;

/// <summary>
/// Настройки из Resources/Raw/appsettings.json.
/// ApiEnvironment: Test → apitest.kmlife.kz, Production → api.kmlife.kz
/// ApiBaseUrlOverride: если задан — используется вместо ApiEnvironment (для локального теста по LAN).
/// EnableShopMode: true — LogicPOS (штрихкоды по LAN), false — журнал посетителей (логин + удостоверение).
/// </summary>
public static class AppConfig
{
    public const string EnvironmentTest = "Test";
    public const string EnvironmentProduction = "Production";

    public const string TestApiBaseUrl = "https://api.kmlife.kz";
    public const string ProductionApiBaseUrl = "https://api.kmlife.kz";

    public static string ApiEnvironment { get; private set; } = EnvironmentTest;
    public static string ApiBaseUrl { get; private set; } = TestApiBaseUrl;
    public static bool EnableShopMode { get; private set; }

    public static bool IsProduction =>
        string.Equals(ApiEnvironment, EnvironmentProduction, StringComparison.OrdinalIgnoreCase);

    public static void Initialize()
    {
        ApiEnvironment = EnvironmentTest;
        EnableShopMode = false;
        string? apiBaseUrlOverride = null;

        try
        {
            using var stream = FileSystem.OpenAppPackageFileAsync("appsettings.json").GetAwaiter().GetResult();
            using var reader = new StreamReader(stream);
            var json = reader.ReadToEnd();
            using var doc = JsonDocument.Parse(json);

            apiBaseUrlOverride = ReadApiBaseUrlOverride(doc);

            if (doc.RootElement.TryGetProperty("ApiEnvironment", out var envElement))
            {
                var env = envElement.GetString()?.Trim();
                if (!string.IsNullOrWhiteSpace(env))
                    ApiEnvironment = env;
            }

            if (doc.RootElement.TryGetProperty("EnableShopMode", out var shopElement))
            {
                if (shopElement.ValueKind == JsonValueKind.True)
                    EnableShopMode = true;
                else if (shopElement.ValueKind == JsonValueKind.False)
                    EnableShopMode = false;
                else if (shopElement.ValueKind == JsonValueKind.String &&
                         bool.TryParse(shopElement.GetString(), out var shopFlag))
                    EnableShopMode = shopFlag;
            }
        }
        catch
        {
            // defaults
        }

        if (!string.IsNullOrWhiteSpace(apiBaseUrlOverride))
            ApiBaseUrl = apiBaseUrlOverride.TrimEnd('/');
        else
            ApiBaseUrl = ResolveBaseUrl(ApiEnvironment);
    }

    private static string? ReadApiBaseUrlOverride(JsonDocument doc)
    {
        if (!doc.RootElement.TryGetProperty("ApiBaseUrlOverride", out var overrideElement))
            return null;

        var value = overrideElement.GetString()?.Trim();
        return string.IsNullOrWhiteSpace(value) ? null : value;
    }

    public static string ResolveBaseUrl(string environment) =>
        string.Equals(environment, EnvironmentProduction, StringComparison.OrdinalIgnoreCase)
            ? ProductionApiBaseUrl
            : TestApiBaseUrl;
}
