using System.Text.Json.Serialization;

namespace CleverApp.Services.VisitorJournal;

public sealed class VisitReasonDto
{
    [JsonPropertyName("id")]
    public int Id { get; set; }

    [JsonPropertyName("code")]
    public int Code { get; set; }

    [JsonPropertyName("name")]
    public string Name { get; set; } = string.Empty;

    [JsonPropertyName("isActive")]
    public bool IsActive { get; set; }

    [JsonPropertyName("sortOrder")]
    public int SortOrder { get; set; }
}

public sealed class CreateVisitorRegistrationRequest
{
    [JsonPropertyName("visitDate")]
    public DateTime? VisitDate { get; set; }

    [JsonPropertyName("lastName")]
    public string LastName { get; set; } = string.Empty;

    [JsonPropertyName("firstName")]
    public string FirstName { get; set; } = string.Empty;

    [JsonPropertyName("middleName")]
    public string? MiddleName { get; set; }

    [JsonPropertyName("visitReasonId")]
    public int VisitReasonId { get; set; }
}

public sealed class VisitorRegistrationDto
{
    [JsonPropertyName("id")]
    public int Id { get; set; }

    [JsonPropertyName("rowNumber")]
    public int RowNumber { get; set; }

    [JsonPropertyName("visitDate")]
    public DateTime VisitDate { get; set; }

    [JsonPropertyName("lastName")]
    public string LastName { get; set; } = string.Empty;

    [JsonPropertyName("firstName")]
    public string FirstName { get; set; } = string.Empty;

    [JsonPropertyName("middleName")]
    public string? MiddleName { get; set; }

    [JsonPropertyName("fullName")]
    public string FullName { get; set; } = string.Empty;

    [JsonPropertyName("visitReasonId")]
    public int VisitReasonId { get; set; }

    [JsonPropertyName("visitReasonName")]
    public string VisitReasonName { get; set; } = string.Empty;

    [JsonPropertyName("createdAt")]
    public DateTime CreatedAt { get; set; }

    [JsonPropertyName("createdBy")]
    public string? CreatedBy { get; set; }
}

public sealed class VisitorJournalListResponse
{
    [JsonPropertyName("items")]
    public List<VisitorRegistrationDto> Items { get; set; } = new();

    [JsonPropertyName("totalCount")]
    public int TotalCount { get; set; }
}

public sealed class VisitorInsertResult
{
    public bool Success { get; init; }
    public VisitorRegistrationDto? Entry { get; init; }
    public string? ErrorMessage { get; init; }
    public string? DebugCurl { get; init; }

    public static VisitorInsertResult Ok(VisitorRegistrationDto entry) =>
        new() { Success = true, Entry = entry };

    public static VisitorInsertResult Fail(string message, string? debugCurl = null) =>
        new() { Success = false, ErrorMessage = message, DebugCurl = debugCurl };
}

public sealed class VisitorAuthResponse
{
    [JsonPropertyName("code")]
    public int Code { get; set; }

    [JsonPropertyName("message")]
    public string Message { get; set; } = string.Empty;

    [JsonPropertyName("data")]
    public VisitorAuthData? Data { get; set; }
}

public sealed class VisitorAuthData
{
    [JsonPropertyName("username")]
    public string Username { get; set; } = string.Empty;

    [JsonPropertyName("accessToken")]
    public string AccessToken { get; set; } = string.Empty;

    [JsonPropertyName("refreshToken")]
    public string RefreshToken { get; set; } = string.Empty;
}

public sealed class VisitorAuthResult
{
    public bool Success { get; init; }
    public string? ErrorMessage { get; init; }
    public bool PasswordChangeRequired { get; init; }
    public string? DebugCurl { get; init; }

    public static VisitorAuthResult Ok() => new() { Success = true };

    public static VisitorAuthResult Fail(string message, bool passwordChangeRequired = false, string? debugCurl = null) =>
        new()
        {
            Success = false,
            ErrorMessage = message,
            PasswordChangeRequired = passwordChangeRequired,
            DebugCurl = debugCurl
        };
}
