using System.Text;
using CleverPos.License.Api.Data;
using CleverPos.License.Api.Hubs;
using CleverPos.License.Api.Options;
using CleverPos.License.Api.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

string connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
    ?? throw new InvalidOperationException("ConnectionStrings:DefaultConnection is not configured.");

builder.Services.Configure<LicenseSigningOptions>(builder.Configuration.GetSection(LicenseSigningOptions.SectionName));
builder.Services.Configure<AppUpdateOptions>(builder.Configuration.GetSection(AppUpdateOptions.SectionName));
builder.Services.Configure<OwnerAuthOptions>(builder.Configuration.GetSection(OwnerAuthOptions.SectionName));
builder.Services.AddDbContext<LicenseDbContext>(options =>
    options.UseMySql(connectionString, new MySqlServerVersion(new Version(8, 0, 36))));

builder.Services.AddScoped<LicenseService>();
builder.Services.AddScoped<OwnerAuthService>();
builder.Services.AddScoped<CloudSyncService>();
builder.Services.AddSignalR();
builder.Services.AddControllers();
builder.Services.AddRazorPages(options =>
{
    options.Conventions.AuthorizeFolder("/Admin");
    options.Conventions.AllowAnonymousToPage("/Admin/Login");
    options.Conventions.AuthorizeFolder("/Cabinet", "OwnerCabinet");
    options.Conventions.AllowAnonymousToPage("/Cabinet/Login");
});

OwnerAuthOptions ownerAuth = builder.Configuration.GetSection(OwnerAuthOptions.SectionName).Get<OwnerAuthOptions>()
    ?? new OwnerAuthOptions();
string jwtKey = string.IsNullOrWhiteSpace(ownerAuth.JwtSigningKey) || ownerAuth.JwtSigningKey.Length < 32
    ? "CHANGE-ME-OWNER-JWT-KEY-32CHARS-MIN-X"
    : ownerAuth.JwtSigningKey;

builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath = "/admin/login";
        options.LogoutPath = "/admin/logout";
        options.Cookie.Name = "cleverpos_admin";
        options.ExpireTimeSpan = TimeSpan.FromHours(12);
        options.SlidingExpiration = true;
    })
    .AddCookie(OwnerAuthService.OwnerCookieScheme, options =>
    {
        options.LoginPath = "/cabinet/login";
        options.LogoutPath = "/cabinet/logout";
        options.Cookie.Name = "cleverpos_owner";
        options.ExpireTimeSpan = TimeSpan.FromDays(7);
        options.SlidingExpiration = true;
        options.Cookie.SameSite = SameSiteMode.Lax;
    })
    .AddJwtBearer(OwnerAuthService.OwnerJwtScheme, options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = ownerAuth.JwtIssuer,
            ValidAudience = ownerAuth.JwtAudience,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey))
        };
    });
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("OwnerCabinet", policy =>
    {
        policy.AddAuthenticationSchemes(OwnerAuthService.OwnerCookieScheme);
        policy.RequireAuthenticatedUser();
        policy.RequireClaim(System.Security.Claims.ClaimTypes.Role, "Owner");
    });
});
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
app.MapHub<CloudSyncHub>("/hubs/cloud");
app.MapHealthChecks("/health");
app.MapGet("/", () => Results.Redirect("/admin"));
app.MapPost("/admin/logout", async (HttpContext http) =>
{
    await http.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
    return Results.Redirect("/admin/login");
}).RequireAuthorization();
app.MapPost("/cabinet/logout", async (HttpContext http) =>
{
    await http.SignOutAsync(OwnerAuthService.OwnerCookieScheme);
    return Results.Redirect("/cabinet/login");
});

app.Run();
