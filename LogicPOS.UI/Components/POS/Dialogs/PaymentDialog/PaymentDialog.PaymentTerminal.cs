using DevExpress.Data.Filtering;
using DevExpress.Xpo;
using Gtk;
using LogicPOS.Data.XPO;
using LogicPOS.Data.XPO.Settings;
using LogicPOS.Domain.Entities;
using LogicPOS.Globalization;
using LogicPOS.PaymentTerminals;
using LogicPOS.Settings;
using logicpos.Classes.Gui.Gtk.Pos.Dialogs;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace logicpos.Classes.Gui.Gtk.Pos.Dialogs
{
    internal partial class PaymentDialog
    {
        private static fin_configurationpaymentmethod ResolvePaymentMethodButton(SQLSelectResultData data, params string[] tokens)
        {
            if (tokens == null || tokens.Length == 0)
            {
                return null;
            }

            foreach (string token in tokens)
            {
                fin_configurationpaymentmethod paymentMethod = (fin_configurationpaymentmethod)data.GetXPGuidObjectFromField(typeof(fin_configurationpaymentmethod), "Token", token);
                if (paymentMethod != null && !paymentMethod.Disabled)
                {
                    return paymentMethod;
                }
            }

            return (fin_configurationpaymentmethod)data.GetXPGuidObjectFromField(typeof(fin_configurationpaymentmethod), "Token", tokens[tokens.Length - 1]);
        }

        private bool TryProcessPaymentTerminalCharge(decimal amount)
        {
            if (PaymentMethod == null || !PaymentMethod.RequiresPaymentTerminal)
            {
                return true;
            }

            sys_configurationpaymentterminal terminal = PaymentMethod.PaymentTerminal;
            if (terminal == null || terminal.Disabled)
            {
                terminal = XPOSettings.Session.FindObject<sys_configurationpaymentterminal>(
                    CriteriaOperator.Parse("Disabled = 0 OR Disabled IS NULL"));
            }

            if (terminal == null || terminal.Disabled)
            {
                ResponseType response = logicpos.Utils.ShowMessageTouch(
                    this,
                    DialogFlags.Modal,
                    MessageType.Warning,
                    ButtonsType.YesNo,
                    CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, "global_warning"),
                    CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, "dialog_message_payment_terminal_not_configured"));

                return response == ResponseType.Yes;
            }

            PaymentTerminalProcessingDialog processingDialog = new PaymentTerminalProcessingDialog(
                this,
                CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, "window_title_dialog_payment_terminal_processing"));

            processingDialog.RunPayment((log, token) =>
                PaymentTerminalService.ChargeAsync(terminal.Session, terminal, amount, log, token));

            PaymentTerminalChargeResult result = processingDialog.Result;
            processingDialog.Destroy();

            if (result == null)
            {
                return false;
            }

            return result.ShouldContinueSale;
        }
    }
}
