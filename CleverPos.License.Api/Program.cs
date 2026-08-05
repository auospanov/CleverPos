using CleverPos.License.Api.Data;
using CleverPos.License.Api.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

string connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
    ?? throw new InvalidOperationException("ConnectionStrings:DefaultConnection is not configured.");

builder.Services.AddDbContext<LicenseDbContext>(options =>
    options.UseMySql(connectionString, new MySqlServerVersion(new Version(8, 0, 36))));

builder.Services.AddScoped<LicenseService>();
builder.Services.AddControllers();
builder.Services.AddRazorPages(options =>
{
    options.Conventions.AuthorizeFolder("/Admin");
    options.Conventions.AllowAnonymousToPage("/Admin/Login");
});
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath = "/admin/login";
        options.LogoutPath = "/admin/logout";
        options.Cookie.Name = "cleverpos_admin";
        options.ExpireTimeSpan = TimeSpan.FromHours(12);
        options.SlidingExpiration = true;
    });
builder.Services.AddAuthorization();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddHealthChecks();

WebApplication app = builder.Build();

using (IServiceScope scope = app.Services.CreateScope())
{
    LicenseDbContext db = scope.ServiceProvider.GetRequiredService<LicenseDbContext>();
    db.Database.Migrate();
}

app.UseStaticFiles();
app.UseSwagger();
app.UseSwaggerUI();
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
app.MapRazorPages();
app.MapHealthChecks("/health");
app.MapGet("/", () => Results.Redirect("/admin"));
app.MapPost("/admin/logout", async (HttpContext http) =>
{
    await http.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
    return Results.Redirect("/admin/login");
}).RequireAuthorization();

app.Run();
