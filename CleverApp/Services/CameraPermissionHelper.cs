namespace CleverApp.Services
{
    public static class CameraPermissionHelper
    {
        public static async Task<bool> EnsureGrantedAsync(Page page)
        {
            try
            {
                var status = await Permissions.CheckStatusAsync<Permissions.Camera>();
                if (status == PermissionStatus.Granted)
                    return true;

                if (status == PermissionStatus.Denied)
                {
                    var openSettings = await page.DisplayAlert(
                        "Камера",
                        "Доступ к камере запрещён. Разрешите камеру в настройках устройства.",
                        "Настройки",
                        "Отмена");

                    if (openSettings)
                        AppInfo.ShowSettingsUI();

                    return false;
                }

                status = await Permissions.RequestAsync<Permissions.Camera>();
                if (status == PermissionStatus.Granted)
                    return true;

                await page.DisplayAlert(
                    "Камера",
                    "Без доступа к камере сканирование недоступно.",
                    "OK");

                return false;
            }
            catch (Exception ex)
            {
                await page.DisplayAlert("Камера", ex.Message, "OK");
                return false;
            }
        }
    }
}
