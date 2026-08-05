using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace CleverPos.License.Api.Data;

public class LicenseDbContextFactory : IDesignTimeDbContextFactory<LicenseDbContext>
{
    public LicenseDbContext CreateDbContext(string[] args)
    {
        string connectionString =
            Environment.GetEnvironmentVariable("ConnectionStrings__DefaultConnection")
            ?? "Server=92.38.49.47;user id=root;password=Asd+12345678;database=cleverpos;charset=utf8;default command timeout=1200;SslMode=none;AllowPublicKeyRetrieval=True";

        var options = new DbContextOptionsBuilder<LicenseDbContext>()
            .UseMySql(connectionString, new MySqlServerVersion(new Version(8, 0, 36)))
            .Options;

        return new LicenseDbContext(options);
    }
}
