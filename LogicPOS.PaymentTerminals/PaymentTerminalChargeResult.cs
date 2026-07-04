using System;

namespace LogicPOS.PaymentTerminals
{
    public enum PaymentTerminalChargeStatus
    {
        Success,
        Failed,
        Cancelled,
        Skipped
    }

    public class PaymentTerminalChargeResult
    {
        public PaymentTerminalChargeStatus Status { get; set; }
        public string Message { get; set; }
        public string ProcessId { get; set; }
        public string TransactionId { get; set; }
        public string Rrn { get; set; }
        public string AuthorizationCode { get; set; }
        public Exception Exception { get; set; }

        public bool ShouldContinueSale =>
            Status == PaymentTerminalChargeStatus.Success ||
            Status == PaymentTerminalChargeStatus.Skipped;
    }
}
