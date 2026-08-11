using System.Globalization;
using System.Text.Json;
using CleverPos.License.Api.Data;
using CleverPos.License.Api.Hubs;
using CleverPos.License.Api.Models;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;

namespace CleverPos.License.Api.Services;

public class CloudSyncService
{
    private readonly LicenseDbContext _db;
    private readonly IHubContext<CloudSyncHub> _hub;
    private readonly ILogger<CloudSyncService> _logger;

    public CloudSyncService(LicenseDbContext db, IHubContext<CloudSyncHub> hub, ILogger<CloudSyncService> logger)
    {
        _db = db;
        _hub = hub;
        _logger = logger;
    }

    public async Task<(bool Ok, string Message, int Accepted, IReadOnlyList<string> AcceptedKeys)> IngestAsync(
        CloudSyncBatchRequest request,
        CancellationToken ct)
    {
        string licenseKey = (request.LicenseKey ?? string.Empty).Trim();
        string computerId = (request.ComputerId ?? string.Empty).Trim();
        string storeId = (request.StoreId ?? string.Empty).Trim();
        if (string.IsNullOrWhiteSpace(licenseKey) || string.IsNullOrWhiteSpace(computerId) || string.IsNullOrWhiteSpace(storeId))
        {
            return (false, "Нужны licenseKey, computerId и storeId.", 0, Array.Empty<string>());
        }

        LicenseRecord? license = await _db.Licenses
            .Include(l => l.Activations)
            .FirstOrDefaultAsync(l => l.LicenseKey == licenseKey, ct)
            .ConfigureAwait(false);

        if (license == null || !license.IsActive)
        {
            return (false, "Лицензия не найдена или отключена.", 0, Array.Empty<string>());
        }

        LicenseActivation? activation = license.Activations
            .FirstOrDefault(a => a.IsActive && string.Equals(a.ComputerId, computerId, StringComparison.OrdinalIgnoreCase));
        if (activation == null)
        {
            return (false, "Касса не активирована для этой лицензии.", 0, Array.Empty<string>());
        }

        activation.LastSeenAtUtc = DateTime.UtcNow;
        if (!string.IsNullOrWhiteSpace(request.MachineName))
        {
            activation.MachineName = request.MachineName.Trim();
        }

        await UpsertTillPresenceAsync(license.Id, storeId, computerId, request.MachineName, request.Events?.Count ?? 0, ct)
            .ConfigureAwait(false);

        List<string> accepted = new();
        foreach (CloudSyncEventDto evt in request.Events ?? new List<CloudSyncEventDto>())
        {
            if (string.IsNullOrWhiteSpace(evt.IdempotencyKey) || string.IsNullOrWhiteSpace(evt.EventType))
            {
                continue;
            }

            try
            {
                if (string.Equals(evt.EventType, "stock_balance", StringComparison.OrdinalIgnoreCase))
                {
                    await ApplyStockAsync(license.Id, storeId, evt, ct).ConfigureAwait(false);
                    accepted.Add(evt.IdempotencyKey);
                }
                else if (string.Equals(evt.EventType, "sale_committed", StringComparison.OrdinalIgnoreCase))
                {
                    if (await ApplySaleAsync(license.Id, storeId, evt, ct).ConfigureAwait(false))
                    {
                        accepted.Add(evt.IdempotencyKey);
                    }
                    else
                    {
                        accepted.Add(evt.IdempotencyKey); // already present = ack
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "Cloud sync event failed {Key}", evt.IdempotencyKey);
            }
        }

        await _db.SaveChangesAsync(ct).ConfigureAwait(false);

        try
        {
            await _hub.Clients.Group(CloudSyncHub.LicenseGroup(license.Id))
                .SendAsync("storeUpdated", new { licenseId = license.Id, storeId }, ct)
                .ConfigureAwait(false);
        }
        catch (Exception ex)
        {
            _logger.LogDebug(ex, "SignalR notify skipped");
        }

        return (true, "ok", accepted.Count, accepted);
    }

    public async Task<CloudDashboardDto> GetDashboardForLicenseAsync(Guid licenseId, CancellationToken ct)
    {
        List<CloudTillPresence> tills = await _db.CloudTillPresences
            .Where(t => t.LicenseId == licenseId)
            .OrderBy(t => t.StoreId)
            .ThenBy(t => t.MachineName)
            .ToListAsync(ct)
            .ConfigureAwait(false);

        var stockByStore = await _db.CloudStockBalances
            .Where(s => s.LicenseId == licenseId)
            .GroupBy(s => s.StoreId)
            .Select(g => new { StoreId = g.Key, SkuCount = g.Count(), Qty = g.Sum(x => x.Accounting) })
            .ToListAsync(ct)
            .ConfigureAwait(false);

        string today = DateTime.UtcNow.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
        var salesToday = await _db.CloudSaleEvents
            .Where(s => s.LicenseId == licenseId && s.Day == today)
            .GroupBy(s => s.StoreId)
            .Select(g => new { StoreId = g.Key, Count = g.Count(), Total = g.Sum(x => x.Total) })
            .ToListAsync(ct)
            .ConfigureAwait(false);

        List<string> storeIds = tills.Select(t => t.StoreId)
            .Concat(stockByStore.Select(s => s.StoreId))
            .Concat(salesToday.Select(s => s.StoreId))
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .OrderBy(s => s)
            .ToList();

        return new CloudDashboardDto
        {
            LicenseId = licenseId,
            Stores = storeIds.Select(storeId => new CloudStoreDto
            {
                StoreId = storeId,
                SkuCount = stockByStore.FirstOrDefault(s => s.StoreId == storeId)?.SkuCount ?? 0,
                StockQty = stockByStore.FirstOrDefault(s => s.StoreId == storeId)?.Qty ?? 0,
                SalesTodayCount = salesToday.FirstOrDefault(s => s.StoreId == storeId)?.Count ?? 0,
                SalesTodayTotal = salesToday.FirstOrDefault(s => s.StoreId == storeId)?.Total ?? 0,
                Tills = tills.Where(t => string.Equals(t.StoreId, storeId, StringComparison.OrdinalIgnoreCase))
                    .Select(t => new CloudTillDto
                    {
                        ComputerId = t.ComputerId,
                        MachineName = t.MachineName,
                        LastSeenAtUtc = t.LastSeenAtUtc
                    })
                    .ToList()
            }).ToList()
        };
    }

    public async Task<List<CloudStockBalance>> GetStockAsync(Guid licenseId, string? storeId, CancellationToken ct)
    {
        IQueryable<CloudStockBalance> q = _db.CloudStockBalances.Where(s => s.LicenseId == licenseId);
        if (!string.IsNullOrWhiteSpace(storeId))
        {
            q = q.Where(s => s.StoreId == storeId);
        }

        return await q.OrderBy(s => s.Designation).Take(500).ToListAsync(ct).ConfigureAwait(false);
    }

    private async Task UpsertTillPresenceAsync(
        Guid licenseId,
        string storeId,
        string computerId,
        string? machineName,
        int pending,
        CancellationToken ct)
    {
        CloudTillPresence? row = await _db.CloudTillPresences
            .FirstOrDefaultAsync(
                t => t.LicenseId == licenseId && t.StoreId == storeId && t.ComputerId == computerId,
                ct)
            .ConfigureAwait(false);

        if (row == null)
        {
            row = new CloudTillPresence
            {
                LicenseId = licenseId,
                StoreId = storeId,
                ComputerId = computerId
            };
            _db.CloudTillPresences.Add(row);
        }

        row.MachineName = string.IsNullOrWhiteSpace(machineName) ? row.MachineName : machineName.Trim();
        row.LastSeenAtUtc = DateTime.UtcNow;
        row.PendingAckCount = pending;
    }

    private async Task ApplyStockAsync(Guid licenseId, string storeId, CloudSyncEventDto evt, CancellationToken ct)
    {
        using JsonDocument doc = JsonDocument.Parse(string.IsNullOrWhiteSpace(evt.PayloadJson) ? "{}" : evt.PayloadJson);
        JsonElement root = doc.RootElement;
        string articleOid = GetString(root, "articleOid");
        if (string.IsNullOrWhiteSpace(articleOid))
        {
            return;
        }

        CloudStockBalance? row = await _db.CloudStockBalances
            .FirstOrDefaultAsync(
                s => s.LicenseId == licenseId && s.StoreId == storeId && s.ArticleOid == articleOid,
                ct)
            .ConfigureAwait(false);

        if (row == null)
        {
            row = new CloudStockBalance
            {
                LicenseId = licenseId,
                StoreId = storeId,
                ArticleOid = articleOid
            };
            _db.CloudStockBalances.Add(row);
        }

        row.Barcode = GetString(root, "barcode");
        row.Code = GetString(root, "code");
        row.Designation = GetString(root, "designation");
        row.Accounting = GetDecimal(root, "accounting");
        row.UpdatedAtUtc = ParseAt(root) ?? DateTime.UtcNow;
    }

    private async Task<bool> ApplySaleAsync(Guid licenseId, string storeId, CloudSyncEventDto evt, CancellationToken ct)
    {
        bool exists = await _db.CloudSaleEvents
            .AnyAsync(s => s.IdempotencyKey == evt.IdempotencyKey, ct)
            .ConfigureAwait(false);
        if (exists)
        {
            return false;
        }

        using JsonDocument doc = JsonDocument.Parse(string.IsNullOrWhiteSpace(evt.PayloadJson) ? "{}" : evt.PayloadJson);
        JsonElement root = doc.RootElement;

        _db.CloudSaleEvents.Add(new CloudSaleEvent
        {
            LicenseId = licenseId,
            StoreId = storeId,
            DocumentOid = GetString(root, "documentOid"),
            DocumentNumber = GetString(root, "documentNumber"),
            Total = GetDecimal(root, "total"),
            Day = GetString(root, "day") ?? DateTime.UtcNow.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture),
            PaymentToken = GetString(root, "paymentToken"),
            IdempotencyKey = evt.IdempotencyKey,
            AtUtc = ParseAt(root) ?? DateTime.UtcNow
        });
        return true;
    }

    private static string GetString(JsonElement root, string name)
    {
        if (root.TryGetProperty(name, out JsonElement el) && el.ValueKind == JsonValueKind.String)
        {
            return el.GetString() ?? string.Empty;
        }

        return string.Empty;
    }

    private static decimal GetDecimal(JsonElement root, string name)
    {
        if (!root.TryGetProperty(name, out JsonElement el))
        {
            return 0m;
        }

        if (el.ValueKind == JsonValueKind.Number && el.TryGetDecimal(out decimal d))
        {
            return d;
        }

        if (el.ValueKind == JsonValueKind.String
            && decimal.TryParse(el.GetString(), NumberStyles.Any, CultureInfo.InvariantCulture, out d))
        {
            return d;
        }

        return 0m;
    }

    private static DateTime? ParseAt(JsonElement root)
    {
        string at = GetString(root, "at");
        if (DateTime.TryParse(at, CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind, out DateTime dt))
        {
            return dt.Kind == DateTimeKind.Unspecified ? DateTime.SpecifyKind(dt, DateTimeKind.Utc) : dt.ToUniversalTime();
        }

        return null;
    }
}

public class CloudSyncBatchRequest
{
    public string LicenseKey { get; set; } = string.Empty;
    public string ComputerId { get; set; } = string.Empty;
    public string? MachineName { get; set; }
    public string StoreId { get; set; } = string.Empty;
    public List<CloudSyncEventDto>? Events { get; set; }
}

public class CloudSyncEventDto
{
    public string EventType { get; set; } = string.Empty;
    public string IdempotencyKey { get; set; } = string.Empty;
    public string PayloadJson { get; set; } = "{}";
}

public class CloudDashboardDto
{
    public Guid LicenseId { get; set; }
    public List<CloudStoreDto> Stores { get; set; } = new();
}

public class CloudStoreDto
{
    public string StoreId { get; set; } = string.Empty;
    public int SkuCount { get; set; }
    public decimal StockQty { get; set; }
    public int SalesTodayCount { get; set; }
    public decimal SalesTodayTotal { get; set; }
    public List<CloudTillDto> Tills { get; set; } = new();
}

public class CloudTillDto
{
    public string ComputerId { get; set; } = string.Empty;
    public string? MachineName { get; set; }
    public DateTime LastSeenAtUtc { get; set; }
}
