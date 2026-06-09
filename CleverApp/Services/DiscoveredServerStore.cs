namespace CleverApp.Services
{
    public static class DiscoveredServerStore
    {
        public const int DefaultHttpPort = 5000;

        public static string Ip { get; set; } = string.Empty;
        public static int Port { get; set; }

        public static bool HasServer =>
            !string.IsNullOrWhiteSpace(Ip) && Port > 0 && Port <= 65535;

        public static void Set(string ip, int port)
        {
            Ip = ip ?? string.Empty;
            Port = port;
        }
    }
}
