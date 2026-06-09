#if ANDROID
using Android.Content;
using Android.Net.Wifi;

namespace CleverApp.Services
{
    internal sealed class AndroidMulticastLock : IDisposable
    {
        private readonly WifiManager.MulticastLock? _lock;

        private AndroidMulticastLock(WifiManager.MulticastLock multicastLock)
        {
            _lock = multicastLock;
        }

        public static AndroidMulticastLock? Acquire()
        {
            try
            {
                var context = global::Android.App.Application.Context;
                var wifi = (WifiManager?)context.GetSystemService(Context.WifiService);
                var multicastLock = wifi?.CreateMulticastLock("CleverApp.Discovery");
                if (multicastLock == null) return null;

                multicastLock.SetReferenceCounted(false);
                multicastLock.Acquire();
                return new AndroidMulticastLock(multicastLock);
            }
            catch
            {
                return null;
            }
        }

        public void Dispose()
        {
            try
            {
                if (_lock?.IsHeld == true)
                    _lock.Release();
            }
            catch { }
        }
    }
}
#endif
