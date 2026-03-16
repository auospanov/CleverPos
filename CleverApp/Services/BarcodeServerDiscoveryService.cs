using System.Net;
using System.Net.Sockets;
using System.Text;

namespace CleverApp.Services
{
    /// <summary>
    /// Слушает UDP broadcast на порту 8888 и находит адрес сервера LogicPOS по сообщению BARCODE_SERVER:ip:port
    /// </summary>
    public class BarcodeServerDiscoveryService : IDisposable
    {
        public const int DiscoveryPort = 8888;
        public const string MessagePrefix = "BARCODE_SERVER:";

        private CancellationTokenSource? _cts;
        private Task? _receiveTask;
        private readonly object _lock = new();

        /// <summary>Найден сервер (IP, HTTP-порт)</summary>
        public event EventHandler<(string Ip, int Port)>? ServerFound;

        public bool IsListening => _receiveTask != null && !_receiveTask.IsCompleted;

        public void Start()
        {
            lock (_lock)
            {
                if (_receiveTask != null) return;
                _cts = new CancellationTokenSource();
                _receiveTask = Task.Run(() => ReceiveLoop(_cts.Token));
            }
        }

        public void Stop()
        {
            Task? toWait = null;
            lock (_lock)
            {
                _cts?.Cancel();
                toWait = _receiveTask;
                _cts = null;
                _receiveTask = null;
            }
            try
            {
                if (toWait != null)
                    toWait.Wait(TimeSpan.FromSeconds(3));
            }
            catch (AggregateException) { }
        }

        private async Task ReceiveLoop(CancellationToken ct)
        {
            UdpClient? udp = null;
            try
            {
                try
                {
                    udp = new UdpClient(DiscoveryPort);
                }
                catch (SocketException)
                {
                    return;
                }
                udp.EnableBroadcast = true;

                while (!ct.IsCancellationRequested)
                {
                    try
                    {
                        var result = await udp.ReceiveAsync(ct);
                        var message = Encoding.UTF8.GetString(result.Buffer);
                        if (message.StartsWith(MessagePrefix, StringComparison.Ordinal))
                        {
                            var payload = message.Substring(MessagePrefix.Length);
                            var parts = payload.Split(':');
                            if (parts.Length >= 2 &&
                                IPAddress.TryParse(parts[0], out _) &&
                                int.TryParse(parts[1], out int port) &&
                                port > 0 && port <= 65535)
                            {
                                var ip = parts[0];
                                MainThread.BeginInvokeOnMainThread(() =>
                                    ServerFound?.Invoke(this, (ip, port)));
                            }
                        }
                    }
                    catch (OperationCanceledException exc)
                    {
                        break;
                    }
                    catch (SocketException  exc)
                    {
                        try { await Task.Delay(500, ct); } catch (OperationCanceledException exc2) { break; }
                    }
                    catch (ObjectDisposedException exc3)
                    {
                        break;
                    }
                }
            }
            catch (OperationCanceledException)
            {
            }
            catch (Exception)
            {
            }
            finally
            {
                try { udp?.Dispose(); } catch { }
            }
        }

        public void Dispose() => Stop();
    }
}
