using CleverPos.License.Api.Data;
using CleverPos.License.Api.DTOs;
using CleverPos.License.Api.Models;
using CleverPos.License.Api.Options;
using CleverPos.License.Core;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;

namespace CleverPos.License.Api.Services;

public class LicenseService
{
    private readonly LicenseDbContext _db;
    private readonly LicenseSigningOptions _signing;

    public LicenseService(LicenseDbContext db, IOptions<LicenseSigningOptions> signing)
    {
        _db = db;
        _signing = signing.Value;
    }

    public static (int Year, int Month) CurrentPeriodUtc() => LicensePeriod.CurrentUtc();

    public Task<ValidateLicenseResponse> ValidateAsync(ValidateLicenseRequest request, CancellationToken cancellationToken)
        => RenewAsync(request, cancellationToken);

    public async Task<ValidateLicenseResponse> RenewAsync(ValidateLicenseRequest request, CancellationToken cancellationToken)
    {
        string licenseKey = (request.LicenseKey ?? string.Empty).Trim();
        string computerId = (request.ComputerId ?? string.Empty).Trim();
        if (string.IsNullOrWhiteSpace(licenseKey) || string.IsNullOrWhiteSpace(computerId))
        {
            return await DenyAsync(request, null, "Нужны LicenseKey и ComputerId.", false, cancellationToken)
                .ConfigureAwait(false);
        }

        LicenseRecord? license = await LoadByKeyAsync(licenseKey, cancellationToken).ConfigureAwait(false);
        if (license == null || !license.IsActive)
        {
            return await DenyAsync(request, license?.Id, "Лицензия не найдена или отключена.", false, cancellationToken)
                .ConfigureAwait(false);
        }

        if (string.IsNullOrWhiteSpace(license.CompanyName) && !string.IsNullOrWhiteSpace(request.CompanyName))
        {
            license.CompanyName = request.CompanyName.Trim();
        }

        (int year, int month) = CurrentPeriodUtc();
        bool currentMonthPaid = license.Payments.Any(p => p.PeriodYear == year && p.PeriodMonth == month);
        if (!currentMonthPaid)
        {
            return await DenyAsync(request, license.Id, "Оплата за текущий месяц не поступила.", false, cancellationToken)
                .ConfigureAwait(false);
        }

        LicenseActivation? existing = license.Activations
            .FirstOrDefault(x => string.Equals(x.ComputerId, computerId, StringComparison.OrdinalIgnoreCase));

        if (existing == null)
        {
            int activeCount = license.Activations.Count(x => x.IsActive);
            int maxActivations = Math.Max(1, license.MaxActivations);
            if (activeCount >= maxActivations)
            {
                string bound = license.Activations
                    .Where(x => x.IsActive)
                    .Select(x => string.IsNullOrWhiteSpace(x.MachineName)
                        ? x.ComputerId
                        : x.MachineName + " / " + x.ComputerId)
                    .FirstOrDefault() ?? "другой компьютер";

                return await DenyAsync(
                        request,
                        license.Id,
                        "Лицензия уже привязана к другому компьютеру (" + bound + "). В админке нажмите «Разрешить другой ПК».",
                        true,
                        cancellationToken)
                    .ConfigureAwait(false);
            }

            existing = new LicenseActivation
            {
                LicenseId = license.Id,
                ComputerId = computerId,
                MachineName = string.IsNullOrWhiteSpace(request.MachineName) ? null : request.MachineName.Trim(),
                ActivatedAtUtc = DateTime.UtcNow,
                LastSeenAtUtc = DateTime.UtcNow,
                IsActive = true
            };
            _db.Activations.Add(existing);
        }
        else
        {
            existing.IsActive = true;
            existing.LastSeenAtUtc = DateTime.UtcNow;
            if (!string.IsNullOrWhiteSpace(request.MachineName))
            {
                existing.MachineName = request.MachineName.Trim();
            }
        }

        DateTime validUntil = LicensePeriod.ValidUntilExclusiveUtc(year, month);
        var payload = new LicensePayload
        {
            LicenseKey = license.LicenseKey,
            HardwareId = computerId,
            Company = license.CompanyName ?? request.CompanyName ?? string.Empty,
            Reseller = "CleverPos",
            IssuedAtUtc = DateTime.UtcNow,
            ValidUntilUtc = validUntil
        };

        string licenceFile = LicenseIssueService.IssueSignedLicenceFile(payload, _signing.ResolvePrivateKeyXml());
        license.ExpiresAtUtc = validUntil;

        AddAccessLog(
            request,
            license.Id,
            allowed: true,
            message: "OK",
            source: "renew");

        await _db.SaveChangesAsync(cancellationToken).ConfigureAwait(false);

        return new ValidateLicenseResponse
        {
            Allowed = true,
            Message = "OK",
            CurrentMonthPaid = true,
            ValidUntilUtc = validUntil,
            ExpiresAtUtc = validUntil,
            LicenceFileContent = licenceFile
        };
    }

    public async Task<string?> IssueFileForLicenseAsync(Guid licenseId, string? computerId, CancellationToken cancellationToken)
    {
        LicenseRecord? license = await LoadByIdAsync(licenseId, cancellationToken).ConfigureAwait(false);
        if (license == null)
        {
            return null;
        }

        (int year, int month) = CurrentPeriodUtc();
        if (!license.Payments.Any(p => p.PeriodYear == year && p.PeriodMonth == month))
        {
            throw new InvalidOperationException("Нет оплаты за текущий месяц — файл не выдаётся.");
        }

        string hw = computerId ?? string.Empty;
        if (string.IsNullOrWhiteSpace(hw))
        {
            hw = license.Activations.FirstOrDefault(a => a.IsActive)?.ComputerId ?? string.Empty;
        }

        if (string.IsNullOrWhiteSpace(hw))
        {
            throw new InvalidOperationException("Нет привязанного компьютера. Укажите ComputerId или дождитесь первого renew с кассы.");
        }

        var payload = new LicensePayload
        {
            LicenseKey = license.LicenseKey,
            HardwareId = hw.Trim(),
            Company = license.CompanyName ?? string.Empty,
            Reseller = "CleverPos",
            IssuedAtUtc = DateTime.UtcNow,
            ValidUntilUtc = LicensePeriod.ValidUntilExclusiveUtc(year, month)
        };

        return LicenseIssueService.IssueSignedLicenceFile(payload, _signing.ResolvePrivateKeyXml());
    }

    public async Task<LicenseListItem> CreateAsync(CreateLicenseRequest request, CancellationToken cancellationToken)
    {
        string key = string.IsNullOrWhiteSpace(request.LicenseKey)
            ? Guid.NewGuid().ToString("N").ToUpperInvariant()
            : request.LicenseKey.Trim();

        if (await _db.Licenses.AnyAsync(x => x.LicenseKey == key, cancellationToken).ConfigureAwait(false))
        {
            throw new InvalidOperationException("Такой LicenseKey уже существует.");
        }

        var license = new LicenseRecord
        {
            LicenseKey = key,
            CompanyName = string.IsNullOrWhiteSpace(request.CompanyName) ? null : request.CompanyName.Trim(),
            MaxActivations = request.MaxActivations <= 0 ? 1 : request.MaxActivations,
            ExpiresAtUtc = request.ExpiresAtUtc,
            IsActive = true,
            CreatedAtUtc = DateTime.UtcNow
        };

        _db.Licenses.Add(license);

        if (!string.IsNullOrWhiteSpace(request.BindComputerId))
        {
            _db.Activations.Add(new LicenseActivation
            {
                LicenseId = license.Id,
                ComputerId = request.BindComputerId.Trim(),
                MachineName = string.IsNullOrWhiteSpace(request.BindMachineName) ? null : request.BindMachineName.Trim()
            });
        }

        if (request.MarkCurrentMonthPaid)
        {
            (int year, int month) = CurrentPeriodUtc();
            _db.Payments.Add(new LicensePayment
            {
                LicenseId = license.Id,
                PeriodYear = year,
                PeriodMonth = month,
                Amount = request.FirstMonthAmount,
                PaidAtUtc = DateTime.UtcNow,
                Comment = "Первый месяц при создании лицензии"
            });
            license.ExpiresAtUtc = LicensePeriod.ValidUntilExclusiveUtc(year, month);
        }

        await _db.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
        return await GetAsync(license.Id, cancellationToken).ConfigureAwait(false)
               ?? throw new InvalidOperationException("Лицензия не сохранилась.");
    }

    private async Task<LicenseRecord?> LoadByKeyAsync(string licenseKey, CancellationToken cancellationToken)
    {
        return await _db.Licenses
            .Include(x => x.Activations)
            .Include(x => x.Payments)
            .FirstOrDefaultAsync(x => x.LicenseKey == licenseKey, cancellationToken)
            .ConfigureAwait(false);
    }

    private async Task<LicenseRecord?> LoadByIdAsync(Guid id, CancellationToken cancellationToken)
    {
        return await _db.Licenses
            .Include(x => x.Activations)
            .Include(x => x.Payments)
            .FirstOrDefaultAsync(x => x.Id == id, cancellationToken)
            .ConfigureAwait(false);
    }

    public async Task<IReadOnlyList<LicenseListItem>> ListAsync(CancellationToken cancellationToken)
    {
        List<LicenseRecord> licenses = await _db.Licenses
            .AsNoTracking()
            .Include(x => x.Activations)
            .Include(x => x.Payments)
            .OrderByDescending(x => x.CreatedAtUtc)
            .ToListAsync(cancellationToken)
            .ConfigureAwait(false);

        return licenses.Select(Map).ToList();
    }

    public async Task<LicenseListItem?> GetAsync(Guid id, CancellationToken cancellationToken)
    {
        LicenseRecord? license = await _db.Licenses
            .AsNoTracking()
            .Include(x => x.Activations)
            .Include(x => x.Payments)
            .FirstOrDefaultAsync(x => x.Id == id, cancellationToken)
            .ConfigureAwait(false);

        return license == null ? null : Map(license);
    }

    public async Task<bool> ClearComputerAsync(Guid licenseId, CancellationToken cancellationToken)
    {
        LicenseRecord? license = await _db.Licenses
            .Include(x => x.Activations)
            .FirstOrDefaultAsync(x => x.Id == licenseId, cancellationToken)
            .ConfigureAwait(false);

        if (license == null)
        {
            return false;
        }

        string previous = string.Join("; ",
            license.Activations
                .Where(x => x.IsActive)
                .Select(x => string.IsNullOrWhiteSpace(x.MachineName)
                    ? x.ComputerId
                    : x.MachineName + " / " + x.ComputerId));

        if (license.Activations.Count > 0)
        {
            _db.Activations.RemoveRange(license.Activations);
        }

        _db.AccessLogs.Add(new LicenseAccessLog
        {
            LicenseId = license.Id,
            LicenseKey = license.LicenseKey,
            ComputerId = previous,
            MachineName = null,
            CompanyName = license.CompanyName,
            Allowed = true,
            Message = string.IsNullOrWhiteSpace(previous)
                ? "Админ: привязка ПК очищена (ожидание нового компьютера)."
                : "Админ: отвязан ПК [" + previous + "]. Следующий запуск кассы сможет привязаться.",
            Source = "admin-transfer",
            CreatedAtUtc = DateTime.UtcNow
        });

        await _db.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
        return true;
    }

    public async Task<IReadOnlyList<AccessLogItem>> ListAccessLogsAsync(
        Guid? licenseId,
        int take,
        CancellationToken cancellationToken)
    {
        if (take <= 0)
        {
            take = 200;
        }

        take = Math.Min(take, 1000);

        IQueryable<LicenseAccessLog> query = _db.AccessLogs.AsNoTracking();
        if (licenseId.HasValue)
        {
            query = query.Where(x => x.LicenseId == licenseId.Value);
        }

        List<LicenseAccessLog> rows = await query
            .OrderByDescending(x => x.CreatedAtUtc)
            .Take(take)
            .ToListAsync(cancellationToken)
            .ConfigureAwait(false);

        return rows.Select(x => new AccessLogItem
        {
            Id = x.Id,
            LicenseId = x.LicenseId,
            LicenseKey = x.LicenseKey,
            CompanyName = x.CompanyName,
            ComputerId = x.ComputerId,
            MachineName = x.MachineName,
            Allowed = x.Allowed,
            Message = x.Message,
            ClientIp = x.ClientIp,
            Source = x.Source,
            CreatedAtUtc = x.CreatedAtUtc
        }).ToList();
    }

    public async Task<LicenseListItem?> MarkPaidAsync(Guid licenseId, MarkPaymentRequest request, CancellationToken cancellationToken)
    {
        LicenseRecord? license = await _db.Licenses.FirstOrDefaultAsync(x => x.Id == licenseId, cancellationToken).ConfigureAwait(false);
        if (license == null)
        {
            return null;
        }

        (int currentYear, int currentMonth) = CurrentPeriodUtc();
        int year = request.Year ?? currentYear;
        int month = request.Month ?? currentMonth;
        if (month is < 1 or > 12)
        {
            throw new InvalidOperationException("Месяц должен быть от 1 до 12.");
        }

        LicensePayment? existing = await _db.Payments
            .FirstOrDefaultAsync(x => x.LicenseId == licenseId && x.PeriodYear == year && x.PeriodMonth == month, cancellationToken)
            .ConfigureAwait(false);

        if (existing == null)
        {
            _db.Payments.Add(new LicensePayment
            {
                LicenseId = licenseId,
                PeriodYear = year,
                PeriodMonth = month,
                Amount = request.Amount,
                PaidAtUtc = DateTime.UtcNow,
                Comment = string.IsNullOrWhiteSpace(request.Comment) ? null : request.Comment.Trim()
            });
        }
        else
        {
            existing.Amount = request.Amount ?? existing.Amount;
            existing.PaidAtUtc = DateTime.UtcNow;
            if (!string.IsNullOrWhiteSpace(request.Comment))
            {
                existing.Comment = request.Comment.Trim();
            }
        }

        license.ExpiresAtUtc = LicensePeriod.ValidUntilExclusiveUtc(year, month);
        await _db.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
        return await GetAsync(licenseId, cancellationToken).ConfigureAwait(false);
    }

    public async Task<LicenseListItem?> SetActiveAsync(Guid licenseId, bool isActive, CancellationToken cancellationToken)
    {
        LicenseRecord? license = await _db.Licenses.FirstOrDefaultAsync(x => x.Id == licenseId, cancellationToken).ConfigureAwait(false);
        if (license == null)
        {
            return null;
        }

        license.IsActive = isActive;
        await _db.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
        return await GetAsync(licenseId, cancellationToken).ConfigureAwait(false);
    }

    private async Task<ValidateLicenseResponse> DenyAsync(
        ValidateLicenseRequest request,
        Guid? licenseId,
        string message,
        bool currentMonthPaid,
        CancellationToken cancellationToken)
    {
        AddAccessLog(request, licenseId, allowed: false, message: message, source: "renew");
        await _db.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
        return new ValidateLicenseResponse
        {
            Allowed = false,
            Message = message,
            CurrentMonthPaid = currentMonthPaid
        };
    }

    private void AddAccessLog(
        ValidateLicenseRequest request,
        Guid? licenseId,
        bool allowed,
        string message,
        string source)
    {
        _db.AccessLogs.Add(new LicenseAccessLog
        {
            LicenseId = licenseId,
            LicenseKey = (request.LicenseKey ?? string.Empty).Trim(),
            ComputerId = (request.ComputerId ?? string.Empty).Trim(),
            MachineName = string.IsNullOrWhiteSpace(request.MachineName) ? null : request.MachineName.Trim(),
            CompanyName = string.IsNullOrWhiteSpace(request.CompanyName) ? null : request.CompanyName.Trim(),
            Allowed = allowed,
            Message = message,
            ClientIp = string.IsNullOrWhiteSpace(request.ClientIp) ? null : request.ClientIp.Trim(),
            Source = source,
            CreatedAtUtc = DateTime.UtcNow
        });
    }

    private static LicenseListItem Map(LicenseRecord license)
    {
        (int year, int month) = CurrentPeriodUtc();
        LicensePayment? lastPaid = license.Payments
            .OrderByDescending(p => p.PeriodYear)
            .ThenByDescending(p => p.PeriodMonth)
            .FirstOrDefault();

        return new LicenseListItem
        {
            Id = license.Id,
            LicenseKey = license.LicenseKey,
            CompanyName = license.CompanyName,
            MaxActivations = license.MaxActivations,
            IsActive = license.IsActive,
            ExpiresAtUtc = license.ExpiresAtUtc,
            ActiveComputers = license.Activations.Count(a => a.IsActive),
            CurrentMonthPaid = license.Payments.Any(p => p.PeriodYear == year && p.PeriodMonth == month),
            PaidThroughYear = lastPaid?.PeriodYear,
            PaidThroughMonth = lastPaid?.PeriodMonth,
            ComputerIds = license.Activations.Where(a => a.IsActive).Select(a => a.ComputerId).ToList(),
            Computers = license.Activations
                .OrderByDescending(a => a.IsActive)
                .ThenByDescending(a => a.LastSeenAtUtc)
                .Select(a => new ComputerBindingDto
                {
                    ActivationId = a.Id,
                    ComputerId = a.ComputerId,
                    MachineName = a.MachineName,
                    ActivatedAtUtc = a.ActivatedAtUtc,
                    LastSeenAtUtc = a.LastSeenAtUtc
                })
                .ToList(),
            Payments = license.Payments
                .OrderByDescending(p => p.PeriodYear)
                .ThenByDescending(p => p.PeriodMonth)
                .Select(p => new PaymentDto
                {
                    Id = p.Id,
                    Year = p.PeriodYear,
                    Month = p.PeriodMonth,
                    Amount = p.Amount,
                    PaidAtUtc = p.PaidAtUtc,
                    Comment = p.Comment
                })
                .ToList()
        };
    }
}
