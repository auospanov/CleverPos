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

    public async Task<ValidateLicenseResponse> ValidateAsync(ValidateLicenseRequest request, CancellationToken cancellationToken)
    {
        string licenseKey = (request.LicenseKey ?? string.Empty).Trim();
        string computerId = (request.ComputerId ?? string.Empty).Trim();
        if (string.IsNullOrWhiteSpace(licenseKey) || string.IsNullOrWhiteSpace(computerId))
        {
            return new ValidateLicenseResponse { Allowed = false, Message = "LicenseKey and ComputerId are required." };
        }

        LicenseRecord? license = await _db.Licenses
            .Include(x => x.Activations)
            .FirstOrDefaultAsync(x => x.LicenseKey == licenseKey, cancellationToken)
            .ConfigureAwait(false);

        if (license == null || !license.IsActive)
        {
            return new ValidateLicenseResponse { Allowed = false, Message = "License not found or inactive." };
        }

        if (license.ExpiresAtUtc.HasValue && license.ExpiresAtUtc.Value < DateTime.UtcNow)
        {
            return new ValidateLicenseResponse { Allowed = false, Message = "License expired.", ExpiresAtUtc = license.ExpiresAtUtc };
        }

        LicenseActivation? existing = license.Activations
            .FirstOrDefault(x => string.Equals(x.ComputerId, computerId, StringComparison.OrdinalIgnoreCase) && x.IsActive);

        if (existing != null)
        {
            existing.LastSeenAtUtc = DateTime.UtcNow;
            if (!string.IsNullOrWhiteSpace(request.MachineName))
            {
                existing.MachineName = request.MachineName.Trim();
            }

            await _db.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
            return new ValidateLicenseResponse
            {
                Allowed = true,
                Message = "OK",
                ExpiresAtUtc = license.ExpiresAtUtc
            };
        }

        int activeCount = license.Activations.Count(x => x.IsActive);
        if (activeCount >= Math.Max(1, license.MaxActivations))
        {
            return new ValidateLicenseResponse
            {
                Allowed = false,
                Message = "This license is already bound to another computer.",
                ExpiresAtUtc = license.ExpiresAtUtc
            };
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

        await _db.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
        return new ValidateLicenseResponse
        {
            Allowed = true,
            Message = "Activated on this computer.",
            ExpiresAtUtc = license.ExpiresAtUtc
        };
    }

    public async Task<LicenseListItem> CreateAsync(CreateLicenseRequest request, CancellationToken cancellationToken)
    {
        string key = string.IsNullOrWhiteSpace(request.LicenseKey)
            ? Guid.NewGuid().ToString("N").ToUpperInvariant()
            : request.LicenseKey.Trim();

        if (await _db.Licenses.AnyAsync(x => x.LicenseKey == key, cancellationToken).ConfigureAwait(false))
        {
            throw new InvalidOperationException("LicenseKey already exists.");
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

        await _db.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
        return await GetAsync(license.Id, cancellationToken).ConfigureAwait(false)
               ?? throw new InvalidOperationException("License was not saved.");
    }

    public async Task<IReadOnlyList<LicenseListItem>> ListAsync(CancellationToken cancellationToken)
    {
        return await _db.Licenses
            .AsNoTracking()
            .OrderByDescending(x => x.CreatedAtUtc)
            .Select(x => new LicenseListItem
            {
                Id = x.Id,
                LicenseKey = x.LicenseKey,
                CompanyName = x.CompanyName,
                MaxActivations = x.MaxActivations,
                IsActive = x.IsActive,
                ExpiresAtUtc = x.ExpiresAtUtc,
                ActiveComputers = x.Activations.Count(a => a.IsActive),
                ComputerIds = x.Activations.Where(a => a.IsActive).Select(a => a.ComputerId).ToList()
            })
            .ToListAsync(cancellationToken)
            .ConfigureAwait(false);
    }

    public async Task<LicenseListItem?> GetAsync(Guid id, CancellationToken cancellationToken)
    {
        return await _db.Licenses
            .AsNoTracking()
            .Where(x => x.Id == id)
            .Select(x => new LicenseListItem
            {
                Id = x.Id,
                LicenseKey = x.LicenseKey,
                CompanyName = x.CompanyName,
                MaxActivations = x.MaxActivations,
                IsActive = x.IsActive,
                ExpiresAtUtc = x.ExpiresAtUtc,
                ActiveComputers = x.Activations.Count(a => a.IsActive),
                ComputerIds = x.Activations.Where(a => a.IsActive).Select(a => a.ComputerId).ToList()
            })
            .FirstOrDefaultAsync(cancellationToken)
            .ConfigureAwait(false);
    }
}
