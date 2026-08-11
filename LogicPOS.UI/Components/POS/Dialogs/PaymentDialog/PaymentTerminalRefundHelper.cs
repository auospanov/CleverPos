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
using System.Collections.Generic;

namespace logicpos.Classes.Gui.Gtk.Pos.Dialogs
{
    internal static class PaymentTerminalRefundHelper
    {
        /// <summary>
        /// Resolves payment terminal for charge/refund.
        /// Prefer linked terminal if still enabled; else brand-filtered enabled list.
        /// If more than one candidate and <paramref name="parent"/> is set, shows picker.
        /// If exactly one — returns it without dialog.
        /// </summary>
        public static sys_configurationpaymentterminal ResolveTerminal(
            fin_configurationpaymentmethod paymentMethod,
            Window parent = null)
        {
            if (paymentMethod == null)
            {
                return null;
            }

            string brand = InferBrand(paymentMethod);
            List<sys_configurationpaymentterminal> candidates = ListEnabledByBrand(brand);

            // Linked terminal still valid and matches brand (or brand unknown) → prefer it when alone or when still in list
            sys_configurationpaymentterminal linked = paymentMethod.PaymentTerminal;
            if (linked != null && !linked.Disabled)
            {
                if (string.IsNullOrEmpty(brand)
                    || BrandsMatch(linked.Brand, brand))
                {
                    if (candidates.Count <= 1)
                    {
                        return linked;
                    }

                    // Multiple of same brand: still offer picker, but keep linked first
                    if (!candidates.Exists(t => t.Oid == linked.Oid))
                    {
                        candidates.Insert(0, linked);
                    }
                }
            }

            if (candidates.Count == 0)
            {
                // Last resort: any enabled terminal
                candidates = ListEnabledByBrand(null);
            }

            if (candidates.Count == 0)
            {
                return null;
            }

            if (candidates.Count == 1)
            {
                return candidates[0];
            }

            if (parent == null)
            {
                return candidates[0];
            }

            PaymentTerminalPickerDialog dialog = new PaymentTerminalPickerDialog(parent, candidates);
            try
            {
                ResponseType response = (ResponseType)dialog.Run();
                return response == ResponseType.Ok ? dialog.Selected : null;
            }
            finally
            {
                dialog.Destroy();
            }
        }

        public static string InferBrand(fin_configurationpaymentmethod paymentMethod)
        {
            if (paymentMethod == null)
            {
                return null;
            }

            if (paymentMethod.PaymentTerminal != null
                && !string.IsNullOrWhiteSpace(paymentMethod.PaymentTerminal.Brand))
            {
                return NormalizeBrand(paymentMethod.PaymentTerminal.Brand);
            }

            string token = (paymentMethod.Token ?? string.Empty).Trim().ToUpperInvariant();
            if (token.StartsWith("KASPI", StringComparison.Ordinal))
            {
                return "KASPI";
            }

            if (token.StartsWith("HALYK", StringComparison.Ordinal))
            {
                return "HALYK";
            }

            if (token.StartsWith("JUSAN", StringComparison.Ordinal)
                || token.StartsWith("JYSAN", StringComparison.Ordinal))
            {
                return "JUSAN";
            }

            return null;
        }

        public static List<sys_configurationpaymentterminal> ListEnabledByBrand(string brand)
        {
            var result = new List<sys_configurationpaymentterminal>();
            Session session = XPOSettings.Session;
            if (session == null)
            {
                return result;
            }

            XPCollection<sys_configurationpaymentterminal> all = new XPCollection<sys_configurationpaymentterminal>(
                session,
                CriteriaOperator.Parse("Disabled = 0 OR Disabled IS NULL"));

            string normalized = NormalizeBrand(brand);
            foreach (sys_configurationpaymentterminal terminal in all)
            {
                if (terminal == null || terminal.Disabled)
                {
                    continue;
                }

                if (string.IsNullOrEmpty(normalized)
                    || BrandsMatch(terminal.Brand, normalized))
                {
                    result.Add(terminal);
                }
            }

            return result;
        }

        private static string NormalizeBrand(string brand)
        {
            if (string.IsNullOrWhiteSpace(brand))
            {
                return null;
            }

            string value = brand.Trim().ToUpperInvariant();
            if (value == "JYSAN")
            {
                return "JUSAN";
            }

            return value;
        }

        private static bool BrandsMatch(string left, string right)
        {
            return string.Equals(NormalizeBrand(left), NormalizeBrand(right), StringComparison.Ordinal);
        }

        /// <summary>
        /// Runs terminal refund for credit notes when payment method requires a terminal.
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

            sys_configurationpaymentterminal terminal = ResolveTerminal(paymentMethod, parent);
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

            string brand = NormalizeBrand(terminal.Brand) ?? string.Empty;
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
