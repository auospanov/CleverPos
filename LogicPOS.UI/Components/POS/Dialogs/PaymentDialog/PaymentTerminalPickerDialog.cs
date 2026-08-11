using Gtk;
using LogicPOS.Domain.Entities;
using System;
using System.Collections.Generic;

namespace logicpos.Classes.Gui.Gtk.Pos.Dialogs
{
    /// <summary>
    /// Touch dialog to pick one of several enabled payment terminals.
    /// </summary>
    internal class PaymentTerminalPickerDialog : Dialog
    {
        public sys_configurationpaymentterminal Selected { get; private set; }

        public PaymentTerminalPickerDialog(Window parent, IList<sys_configurationpaymentterminal> terminals)
            : base("Выбор платёжного терминала", parent, DialogFlags.Modal | DialogFlags.DestroyWithParent)
        {
            if (terminals == null || terminals.Count == 0)
            {
                throw new ArgumentException("terminals");
            }

            SetDefaultSize(480, Math.Min(120 + terminals.Count * 56, 480));
            BorderWidth = 8;

            Label hint = new Label("Активных терминалов несколько. Выберите устройство:")
            {
                Xalign = 0f,
                LineWrap = true
            };

            VBox list = new VBox(false, 6);
            foreach (sys_configurationpaymentterminal terminal in terminals)
            {
                sys_configurationpaymentterminal local = terminal;
                string label = FormatTerminal(local);
                Button button = new Button(label) { HeightRequest = 48 };
                button.Clicked += delegate
                {
                    Selected = local;
                    Respond(ResponseType.Ok);
                };
                list.PackStart(button, false, false, 0);
            }

            Button cancel = new Button("Отмена");
            cancel.Clicked += delegate { Respond(ResponseType.Cancel); };

            VBox root = new VBox(false, 8);
            root.PackStart(hint, false, false, 0);
            root.PackStart(list, true, true, 0);
            root.PackStart(cancel, false, false, 0);
            VBox.Add(root);
            ShowAll();
        }

        private static string FormatTerminal(sys_configurationpaymentterminal terminal)
        {
            string name = string.IsNullOrWhiteSpace(terminal.Designation)
                ? (terminal.Brand ?? "Terminal")
                : terminal.Designation.Trim();
            string host = string.IsNullOrWhiteSpace(terminal.Host) ? "?" : terminal.Host.Trim();
            int port = terminal.Port > 0 ? terminal.Port : 8080;
            return string.Format("{0}  ({1}:{2})", name, host, port);
        }
    }
}
