using Microsoft.Extensions.Logging;
using CleverApp.Configuration;
using CleverApp.Services;
using CleverApp.Services.VisitorJournal;
using CommunityToolkit.Maui;
using ZXing.Net.Maui.Controls;
#if ANDROID
using CleverApp.Platforms.Android.Services;
#endif

namespace CleverApp
{
    public static class MauiProgram
    {
        public static MauiApp CreateMauiApp()
        {
            AppConfig.Initialize();

            var builder = MauiApp.CreateBuilder();
            builder
                .UseMauiApp<App>()
                .ConfigureFonts(fonts =>
                {
                    fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                    fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
                })
                .UseMauiCommunityToolkit()
                .UseBarcodeReader();

            builder.Services.AddSingleton<BarcodeServerDiscoveryService>();
            builder.Services.AddSingleton<VisitorJournalService>();
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
