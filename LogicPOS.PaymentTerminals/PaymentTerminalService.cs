using DevExpress.Xpo;
using LogicPOS.Domain.Entities;
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

            if (!string.Equals(terminal.Brand, "KASPI", StringComparison.OrdinalIgnoreCase))
            {
                return new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Failed,
                    Message = $"Terminal brand '{terminal.Brand}' is not supported yet"
                };
            }

            try
            {
                KaspiSmartPosClient client = new KaspiSmartPosClient(
                    terminal.Host,
                    terminal.Port,
                    terminal.UseHttps,
                    ignoreSslErrors: true);

                string accessToken = await EnsureAccessTokenAsync(session, terminal, client, log, cancellationToken).ConfigureAwait(false);
                if (string.IsNullOrWhiteSpace(accessToken))
                {
                    return new PaymentTerminalChargeResult
                    {
                        Status = PaymentTerminalChargeStatus.Failed,
                        Message = "Failed to obtain Kaspi access token"
                    };
                }

                int amountTiyn = KaspiSmartPosClient.ConvertAmountToTiyn(amount);
                log?.Invoke($"Payment {amount} -> amount={amountTiyn}");

                KaspiPaymentStatusResult started = await client.StartPaymentAsync(accessToken, amountTiyn, ownCheque: true, cancellationToken).ConfigureAwait(false);
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
                        AuthorizationCode = finalStatus.AuthorizationCode
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

        public static async Task<KaspiRegisterResult> TestConnectionAsync(
            Session session,
            sys_configurationpaymentterminal terminal,
            Action<string> log = null,
            CancellationToken cancellationToken = default)
        {
            KaspiSmartPosClient client = new KaspiSmartPosClient(
                terminal.Host,
                terminal.Port,
                terminal.UseHttps,
                ignoreSslErrors: true);

            log?.Invoke($"Connect {client.BaseUrl}");

            KaspiRegisterResult registerResult = await RegisterOrRefreshAsync(session, terminal, client, cancellationToken).ConfigureAwait(false);
            if (registerResult.Success)
            {
                log?.Invoke("Registration OK");
            }
            else
            {
                log?.Invoke(registerResult.Message ?? "Registration failed");
            }

            return registerResult;
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
            KaspiRegisterResult registerResult = await RegisterOrRefreshAsync(session, terminal, client, cancellationToken).ConfigureAwait(false);
            return registerResult.Success ? terminal.AccessToken : null;
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
