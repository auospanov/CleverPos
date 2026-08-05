using CleverPos.License.Api.DTOs;
using CleverPos.License.Api.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CleverPos.License.Api.Pages.Admin;

public class DetailsModel : PageModel
{
    private readonly LicenseService _licenses;

    public DetailsModel(LicenseService licenses)
    {
        _licenses = licenses;
    }

    public LicenseListItem? License { get; private set; }

    [BindProperty]
    public int Year { get; set; }

    [BindProperty]
    public int Month { get; set; }

    [BindProperty]
    public decimal? Amount { get; set; }

    [BindProperty]
    public string? Comment { get; set; }

    public async Task<IActionResult> OnGetAsync(Guid id, CancellationToken cancellationToken)
    {
        License = await _licenses.GetAsync(id, cancellationToken).ConfigureAwait(false);
        if (License == null)
        {
            return RedirectToPage("/Admin/Index");
        }

        (int year, int month) = LicenseService.CurrentPeriodUtc();
        Year = year;
        Month = month;
        return Page();
    }

    public async Task<IActionResult> OnPostClearComputerAsync(Guid id, CancellationToken cancellationToken)
    {
        await _licenses.ClearComputerAsync(id, cancellationToken).ConfigureAwait(false);
        TempData["Ok"] = "Идентификатор компьютера очищен.";
        return RedirectToPage(new { id });
    }

    public async Task<IActionResult> OnPostAddPaymentAsync(Guid id, CancellationToken cancellationToken)
    {
        try
        {
            await _licenses.MarkPaidAsync(id, new MarkPaymentRequest
            {
                Year = Year,
                Month = Month,
                Amount = Amount,
                Comment = Comment
            }, cancellationToken).ConfigureAwait(false);
            TempData["Ok"] = $"Оплата за {Month:00}/{Year} сохранена.";
        }
        catch (InvalidOperationException ex)
        {
            TempData["Error"] = ex.Message;
        }

        return RedirectToPage(new { id });
    }

    public async Task<IActionResult> OnPostToggleAsync(Guid id, bool isActive, CancellationToken cancellationToken)
    {
        await _licenses.SetActiveAsync(id, isActive, cancellationToken).ConfigureAwait(false);
        TempData["Ok"] = isActive ? "Лицензия включена." : "Лицензия отключена.";
        return RedirectToPage(new { id });
    }
}
