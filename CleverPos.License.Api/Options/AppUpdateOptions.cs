namespace CleverPos.License.Api.Options;

public class AppUpdateOptions
{
    public const string SectionName = "AppUpdate";

    /// <summary>Latest CleverPos version (major.minor.build), e.g. 1.4.1</summary>
    public string LatestVersion { get; set; } = "1.4.0";

    /// <summary>
    /// Absolute URL or site-relative path to zip (e.g. /updates/CleverPos-1.4.1.zip).
    /// Empty = version check only, no download.
    /// </summary>
    public string DownloadUrl { get; set; } = "/updates/CleverPos-latest.zip";

    public string? Sha256 { get; set; }

    public string? ReleaseNotes { get; set; }

    public bool Mandatory { get; set; }
}
