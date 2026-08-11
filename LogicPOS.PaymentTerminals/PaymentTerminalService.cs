using DevExpress.Xpo;
using LogicPOS.Domain.Entities;
using LogicPOS.PaymentTerminals.Halyk;
using LogicPOS.PaymentTerminals.Jusan;
using LogicPOS.PaymentTerminals.Kaspi;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace LogicPOS.PaymentTerminals
{
    public static class PaymentTerminalService
    {
        public static async Task<PaymentTerminalChargeResult> ChargeAsync(
            Session session,
            sys_configurationpaymentterminal terminal,
            decimal amount,
            Action<string> log = null,
            CancellationToken cancellationToken = default)
        {
            if (terminal == null || terminal.Disabled)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = "Payment terminal is not configured"
                };
            }

            if (string.IsNullOrWhiteSpace(terminal.Host))
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = "Terminal host (IP) is empty"
                };
            }

            string brand = (terminal.Brand ?? string.Empty).Trim().ToUpperInvariant();
            if (brand == "JUSAN" || brand == "JYSAN")
            {
                return await ChargeJusanAsync(terminal, amount, log, cancellationToken).ConfigureAwait(false);
            }

            if (brand == "HALYK")
            {
                return await ChargeHalykAsync(terminal, amount, log, cancellationToken).ConfigureAwait(false);
            }

            if (brand != "KASPI")
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = $"Terminal brand '{terminal.Brand}' is not supported yet"
                };
            }

            try
            {
                KaspiSmartPosClient client = CreateClient(terminal);
                log?.Invoke(string.Format("Kaspi терминал: {0}", client.BaseUrl));

                string accessToken = await EnsureAccessTokenAsync(session, terminal, client, log, cancellationToken).ConfigureAwait(false);
                if (string.IsNullOrWhiteSpace(accessToken))
                {
                    return new PaymentTerminalChargeResult
                    {
                        Status = PaymentTerminalChargeStatus.Failed,
                        Message = "Не удалось получить токен Kaspi. На терминале подтвердите доступ кассы (Панель администратора → Защита интеграции / Настроить доступ)."
                    };
                }

                int amountTenge = KaspiSmartPosClient.ConvertAmountToTenge(amount);
                log?.Invoke($"Payment {amount} -> amount={amountTenge} ₸");

                KaspiPaymentStatusResult started = await client.StartPaymentAsync(accessToken, amountTenge, ownCheque: true, cancellationToken).ConfigureAwait(false);
                if (!started.Success || string.IsNullOrWhiteSpace(started.ProcessId))
                {
                    return new PaymentTerminalChargeResult
                    {
                        Status = PaymentTerminalChargeStatus.Failed,
                        Message = started.Message ?? "Payment start failed"
                    };
                }

                log?.Invoke($"processId={started.ProcessId}, status={started.Status}");

                KaspiPaymentStatusResult finalStatus = await client.WaitForPaymentAsync(
                    accessToken,
                    started.ProcessId,
                    pollIntervalMs: 1000,
                    timeoutSeconds: 120,
                    log,
                    cancellationToken).ConfigureAwait(false);

                if (finalStatus.Success && string.Equals(finalStatus.Status, "success", StringComparison.OrdinalIgnoreCase))
                {
                    return new PaymentTerminalChargeResult
                    {
                        Status = PaymentTerminalChargeStatus.Success,
                        Message = "Payment successful",
                        ProcessId = finalStatus.ProcessId,
                        TransactionId = finalStatus.TransactionId,
                        Rrn = finalStatus.Rrn,
                        AuthorizationCode = finalStatus.AuthorizationCode,
                        PaymentMethodChannel = finalStatus.Method
                    };
                }

                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = finalStatus.Message ?? $"Payment {finalStatus.Status}",
                    ProcessId = finalStatus.ProcessId
                };
            }
            catch (OperationCanceledException)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Cancelled,
                    Message = "Cancelled"
                };
            }
            catch (Exception ex)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = ex.Message,
                    Exception = ex
                };
            }
        }

        public static async Task<PaymentTerminalTestResult> TestConnectionAsync(
            Session session,
            sys_configurationpaymentterminal terminal,
            Action<string> log = null,
            CancellationToken cancellationToken = default)
        {
            string brand = (terminal.Brand ?? "KASPI").Trim().ToUpperInvariant();
            if (brand == "JUSAN" || brand == "JYSAN")
            {
                JusanPosClient jusan = new JusanPosClient(terminal.Host, terminal.Port);
                log?.Invoke("Connect " + jusan.BaseUrl);
                log?.Invoke("Jusan/Jysan: режим интеграции кассы (порт обычно 8080).");
                PaymentTerminalTestResult jusanResult = await jusan.ProbeAsync(cancellationToken).ConfigureAwait(false);
                log?.Invoke(jusanResult.Message);
                return jusanResult;
            }

            if (brand == "HALYK")
            {
                HalykPosClient halyk = new HalykPosClient(terminal.Host, terminal.Port);
                log?.Invoke("Connect " + halyk.BaseUrl);
                log?.Invoke("На Halyk должен быть включён «Режим кассы».");
                PaymentTerminalTestResult halykResult = await halyk.ProbeAsync(cancellationToken).ConfigureAwait(false);
                log?.Invoke(halykResult.Message);
                return halykResult;
            }

            KaspiSmartPosClient client = CreateClient(terminal);
            log?.Invoke($"Connect {client.BaseUrl}");
            log?.Invoke("На экране терминала подтвердите доступ кассы (если появится запрос).");

            KaspiRegisterResult registerResult = await RegisterWithHttpsFallbackAsync(session, terminal, client, log, cancellationToken).ConfigureAwait(false);
            if (registerResult.Success)
            {
                log?.Invoke("Registration OK");
            }
            else
            {
                log?.Invoke(registerResult.Message ?? "Registration failed");
            }

            return new PaymentTerminalTestResult
            {
                Success = registerResult.Success,
                Message = registerResult.Message
            };
        }

        /// <summary>
        /// Refund on payment terminal. Kaspi needs transactionId + method (Card/Qr);
        /// Halyk/Jusan need tagRRN (use RRN / transaction id from original payment).
        /// </summary>
        public static async Task<PaymentTerminalChargeResult> RefundAsync(
            Session session,
            sys_configurationpaymentterminal terminal,
            decimal amount,
            string transactionId,
            string paymentMethodChannel = null,
            Action<string> log = null,
            CancellationToken cancellationToken = default)
        {
            if (terminal == null || terminal.Disabled)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = "Payment terminal is not configured"
                };
            }

            if (string.IsNullOrWhiteSpace(terminal.Host))
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = "Terminal host (IP) is empty"
                };
            }

            if (string.IsNullOrWhiteSpace(transactionId))
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = "Не задан ID операции (transactionId / tagRRN) для возврата"
                };
            }

            string brand = (terminal.Brand ?? string.Empty).Trim().ToUpperInvariant();
            if (brand == "JUSAN" || brand == "JYSAN")
            {
                return await RefundJusanAsync(terminal, amount, transactionId, log, cancellationToken).ConfigureAwait(false);
            }

            if (brand == "HALYK")
            {
                return await RefundHalykAsync(terminal, amount, transactionId, log, cancellationToken).ConfigureAwait(false);
            }

            if (brand != "KASPI")
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = $"Terminal brand '{terminal.Brand}' is not supported for refund"
                };
            }

            return await RefundKaspiAsync(session, terminal, amount, transactionId, paymentMethodChannel, log, cancellationToken).ConfigureAwait(false);
        }

        private static async Task<PaymentTerminalChargeResult> RefundKaspiAsync(
            Session session,
            sys_configurationpaymentterminal terminal,
            decimal amount,
            string transactionId,
            string paymentMethodChannel,
            Action<string> log,
            CancellationToken cancellationToken)
        {
            try
            {
                KaspiSmartPosClient client = CreateClient(terminal);
                log?.Invoke(string.Format("Kaspi возврат: {0}", client.BaseUrl));

                string accessToken = await EnsureAccessTokenAsync(session, terminal, client, log, cancellationToken).ConfigureAwait(false);
                if (string.IsNullOrWhiteSpace(accessToken))
                {
                    return new PaymentTerminalChargeResult
                    {
                        Status = PaymentTerminalChargeStatus.Failed,
                        Message = "Не удалось получить токен Kaspi для возврата."
                    };
                }

                int amountTenge = KaspiSmartPosClient.ConvertAmountToTenge(amount);
                string method = KaspiSmartPosClient.NormalizeRefundMethod(paymentMethodChannel);
                log?.Invoke(string.Format("Refund {0} ₸, method={1}, transactionId={2}", amountTenge, method, transactionId));

                KaspiPaymentStatusResult started = await client.StartRefundAsync(accessToken, amountTenge, transactionId, method, cancellationToken).ConfigureAwait(false);
                if (!started.Success || string.IsNullOrWhiteSpace(started.ProcessId))
                {
                    return new PaymentTerminalChargeResult
                    {
                        Status = PaymentTerminalChargeStatus.Failed,
                        Message = started.Message ?? "Refund start failed"
                    };
                }

                log?.Invoke(string.Format("processId={0}, status={1}", started.ProcessId, started.Status));

                KaspiPaymentStatusResult finalStatus = await client.WaitForPaymentAsync(
                    accessToken,
                    started.ProcessId,
                    pollIntervalMs: 1000,
                    timeoutSeconds: 120,
                    log,
                    cancellationToken).ConfigureAwait(false);

                if (finalStatus.Success && string.Equals(finalStatus.Status, "success", StringComparison.OrdinalIgnoreCase))
                {
                    return new PaymentTerminalChargeResult
                    {
                        Status = PaymentTerminalChargeStatus.Success,
                        Message = "Refund successful",
                        ProcessId = finalStatus.ProcessId,
                        TransactionId = finalStatus.TransactionId ?? transactionId,
                        Rrn = finalStatus.Rrn,
                        AuthorizationCode = finalStatus.AuthorizationCode,
                        PaymentMethodChannel = method
                    };
                }

                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = finalStatus.Message ?? ("Refund " + finalStatus.Status),
                    ProcessId = finalStatus.ProcessId
                };
            }
            catch (OperationCanceledException)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Cancelled,
                    Message = "Cancelled"
                };
            }
            catch (Exception ex)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = ex.Message,
                    Exception = ex
                };
            }
        }

        private static async Task<PaymentTerminalChargeResult> RefundJusanAsync(
            sys_configurationpaymentterminal terminal,
            decimal amount,
            string tagRrn,
            Action<string> log,
            CancellationToken cancellationToken)
        {
            try
            {
                JusanPosClient client = new JusanPosClient(terminal.Host, terminal.Port);
                int amountTenge = KaspiSmartPosClient.ConvertAmountToTenge(amount);
                log?.Invoke("Jusan refund " + client.BaseUrl);
                log?.Invoke(string.Format("Refund {0} ₸, tagRRN={1}", amountTenge, tagRrn));
                return await client.RefundAsync(amountTenge, tagRrn, cancellationToken).ConfigureAwait(false);
            }
            catch (OperationCanceledException)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Cancelled,
                    Message = "Cancelled"
                };
            }
            catch (Exception ex)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = ex.Message,
                    Exception = ex
                };
            }
        }

        private static async Task<PaymentTerminalChargeResult> RefundHalykAsync(
            sys_configurationpaymentterminal terminal,
            decimal amount,
            string tagRrn,
            Action<string> log,
            CancellationToken cancellationToken)
        {
            try
            {
                HalykPosClient client = new HalykPosClient(terminal.Host, terminal.Port);
                int amountTenge = KaspiSmartPosClient.ConvertAmountToTenge(amount);
                log?.Invoke("Halyk refund " + client.BaseUrl);
                log?.Invoke(string.Format("Refund {0} ₸, tagRRN={1}", amountTenge, tagRrn));
                return await client.RefundAsync(amountTenge, tagRrn, cancellationToken).ConfigureAwait(false);
            }
            catch (OperationCanceledException)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Cancelled,
                    Message = "Cancelled"
                };
            }
            catch (Exception ex)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = ex.Message,
                    Exception = ex
                };
            }
        }

        private static async Task<PaymentTerminalChargeResult> ChargeJusanAsync(
            sys_configurationpaymentterminal terminal,
            decimal amount,
            Action<string> log,
            CancellationToken cancellationToken)
        {
            try
            {
                JusanPosClient client = new JusanPosClient(terminal.Host, terminal.Port);
                int amountTenge = KaspiSmartPosClient.ConvertAmountToTenge(amount);
                log?.Invoke("Jusan " + client.BaseUrl);
                log?.Invoke(string.Format("Payment {0} -> amount={1} ₸", amount, amountTenge));
                return await client.PurchaseAsync(amountTenge, cancellationToken).ConfigureAwait(false);
            }
            catch (OperationCanceledException)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Cancelled,
                    Message = "Cancelled"
                };
            }
            catch (Exception ex)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = ex.Message,
                    Exception = ex
                };
            }
        }

        private static async Task<PaymentTerminalChargeResult> ChargeHalykAsync(
            sys_configurationpaymentterminal terminal,
            decimal amount,
            Action<string> log,
            CancellationToken cancellationToken)
        {
            try
            {
                HalykPosClient client = new HalykPosClient(terminal.Host, terminal.Port);
                int amountTenge = KaspiSmartPosClient.ConvertAmountToTenge(amount);
                log?.Invoke("Halyk " + client.BaseUrl);
                log?.Invoke(string.Format("Payment {0} -> amount={1} ₸", amount, amountTenge));
                log?.Invoke("Держите терминал включённым (режим кассы), иначе API засыпает.");
                return await client.PurchaseAsync(amountTenge, cancellationToken).ConfigureAwait(false);
            }
            catch (OperationCanceledException)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Cancelled,
                    Message = "Cancelled"
                };
            }
            catch (Exception ex)
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = ex.Message,
                    Exception = ex
                };
            }
        }

        private static KaspiSmartPosClient CreateClient(sys_configurationpaymentterminal terminal)
        {
            return new KaspiSmartPosClient(
                terminal.Host,
                terminal.Port,
                terminal.UseHttps,
                ignoreSslErrors: true);
        }

        private static async Task<string> EnsureAccessTokenAsync(
            Session session,
            sys_configurationpaymentterminal terminal,
            KaspiSmartPosClient client,
            Action<string> log,
            CancellationToken cancellationToken)
        {
            if (TokenIsValid(terminal))
            {
                return terminal.AccessToken;
            }

            log?.Invoke("Token expired or missing, registering...");
            log?.Invoke("Смотрите на экран Kaspi и подтвердите доступ кассы.");
            KaspiRegisterResult registerResult = await RegisterWithHttpsFallbackAsync(session, terminal, client, log, cancellationToken).ConfigureAwait(false);
            if (!registerResult.Success)
            {
                log?.Invoke(registerResult.Message ?? "Registration failed");
                return null;
            }

            return terminal.AccessToken;
        }

        /// <summary>
        /// If HTTPS fails and UseHttps=true, retries once over HTTP (common when «Защита интеграции» is off).
        /// </summary>
        private static async Task<KaspiRegisterResult> RegisterWithHttpsFallbackAsync(
            Session session,
            sys_configurationpaymentterminal terminal,
            KaspiSmartPosClient client,
            Action<string> log,
            CancellationToken cancellationToken)
        {
            KaspiRegisterResult result = await RegisterOrRefreshAsync(session, terminal, client, cancellationToken).ConfigureAwait(false);
            if (result.Success || !terminal.UseHttps)
            {
                return result;
            }

            log?.Invoke("HTTPS не ответил — пробуем HTTP (без «Защиты интеграции»)…");
            KaspiSmartPosClient httpClient = new KaspiSmartPosClient(
                terminal.Host,
                terminal.Port,
                useHttps: false,
                ignoreSslErrors: true);

            KaspiRegisterResult httpResult = await RegisterOrRefreshAsync(session, terminal, httpClient, cancellationToken).ConfigureAwait(false);
            if (httpResult.Success)
            {
                terminal.UseHttps = false;
                terminal.Save();
                log?.Invoke("Успех по HTTP. Галочка HTTPS на терминале в CleverPos снята.");
            }

            return httpResult;
        }

        private static bool TokenIsValid(sys_configurationpaymentterminal terminal)
        {
            if (string.IsNullOrWhiteSpace(terminal.AccessToken))
            {
                return false;
            }

            if (!terminal.TokenExpiration.HasValue)
            {
                return true;
            }

            return terminal.TokenExpiration.Value > DateTime.Now.AddMinutes(1);
        }

        private static async Task<KaspiRegisterResult> RegisterOrRefreshAsync(
            Session session,
            sys_configurationpaymentterminal terminal,
            KaspiSmartPosClient client,
            CancellationToken cancellationToken)
        {
            string clientName = string.IsNullOrWhiteSpace(terminal.PosClientName)
                ? "CleverPos-1"
                : terminal.PosClientName.Trim();

            KaspiRegisterResult result;
            if (!string.IsNullOrWhiteSpace(terminal.RefreshToken) && terminal.TokenExpiration.HasValue && terminal.TokenExpiration.Value <= DateTime.Now)
            {
                result = await client.RevokeAsync(clientName, terminal.RefreshToken, cancellationToken).ConfigureAwait(false);
            }
            else
            {
                result = await client.RegisterAsync(clientName, cancellationToken).ConfigureAwait(false);
            }

            if (result.Success)
            {
                terminal.AccessToken = result.AccessToken;
                terminal.RefreshToken = result.RefreshToken;
                terminal.TokenExpiration = result.ExpirationDate;
                terminal.Save();
            }

            return result;
        }
    }
}
