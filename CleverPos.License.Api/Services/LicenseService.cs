using CleverPos.License.Api.Data;
using CleverPos.License.Api.DTOs;
using CleverPos.License.Api.Models;
using Microsoft.EntityFrameworkCore;

namespace CleverPos.License.Api.Services;

public class LicenseService
{
    private readonly LicenseDbContext _db;

    public LicenseService(LicenseDbContext db)
    {
        _db = db;
    }

    public static (int Year, int Month) CurrentPeriodUtc()
    {
        DateTime now = DateTime.UtcNow;
        return (now.Year, now.Month);
    }

    public async Task<ValidateLicenseResponse> ValidateAsync(ValidateLicenseRequest request, CancellationToken cancellationToken)
    {
        string licenseKey = (request.LicenseKey ?? string.Empty).Trim();
        string computerId = (request.ComputerId ?? string.Empty).Trim();
        if (string.IsNullOrWhiteSpace(licenseKey) || string.IsNullOrWhiteSpace(computerId))
        {
            return await FinishValidateAsync(
                request,
                licenseId: null,
                allowed: false,
                message: "Нужны LicenseKey и ComputerId.",
                currentMonthPaid: false,
                cancellationToken).ConfigureAwait(false);
        }

        LicenseRecord? license = await LoadByKeyAsync(licenseKey, cancellationToken).ConfigureAwait(false);
        if (license == null)
        {
            license = await ProvisionFirstNightAsync(request, cancellationToken).ConfigureAwait(false);
        }

        if (license == null || !license.IsActive)
        {
            return await FinishValidateAsync(
                request,
                license?.Id,
                allowed: false,
                message: "Лицензия не найдена или отключена.",
                currentMonthPaid: false,
                cancellationToken).ConfigureAwait(false);
        }

        if (string.IsNullOrWhiteSpace(license.CompanyName) && !string.IsNullOrWhiteSpace(request.CompanyName))
        {
            license.CompanyName = request.CompanyName.Trim();
        }

        (int year, int month) = CurrentPeriodUtc();
        bool currentMonthPaid = license.Payments.Any(p => p.PeriodYear == year && p.PeriodMonth == month);
        if (!currentMonthPaid)
        {
            return await FinishValidateAsync(
                request,
                license.Id,
                allowed: false,
                message: "Оплата за текущий месяц не поступила.",
                currentMonthPaid: false,
                cancellationToken).ConfigureAwait(false);
        }

        LicenseActivation? existing = license.Activations
            .FirstOrDefault(x => string.Equals(x.ComputerId, computerId, StringComparison.OrdinalIgnoreCase));

        if (existing != null)
        {
            existing.IsActive = true;
            existing.LastSeenAtUtc = DateTime.UtcNow;
            if (!string.IsNullOrWhiteSpace(request.MachineName))
            {
                existing.MachineName = request.MachineName.Trim();
            }

            return await FinishValidateAsync(
                request,
                license.Id,
                allowed: true,
                message: "OK",
                currentMonthPaid: true,
                cancellationToken).ConfigureAwait(false);
        }

        int activeCount = license.Activations.Count(x => x.IsActive);
        int maxActivations = Math.Max(1, license.MaxActivations);
        if (activeCount >= maxActivations)
        {
            string bound = license.Activations
                .Where(x => x.IsActive)
                .Select(x => string.IsNullOrWhiteSpace(x.MachineName) ? x.ComputerId : x.MachineName + " / " + x.ComputerId)
                .FirstOrDefault() ?? "другой компьютер";

            return await FinishValidateAsync(
                request,
                license.Id,
                allowed: false,
                message: "Лицензия уже привязана к другому компьютеру (" + bound + "). В админке нажмите «Разрешить другой ПК».",
                currentMonthPaid: true,
                cancellationToken).ConfigureAwait(false);
        }

        _db.Activations.Add(new LicenseActivation
        {
            LicenseId = license.Id,
            ComputerId = computerId,
            MachineName = string.IsNullOrWhiteSpace(request.MachineName) ? null : request.MachineName.Trim(),
            ActivatedAtUtc = DateTime.UtcNow,
            LastSeenAtUtc = DateTime.UtcNow,
            IsActive = true
        });

        return await FinishValidateAsync(
            request,
            license.Id,
            allowed: true,
            message: "Компьютер зарегистрирован.",
            currentMonthPaid: true,
            cancellationToken).ConfigureAwait(false);
    }

    private async Task<ValidateLicenseResponse> FinishValidateAsync(
        ValidateLicenseRequest request,
        Guid? licenseId,
        bool allowed,
        string message,
        bool currentMonthPaid,
        CancellationToken cancellationToken)
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
            Source = "validate",
            CreatedAtUtc = DateTime.UtcNow
        });

        await _db.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
        return new ValidateLicenseResponse
        {
            Allowed = allowed,
            Message = message,
            CurrentMonthPaid = currentMonthPaid
        };
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

    private async Task<LicenseRecord?> ProvisionFirstNightAsync(ValidateLicenseRequest request, CancellationToken cancellationToken)
    {
        string licenseKey = request.LicenseKey.Trim();
        (int year, int month) = CurrentPeriodUtc();

        var license = new LicenseRecord
        {
            LicenseKey = licenseKey,
            CompanyName = string.IsNullOrWhiteSpace(request.CompanyName) ? null : request.CompanyName.Trim(),
            MaxActivations = 1,
            IsActive = true,
            CreatedAtUtc = DateTime.UtcNow
        };

        _db.Licenses.Add(license);
        _db.Payments.Add(new LicensePayment
        {
            LicenseId = license.Id,
            PeriodYear = year,
            PeriodMonth = month,
            PaidAtUtc = DateTime.UtcNow,
            Comment = "Автосоздание при первом запуске кассы"
        });

        try
        {
            await _db.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
        }
        catch (DbUpdateException)
        {
            foreach (Microsoft.EntityFrameworkCore.ChangeTracking.EntityEntry entry in _db.ChangeTracker.Entries().ToList())
            {
                entry.State = EntityState.Detached;
            }
        }

        return await LoadByKeyAsync(licenseKey, cancellationToken).ConfigureAwait(false);
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
        if (!await _db.Licenses.AnyAsync(x => x.Id == licenseId, cancellationToken).ConfigureAwait(false))
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
