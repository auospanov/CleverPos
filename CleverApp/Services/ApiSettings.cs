namespace CleverApp.Services
{
    public static class ApiSettings
    {
        public const string BaseUrl = "https://api.kmlife.kz";
        public const string BarcodePath = "/barcode";

        public static string BarcodeUrl => $"{BaseUrl.TrimEnd('/')}{BarcodePath}";
    }
}
