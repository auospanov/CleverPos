using System;
using System.Text.RegularExpressions;

namespace LogicPOS.PaymentTerminals
{
    /// <summary>
    /// Encodes terminal payment ids into document Notes for later refund.
    /// Format: [TERM txn=...;method=Card|Qr;rrn=...;auth=...]
    /// </summary>
    public static class PaymentTerminalTransactionNotes
    {
        private static readonly Regex TokenRegex = new Regex(
            @"\[TERM\s+([^\]]+)\]",
            RegexOptions.IgnoreCase | RegexOptions.CultureInvariant);

        public static string Append(string existingNotes, PaymentTerminalChargeResult result)
        {
            if (result == null || result.Status != PaymentTerminalChargeStatus.Success)
            {
                return existingNotes;
            }

            string txn = FirstNonEmpty(result.TransactionId, result.Rrn, result.ProcessId);
            if (string.IsNullOrWhiteSpace(txn))
            {
                return existingNotes;
            }

            string token = string.Format(
                "[TERM txn={0};method={1};rrn={2};auth={3}]",
                Sanitize(txn),
                Sanitize(result.PaymentMethodChannel ?? string.Empty),
                Sanitize(result.Rrn ?? string.Empty),
                Sanitize(result.AuthorizationCode ?? string.Empty));

            if (string.IsNullOrWhiteSpace(existingNotes))
            {
                return token;
            }

            if (existingNotes.IndexOf("[TERM ", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                return TokenRegex.Replace(existingNotes, token);
            }

            return existingNotes.TrimEnd() + " " + token;
        }

        public static bool TryParse(string notes, out string transactionId, out string method, out string rrn)
        {
            transactionId = null;
            method = null;
            rrn = null;

            if (string.IsNullOrWhiteSpace(notes))
            {
                return false;
            }

            Match match = TokenRegex.Match(notes);
            if (!match.Success)
            {
                return false;
            }

            string body = match.Groups[1].Value;
            foreach (string part in body.Split(new[] { ';' }, StringSplitOptions.RemoveEmptyEntries))
            {
                int eq = part.IndexOf('=');
                if (eq <= 0)
                {
                    continue;
                }

                string key = part.Substring(0, eq).Trim();
                string value = part.Substring(eq + 1).Trim();
                if (key.Equals("txn", StringComparison.OrdinalIgnoreCase))
                {
                    transactionId = value;
                }
                else if (key.Equals("method", StringComparison.OrdinalIgnoreCase))
                {
                    method = value;
                }
                else if (key.Equals("rrn", StringComparison.OrdinalIgnoreCase))
                {
                    rrn = value;
                }
            }

            if (string.IsNullOrWhiteSpace(transactionId) && !string.IsNullOrWhiteSpace(rrn))
            {
                transactionId = rrn;
            }

            return !string.IsNullOrWhiteSpace(transactionId);
        }

        private static string FirstNonEmpty(params string[] values)
        {
            if (values == null)
            {
                return null;
            }

            foreach (string value in values)
            {
                if (!string.IsNullOrWhiteSpace(value))
                {
                    return value.Trim();
                }
            }

            return null;
        }

        private static string Sanitize(string value)
        {
            return (value ?? string.Empty)
                .Replace("[", string.Empty)
                .Replace("]", string.Empty)
                .Replace(";", string.Empty)
                .Trim();
        }
    }
}
