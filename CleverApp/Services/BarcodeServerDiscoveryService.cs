using System.Net;
using System.Net.Sockets;
using System.Text;

namespace CleverApp.Services
{
    /// <summary>
    /// Поиск сервера: слушает UDP broadcast на порту 8888 (BARCODE_SERVER:ip:5000).
    /// После нахождения IP — HTTP для штрихкодов всегда на порту 5000 (как «Подключить по IP»).
    /// </summary>
    public class BarcodeServerDiscoveryService : IDisposable
    {
        public const int DiscoveryPort = 8888;
        public const string MessagePrefix = "BARCODE_SERVER:";

        private CancellationTokenSource? _cts;
        private Task? _receiveTask;
        private readonly object _lock = new();
        private IDisposable? _platformLock;

        public event EventHandler<(string Ip, int Port)>? ServerFound;
        public event EventHandler<string>? DiscoveryFailed;

        public void Start()
        {
            lock (_lock)
            {
                StopInternal();
                _cts = new CancellationTokenSource();
                _platformLock = PlatformNetworkLock.Acquire();
                _receiveTask = Task.Run(() => ReceiveLoop(_cts.Token));
            }
        }

        public void Stop()
        {
            lock (_lock)
            {
                StopInternal();
            }
        }

        private void StopInternal()
        {
            var cts = _cts;
            _cts = null;
            cts?.Cancel();
            cts?.Dispose();

            var receiveTask = _receiveTask;
            _receiveTask = null;

            var platformLock = _platformLock;
            _platformLock = null;

            _ = Task.Run(() =>
            {
                try
                {
                    if (receiveTask != null)
                        receiveTask.Wait(TimeSpan.FromSeconds(2));
                }
                catch (AggregateException) { }
                finally
                {
                    platformLock?.Dispose();
                }
            });
        }

        private static UdpClient? CreateListener()
        {
            try
            {
                var udp = new UdpClient();
                udp.Client.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReuseAddress, true);
                udp.Client.Bind(new IPEndPoint(IPAddress.Any, DiscoveryPort));
                udp.EnableBroadcast = true;
                return udp;
            }
            catch (SocketException)
            {
                try
                {
                    var udp = new UdpClient(DiscoveryPort);
                    udp.EnableBroadcast = true;
                    return udp;
                }
                catch (SocketException)
                {
                    return null;
                }
            }
        }

        private async Task ReceiveLoop(CancellationToken ct)
        {
            UdpClient? udp = null;
            try
            {
                udp = CreateListener();
                if (udp == null)
                {
                    MainThread.BeginInvokeOnMainThread(() =>
                        DiscoveryFailed?.Invoke(this, "Не удалось открыть UDP порт 8888 для поиска сервера."));
                    return;
                }

                while (!ct.IsCancellationRequested)
                {
                    try
                    {
                        var result = await udp.ReceiveAsync(ct).AsTask();
                        if (TryParseServerIp(result.Buffer, out var ip))
                        {
                            MainThread.BeginInvokeOnMainThread(() =>
                                ServerFound?.Invoke(this, (ip, DiscoveredServerStore.DefaultHttpPort)));
                        }
                    }
                    catch (OperationCanceledException)
                    {
                        break;
                    }
                    catch (SocketException)
                    {
                        try { await Task.Delay(300, ct); } catch (OperationCanceledException) { break; }
                    }
                    catch (ObjectDisposedException)
                    {
                        break;
                    }
                }
            }
            catch (OperationCanceledException) { }
            catch (Exception ex)
            {
                MainThread.BeginInvokeOnMainThread(() =>
                    DiscoveryFailed?.Invoke(this, ex.Message));
            }
            finally
            {
                try { udp?.Dispose(); } catch { }
            }
        }

        internal static bool TryParseServerIp(byte[] buffer, out string ip)
        {
            ip = string.Empty;
            var message = Encoding.UTF8.GetString(buffer).Trim();
            if (!message.StartsWith(MessagePrefix, StringComparison.Ordinal))
                return false;

            var payload = message.Substring(MessagePrefix.Length);
            var lastColon = payload.LastIndexOf(':');
            if (lastColon <= 0) return false;

            ip = payload.Substring(0, lastColon);
            return IPAddress.TryParse(ip, out _);
        }

        public void Dispose() => Stop();
    }
}
