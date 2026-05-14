using Microsoft.Extensions.Logging;
using CleverApp.Services;
using CommunityToolkit.Maui;
#if ANDROID
using CleverApp.Platforms.Android.Services;
#endif

namespace CleverApp
{
    public static class MauiProgram
    {
        public static MauiApp CreateMauiApp()
        {
            var builder = MauiApp.CreateBuilder();
            builder
                .UseMauiApp<App>()
                .ConfigureFonts(fonts =>
                {
                    fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                    fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
                }).UseMauiCommunityToolkit();

            builder.Services.AddSingleton<BarcodeServerDiscoveryService>();
#if ANDROID
            builder.Services.AddSingleton<IIdDocumentScanner, MlKitIdDocumentScanner>();
#else
            builder.Services.AddSingleton<IIdDocumentScanner, UnsupportedIdDocumentScanner>();
#endif

#if DEBUG
    		builder.Logging.AddDebug();
#endif

            return builder.Build();
        }
    }
}
