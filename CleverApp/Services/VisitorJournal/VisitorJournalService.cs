using System.Text.Json;
using CleverApp.Configuration;

namespace CleverApp.Services.VisitorJournal;

/// <summary>
/// Клиент API журнала посетителей (Keycloak Bearer).
/// </summary>
public sealed class VisitorJournalService
{
    private static readonly JsonSerializerOptions JsonOptions = new()
    {
        PropertyNameCaseInsensitive = true
    };

    public async Task<VisitorAuthResult> LoginAsync(
        string login,
        string password,
        CancellationToken cancellationToken = default)
    {
        if (string.IsNullOrWhiteSpace(login) || string.IsNullOrWhiteSpace(password))
            return VisitorAuthResult.Fail("Введите логин и пароль.");

        try
        {
            var body = JsonSerializer.Serialize(new { login, password });
            var response = await VisitorJournalHttp.SendAsync(
                AppConfig.ApiBaseUrl,
                "POST",
                "/api/VisitorJournal/auth",
                body,
                "application/json",
                bearerToken: null,
                cancellationToken).ConfigureAwait(false);

            if (response.StatusCode == 401)
                return VisitorAuthResult.Fail(
                    FormatErrorWithCurl("Неверный логин или пароль, либо нет доступа к журналу.", response.CurlCommand),
                    debugCurl: response.CurlCommand);

            if (response.StatusCode == 403)
            {
                var code = TryReadCode(response.Body);
                if (code == -4)
                    return VisitorAuthResult.Fail("Требуется сменить пароль.", passwordChangeRequired: true, debugCurl: response.CurlCommand);
                return VisitorAuthResult.Fail(
                    FormatErrorWithCurl(ExtractErrorMessage(response.Body) ?? "Доступ запрещён.", response.CurlCommand),
                    debugCurl: response.CurlCommand);
            }

            if (response.StatusCode != 200)
                return VisitorAuthResult.Fail(
                    FormatErrorWithCurl(ExtractErrorMessage(response.Body) ?? $"Ошибка сервера ({response.StatusCode}).", response.CurlCommand),
                    debugCurl: response.CurlCommand);

            var auth = JsonSerializer.Deserialize<VisitorAuthResponse>(response.Body, JsonOptions);
            if (auth == null)
                return VisitorAuthResult.Fail(
                    FormatErrorWithCurl("Пустой ответ сервера.", response.CurlCommand),
                    debugCurl: response.CurlCommand);

            if (auth.Code != 0)
                return VisitorAuthResult.Fail(
                    FormatErrorWithCurl(string.IsNullOrWhiteSpace(auth.Message) ? "Ошибка авторизации." : auth.Message, response.CurlCommand),
                    debugCurl: response.CurlCommand);

            if (auth.Data == null || string.IsNullOrWhiteSpace(auth.Data.AccessToken))
                return VisitorAuthResult.Fail(
                    FormatErrorWithCurl(auth.Message ?? "Не удалось получить токен.", response.CurlCommand),
                    debugCurl: response.CurlCommand);

            VisitorSessionStore.SaveTokens(
                auth.Data.Username,
                auth.Data.AccessToken,
                auth.Data.RefreshToken);

            return VisitorAuthResult.Ok();
        }
        catch (VisitorJournalRequestException ex)
        {
            return VisitorAuthResult.Fail(
                FormatErrorWithCurl(ex.Message, ex.CurlCommand),
                debugCurl: ex.CurlCommand);
        }
        catch (OperationCanceledException)
        {
            return VisitorAuthResult.Fail(
                FormatErrorWithCurl("Таймаут при обращении к серверу.", VisitorJournalHttp.LastCurlCommand),
                debugCurl: VisitorJournalHttp.LastCurlCommand);
        }
        catch (Exception ex)
        {
            return VisitorAuthResult.Fail(
                FormatErrorWithCurl(ex.Message, VisitorJournalHttp.LastCurlCommand),
                debugCurl: VisitorJournalHttp.LastCurlCommand);
        }
    }

    public void Logout() => VisitorSessionStore.ClearSession();

    public async Task<IReadOnlyList<VisitReasonDto>> GetReasonsAsync(CancellationToken cancellationToken = default)
    {
        var token = await EnsureAccessTokenAsync(cancellationToken).ConfigureAwait(false);
        if (string.IsNullOrWhiteSpace(token))
            return Array.Empty<VisitReasonDto>();

        try
        {
            var response = await VisitorJournalHttp.SendAsync(
                AppConfig.ApiBaseUrl,
                "GET",
                "/api/VisitorJournal/reasons?activeOnly=true",
                body: null,
                contentType: null,
                bearerToken: token,
                cancellationToken).ConfigureAwait(false);

            if (response.StatusCode == 401)
            {
                VisitorSessionStore.ClearSession();
                return Array.Empty<VisitReasonDto>();
            }

            if (response.StatusCode != 200)
                return Array.Empty<VisitReasonDto>();

            return JsonSerializer.Deserialize<List<VisitReasonDto>>(response.Body, JsonOptions)
                   ?? new List<VisitReasonDto>();
        }
        catch (VisitorJournalRequestException ex)
        {
            System.Diagnostics.Debug.WriteLine(FormatErrorWithCurl(ex.Message, ex.CurlCommand));
            return Array.Empty<VisitReasonDto>();
        }
    }

    private static string FormatErrorWithCurl(string message, string? curl)
    {
        if (string.IsNullOrWhiteSpace(curl))
            return message;

        return $"{message}\n\nCURL:\n{curl}";
    }

    /// <summary>
    /// Регистрация посетителя: POST /api/VisitorJournal.
    /// </summary>
    public async Task<VisitorInsertResult> InsertVisitorAsync(
        string lastName,
        string firstName,
        string? middleName,
        int visitReasonId,
        CancellationToken cancellationToken = default)
    {
        if (string.IsNullOrWhiteSpace(lastName) && string.IsNullOrWhiteSpace(firstName))
            return VisitorInsertResult.Fail("Фамилия и имя обязательны для регистрации.");

        if (visitReasonId <= 0)
            return VisitorInsertResult.Fail("Выберите причину визита.");

        try
        {
            var token = await EnsureAccessTokenAsync(cancellationToken).ConfigureAwait(false);
            if (string.IsNullOrWhiteSpace(token))
                return VisitorInsertResult.Fail("Требуется авторизация. Войдите снова.");

            var request = new CreateVisitorRegistrationRequest
            {
                VisitDate = DateTime.Today,
                LastName = lastName.Trim(),
                FirstName = firstName.Trim(),
                MiddleName = string.IsNullOrWhiteSpace(middleName) ? null : middleName.Trim(),
                VisitReasonId = visitReasonId
            };

            var json = JsonSerializer.Serialize(request, JsonOptions);
            var response = await VisitorJournalHttp.SendAsync(
                AppConfig.ApiBaseUrl,
                "POST",
                "/api/VisitorJournal",
                json,
                "application/json",
                bearerToken: token,
                cancellationToken).ConfigureAwait(false);

            if (response.StatusCode is 200 or 201)
            {
                var entry = JsonSerializer.Deserialize<VisitorRegistrationDto>(response.Body, JsonOptions);
                if (entry != null)
                    return VisitorInsertResult.Ok(entry);
            }

            if (response.StatusCode == 401)
            {
                VisitorSessionStore.ClearSession();
                return VisitorInsertResult.Fail("Сессия истекла. Войдите снова.");
            }

            return VisitorInsertResult.Fail(ExtractErrorMessage(response.Body) ?? $"Ошибка сервера ({response.StatusCode}).", response.CurlCommand);
        }
        catch (VisitorJournalRequestException ex)
        {
            return VisitorInsertResult.Fail(FormatErrorWithCurl(ex.Message, ex.CurlCommand), ex.CurlCommand);
        }
        catch (OperationCanceledException)
        {
            return VisitorInsertResult.Fail(
                FormatErrorWithCurl("Таймаут при обращении к серверу.", VisitorJournalHttp.LastCurlCommand),
                VisitorJournalHttp.LastCurlCommand);
        }
        catch (Exception ex)
        {
            return VisitorInsertResult.Fail(
                FormatErrorWithCurl(ex.Message, VisitorJournalHttp.LastCurlCommand),
                VisitorJournalHttp.LastCurlCommand);
        }
    }

    private static Task<string?> EnsureAccessTokenAsync(CancellationToken cancellationToken)
    {
        if (!VisitorSessionStore.IsAuthenticated)
            return Task.FromResult<string?>(null);

        return Task.FromResult(VisitorSessionStore.AccessToken);
    }

    private static int TryReadCode(string body)
    {
        try
        {
            using var doc = JsonDocument.Parse(body);
            if (doc.RootElement.TryGetProperty("code", out var code) && code.TryGetInt32(out var value))
                return value;
        }
        catch
        {
            // ignore
        }

        return 0;
    }

    private static string? ExtractErrorMessage(string body)
    {
        if (string.IsNullOrWhiteSpace(body))
            return null;

        try
        {
            using var doc = JsonDocument.Parse(body);
            if (doc.RootElement.TryGetProperty("error", out var error))
                return error.GetString();
            if (doc.RootElement.TryGetProperty("message", out var message))
                return message.GetString();
        }
        catch
        {
            // ignore
        }

        return body.Length > 200 ? body[..200] : body;
    }
}
