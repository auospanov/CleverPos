using System.Net;
using System.Net.Sockets;
using System.Text;

namespace CleverApp.Services
{
    /// <summary>
    /// Отправка штрихкода на LogicPOS через простой HTTP POST по TCP.
    /// Без HttpClient — на iOS он часто зависает при доступе к локальной сети.
    /// </summary>
    public class BarcodeSenderService
    {
        private const int ConnectTimeoutMs = 4000;
        private const int TotalTimeoutMs = 8000;

        public async Task<BarcodeSendResult> SendAsync(
            string ip,
            int port,
            string barcode,
            CancellationToken cancellationToken = default)
        {
            if (string.IsNullOrWhiteSpace(ip) || port <= 0 || string.IsNullOrWhiteSpace(barcode))
                return BarcodeSendResult.Fail("Некорректные параметры отправки.");

            if (!IPAddress.TryParse(ip, out var address))
                return BarcodeSendResult.Fail($"Некорректный IP: {ip}");

            using var timeoutCts = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken);
            timeoutCts.CancelAfter(TotalTimeoutMs);
            var ct = timeoutCts.Token;

            var body = barcode.Trim();
            var bodyBytes = Encoding.UTF8.GetBytes(body);

            try
            {
                using var tcp = new TcpClient();
                var connectTask = tcp.ConnectAsync(address, port, ct).AsTask();
                var connectTimeout = Task.Delay(ConnectTimeoutMs, ct);

                if (await Task.WhenAny(connectTask, connectTimeout) != connectTask)
                    return BarcodeSendResult.Fail(
                        $"ПК не отвечает на {ip}:{port}. Проверьте Wi‑Fi, IP и что LogicPOS запущен.");

                await connectTask;

                tcp.ReceiveTimeout = 4000;
                tcp.SendTimeout = 4000;

                await using var stream = tcp.GetStream();

                var header =
                    "POST /barcode HTTP/1.1\r\n" +
                    $"Host: {ip}:{port}\r\n" +
                    "Content-Type: text/plain; charset=utf-8\r\n" +
                    $"Content-Length: {bodyBytes.Length}\r\n" +
                    "Connection: close\r\n" +
                    "\r\n";

                var headerBytes = Encoding.ASCII.GetBytes(header);
                await stream.WriteAsync(headerBytes, ct);
                await stream.WriteAsync(bodyBytes, ct);
                await stream.FlushAsync(ct);

                var responseBuffer = new byte[512];
                var read = await stream.ReadAsync(responseBuffer.AsMemory(0, responseBuffer.Length), ct);
                if (read <= 0)
                    return BarcodeSendResult.Fail("Сервер не ответил.");

                var response = Encoding.ASCII.GetString(responseBuffer, 0, read);
                if (response.Contains(" 200 ", StringComparison.Ordinal) ||
                    response.Contains(" 200\r", StringComparison.Ordinal))
                {
                    return BarcodeSendResult.Ok();
                }

                var statusLine = response.Split('\n')[0].Trim();
                return BarcodeSendResult.Fail(string.IsNullOrEmpty(statusLine) ? "Ошибка сервера" : statusLine);
            }
            catch (OperationCanceledException)
            {
                return BarcodeSendResult.Fail(
                    "Таймаут. Проверьте Wi‑Fi, IP ПК и что LogicPOS запущен.");
            }
            catch (SocketException)
            {
                return BarcodeSendResult.Fail(
                    $"Нет связи с {ip}:{port}. Телефон и ПК должны быть в одной сети, " +
                    "LogicPOS запущен, в брандмауэре Windows открыт TCP порт 5000.");
            }
            catch (Exception ex)
            {
                return BarcodeSendResult.Fail(ex.Message);
            }
        }
    }

    public readonly struct BarcodeSendResult
    {
        public bool Success { get; }
        public string? ErrorMessage { get; }

        private BarcodeSendResult(bool success, string? errorMessage)
        {
            Success = success;
            ErrorMessage = errorMessage;
        }

        public static BarcodeSendResult Ok() => new(true, null);

        public static BarcodeSendResult Fail(string message) => new(false, message);
    }
}
