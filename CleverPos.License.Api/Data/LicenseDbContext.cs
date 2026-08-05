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
    }
}
