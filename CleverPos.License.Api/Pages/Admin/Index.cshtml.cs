using CleverPos.License.Api.DTOs;
using CleverPos.License.Api.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CleverPos.License.Api.Pages.Admin;

public class IndexModel : PageModel
{
    private readonly LicenseService _licenses;

    public IndexModel(LicenseService licenses)
    {
        _licenses = licenses;
    }

    public IReadOnlyList<LicenseListItem> Licenses { get; private set; } = Array.Empty<LicenseListItem>();

    public async Task OnGetAsync(CancellationToken cancellationToken)
    {
        Licenses = await _licenses.ListAsync(cancellationToken).ConfigureAwait(false);
    }

    public async Task<IActionResult> OnPostClearComputerAsync(Guid id, CancellationToken cancellationToken)
    {
        bool ok = await _licenses.ClearComputerAsync(id, cancellationToken).ConfigureAwait(false);
        TempData[ok ? "Ok" : "Error"] = ok
            ? "Идентификатор компьютера очищен. Следующий запрос кассы привяжет новый ПК."
            : "Лицензия не найдена.";
        return RedirectToPage();
    }

    public async Task<IActionResult> OnPostPayCurrentMonthAsync(Guid id, CancellationToken cancellationToken)
    {
        LicenseListItem? updated = await _licenses.MarkPaidAsync(id, new MarkPaymentRequest(), cancellationToken).ConfigureAwait(false);
        TempData[updated == null ? "Error" : "Ok"] = updated == null
            ? "Лицензия не найдена."
            : "Оплата за текущий месяц отмечена.";
        return RedirectToPage();
    }

    public async Task<IActionResult> OnPostToggleAsync(Guid id, bool isActive, CancellationToken cancellationToken)
    {
        LicenseListItem? updated = await _licenses.SetActiveAsync(id, isActive, cancellationToken).ConfigureAwait(false);
        TempData[updated == null ? "Error" : "Ok"] = updated == null
            ? "Лицензия не найдена."
            : (isActive ? "Лицензия включена." : "Лицензия отключена.");
        return RedirectToPage();
    }
}
