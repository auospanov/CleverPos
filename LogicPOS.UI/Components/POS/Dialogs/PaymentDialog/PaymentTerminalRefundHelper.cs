using DevExpress.Data.Filtering;
using DevExpress.Xpo;
using Gtk;
using LogicPOS.Data.XPO.Settings;
using LogicPOS.Domain.Entities;
using LogicPOS.Finance.DocumentProcessing;
using LogicPOS.Globalization;
using LogicPOS.PaymentTerminals;
using LogicPOS.Settings;
using LogicPOS.Shared.CustomDocument;
using LogicPOS.Utility;
using System;

namespace logicpos.Classes.Gui.Gtk.Pos.Dialogs
{
    internal static class PaymentTerminalRefundHelper
    {
        public static sys_configurationpaymentterminal ResolveTerminal(fin_configurationpaymentmethod paymentMethod)
        {
            if (paymentMethod == null)
            {
                return null;
            }

            sys_configurationpaymentterminal terminal = paymentMethod.PaymentTerminal;
            if (terminal == null || terminal.Disabled)
            {
                terminal = XPOSettings.Session.FindObject<sys_configurationpaymentterminal>(
                    CriteriaOperator.Parse("Disabled = 0 OR Disabled IS NULL"));
            }

            return (terminal == null || terminal.Disabled) ? null : terminal;
        }

        /// <summary>
        /// Runs terminal refund for credit notes when payment method requires a terminal.
        /// Uses [TERM ...] from source invoice Notes, or asks cashier for transaction id.
        /// </summary>
        public static bool TryRefundForCreditNote(Window parent, DocumentProcessingParameters parameters)
        {
            if (parameters == null || parameters.DocumentType != CustomDocumentSettings.CreditNoteId)
            {
                return true;
            }

            if (parameters.PaymentMethod == Guid.Empty)
            {
                return true;
            }

            fin_configurationpaymentmethod paymentMethod = XPOSettings.Session.GetObjectByKey<fin_configurationpaymentmethod>(parameters.PaymentMethod);
            if (paymentMethod == null || !paymentMethod.RequiresPaymentTerminal)
            {
                return true;
            }

            sys_configurationpaymentterminal terminal = ResolveTerminal(paymentMethod);
            if (terminal == null)
            {
                ResponseType skip = logicpos.Utils.ShowMessageTouch(
                    parent,
                    DialogFlags.Modal,
                    MessageType.Warning,
                    ButtonsType.YesNo,
                    CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, "global_warning"),
                    "Терминал не настроен. Продолжить кредитную ноту без возврата на терминале?");
                return skip == ResponseType.Yes;
            }

            string transactionId = null;
            string method = null;
            string rrn;

            if (parameters.DocumentParent != Guid.Empty)
            {
                fin_documentfinancemaster parentDoc = XPOSettings.Session.GetObjectByKey<fin_documentfinancemaster>(parameters.DocumentParent);
                if (parentDoc != null)
                {
                    PaymentTerminalTransactionNotes.TryParse(parentDoc.Notes, out transactionId, out method, out rrn);
                }
            }

            if (string.IsNullOrWhiteSpace(transactionId))
            {
                PaymentTerminalTransactionNotes.TryParse(parameters.Notes, out transactionId, out method, out rrn);
            }

            decimal amount = parameters.ArticleBag != null ? parameters.ArticleBag.TotalFinal : 0m;
            return TryRefundWithPrompt(parent, terminal, amount, ref transactionId, ref method);
        }

        public static bool TryRefundWithPrompt(
            Window parent,
            sys_configurationpaymentterminal terminal,
            decimal amount,
            ref string transactionId,
            ref string method)
        {
            if (string.IsNullOrWhiteSpace(transactionId))
            {
                logicpos.Utils.ResponseText input = logicpos.Utils.GetInputText(
                    parent,
                    DialogFlags.Modal,
                    "Возврат на терминале",
                    string.Empty,
                    "ID операции / RRN / tagRRN:",
                    string.Empty,
                    RegexUtils.RegexAlfaNumericExtended,
                    true);

                if (input == null || input.ResponseType != ResponseType.Ok || string.IsNullOrWhiteSpace(input.Text))
                {
                    ResponseType skip = logicpos.Utils.ShowMessageTouch(
                        parent,
                        DialogFlags.Modal,
                        MessageType.Question,
                        ButtonsType.YesNo,
                        CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, "global_warning"),
                        "Без ID операции возврат на терминале невозможен. Продолжить документ без возврата на терминале?");
                    return skip == ResponseType.Yes;
                }

                transactionId = input.Text.Trim();
            }

            string brand = (terminal.Brand ?? string.Empty).Trim().ToUpperInvariant();
            if (brand == "KASPI" && string.IsNullOrWhiteSpace(method))
            {
                ResponseType isCard = logicpos.Utils.ShowMessageTouch(
                    parent,
                    DialogFlags.Modal,
                    MessageType.Question,
                    ButtonsType.YesNo,
                    "Метод оплаты Kaspi",
                    "Оплата была картой? (Да = Card, Нет = Qr)");
                method = isCard == ResponseType.Yes ? "Card" : "Qr";
            }

            PaymentTerminalProcessingDialog processingDialog = new PaymentTerminalProcessingDialog(
                parent,
                "Возврат на платёжном терминале");

            string txn = transactionId;
            string channel = method;
            processingDialog.RunPayment((log, token) =>
                PaymentTerminalService.RefundAsync(
                    terminal.Session,
                    terminal,
                    amount,
                    txn,
                    channel,
                    log,
                    token));

            PaymentTerminalChargeResult result = processingDialog.Result;
            processingDialog.Destroy();

            if (result == null)
            {
                return false;
            }

            if (result.Status == PaymentTerminalChargeStatus.Success || result.Status == PaymentTerminalChargeStatus.Skipped)
            {
                return true;
            }

            if (result.Status == PaymentTerminalChargeStatus.Cancelled)
            {
                return false;
            }

            ResponseType continueAnyway = logicpos.Utils.ShowMessageTouch(
                parent,
                DialogFlags.Modal,
                MessageType.Warning,
                ButtonsType.YesNo,
                CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, "global_warning"),
                (result.Message ?? "Возврат на терминале не выполнен.")
                    + Environment.NewLine
                    + "Продолжить документ без возврата на терминале?");
            return continueAnyway == ResponseType.Yes;
        }
    }
}
