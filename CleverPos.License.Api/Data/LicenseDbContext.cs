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

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<LicenseRecord>(entity =>
        {
            entity.ToTable("licenses");
            entity.HasIndex(x => x.LicenseKey).IsUnique();
            entity.Property(x => x.LicenseKey).IsRequired();
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
    }
}
