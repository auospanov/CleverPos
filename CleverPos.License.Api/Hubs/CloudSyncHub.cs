using Microsoft.AspNetCore.SignalR;

namespace CleverPos.License.Api.Hubs;

public class CloudSyncHub : Hub
{
    public static string LicenseGroup(Guid licenseId) => "license:" + licenseId.ToString("N");

    public Task SubscribeLicense(string licenseId)
    {
        if (!Guid.TryParse(licenseId, out Guid id))
        {
            return Task.CompletedTask;
        }

        return Groups.AddToGroupAsync(Context.ConnectionId, LicenseGroup(id));
    }
}
