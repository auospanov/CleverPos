namespace CleverApp.Services
{
    /// <summary>На Android удерживает MulticastLock для приёма UDP broadcast по Wi‑Fi.</summary>
    internal static class PlatformNetworkLock
    {
        public static IDisposable? Acquire()
        {
#if ANDROID
            return AndroidMulticastLock.Acquire();
#else
            return null;
#endif
        }
    }
}
