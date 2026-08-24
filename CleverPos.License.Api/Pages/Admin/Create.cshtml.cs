using CleverPos.License.Api.DTOs;
using CleverPos.License.Api.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CleverPos.License.Api.Pages.Admin;

public class CreateModel : PageModel
{
    private readonly LicenseService _licenses;

    public CreateModel(LicenseService licenses)
    {
        _licenses = licenses;
    }

    [BindProperty]
    public string? CompanyName { get; set; }

    [BindProperty]
    public string? Bin { get; set; }

    [BindProperty]
    public decimal? FirstMonthAmount { get; set; }

    [BindProperty]
    public bool MarkCurrentMonthPaid { get; set; } = true;

    public string? ErrorMessage { get; set; }

    public void OnGet()
    {
    }

    public async Task<IActionResult> OnPostAsync(CancellationToken cancellationToken)
    {
        try
        {
            LicenseListItem created = await _licenses.CreateAsync(new CreateLicenseRequest
            {
                CompanyName = CompanyName,
                Bin = Bin,
                MaxActivations = 1,
                FirstMonthAmount = FirstMonthAmount,
                MarkCurrentMonthPaid = MarkCurrentMonthPaid
            }, cancellationToken).ConfigureAwait(false);

            TempData["Ok"] = "Лицензия создана. Ключ: " + created.LicenseKey + " (скачайте licence.lic в карточке).";
            return RedirectToPage("/Admin/Details", new { id = created.Id });
        }
        catch (InvalidOperationException ex)
        {
            ErrorMessage = ex.Message;
            return Page();
        }
    }
}
