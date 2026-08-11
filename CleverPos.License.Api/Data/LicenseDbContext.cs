using CleverPos.License.Api.Models;
using Microsoft.EntityFrameworkCore;

namespace CleverPos.License.Api.Data;

public class LicenseDbContext : DbContext
{
    public LicenseDbContext(DbContextOptions<LicenseDbContext> options) : base(options)
    {
    }

    public DbSet<LicenseRecord> Licenses => Set<LicenseRecord>();
    public DbSet<LicenseActivation> Activations => Set<LicenseActivation>();
    public DbSet<LicensePayment> Payments => Set<LicensePayment>();
    public DbSet<LicenseAccessLog> AccessLogs => Set<LicenseAccessLog>();
    public DbSet<OwnerAccount> OwnerAccounts => Set<OwnerAccount>();
    public DbSet<OwnerLicenseLink> OwnerLicenseLinks => Set<OwnerLicenseLink>();
    public DbSet<CloudStockBalance> CloudStockBalances => Set<CloudStockBalance>();
    public DbSet<CloudSaleEvent> CloudSaleEvents => Set<CloudSaleEvent>();
    public DbSet<CloudTillPresence> CloudTillPresences => Set<CloudTillPresence>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<LicenseRecord>(entity =>
        {
            entity.ToTable("licenses");
            entity.HasIndex(x => x.LicenseKey).IsUnique();
            entity.Property(x => x.LicenseKey).IsRequired();
            entity.Property(x => x.Bin).HasMaxLength(12);
        });

        modelBuilder.Entity<LicenseActivation>(entity =>
        {
            entity.ToTable("license_activations");
            entity.HasIndex(x => new { x.LicenseId, x.ComputerId }).IsUnique();
            entity.HasOne(x => x.License)
                .WithMany(x => x.Activations)
                .HasForeignKey(x => x.LicenseId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<LicensePayment>(entity =>
        {
            entity.ToTable("license_payments");
            entity.HasIndex(x => new { x.LicenseId, x.PeriodYear, x.PeriodMonth }).IsUnique();
            entity.Property(x => x.Amount).HasPrecision(18, 2);
            entity.HasOne(x => x.License)
                .WithMany(x => x.Payments)
                .HasForeignKey(x => x.LicenseId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<LicenseAccessLog>(entity =>
        {
            entity.ToTable("license_access_logs");
            entity.HasIndex(x => x.CreatedAtUtc);
            entity.HasIndex(x => x.LicenseKey);
            entity.HasIndex(x => x.ComputerId);
            entity.HasOne(x => x.License)
                .WithMany()
                .HasForeignKey(x => x.LicenseId)
                .OnDelete(DeleteBehavior.SetNull);
        });

        modelBuilder.Entity<OwnerAccount>(entity =>
        {
            entity.ToTable("owner_accounts");
            entity.HasIndex(x => new { x.Provider, x.ProviderKey }).IsUnique();
            entity.HasIndex(x => x.Email);
            entity.Property(x => x.Provider).IsRequired();
            entity.Property(x => x.ProviderKey).IsRequired();
        });

        modelBuilder.Entity<OwnerLicenseLink>(entity =>
        {
            entity.ToTable("owner_license_links");
            entity.HasIndex(x => new { x.OwnerId, x.LicenseId }).IsUnique();
            entity.HasOne(x => x.Owner)
                .WithMany(x => x.LicenseLinks)
                .HasForeignKey(x => x.OwnerId)
                .OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(x => x.License)
                .WithMany(x => x.OwnerLinks)
                .HasForeignKey(x => x.LicenseId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<CloudStockBalance>(entity =>
        {
            entity.ToTable("cloud_stock_balances");
            entity.HasIndex(x => new { x.LicenseId, x.StoreId, x.ArticleOid }).IsUnique();
            entity.Property(x => x.Accounting).HasPrecision(18, 4);
            entity.HasOne(x => x.License)
                .WithMany()
                .HasForeignKey(x => x.LicenseId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<CloudSaleEvent>(entity =>
        {
            entity.ToTable("cloud_sale_events");
            entity.HasIndex(x => x.IdempotencyKey).IsUnique();
            entity.HasIndex(x => new { x.LicenseId, x.StoreId, x.Day });
            entity.Property(x => x.Total).HasPrecision(18, 2);
            entity.HasOne(x => x.License)
                .WithMany()
                .HasForeignKey(x => x.LicenseId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<CloudTillPresence>(entity =>
        {
            entity.ToTable("cloud_till_presences");
            entity.HasIndex(x => new { x.LicenseId, x.StoreId, x.ComputerId }).IsUnique();
            entity.HasOne(x => x.License)
                .WithMany()
                .HasForeignKey(x => x.LicenseId)
                .OnDelete(DeleteBehavior.Cascade);
        });
    }
}