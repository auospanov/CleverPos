using Gtk;
using logicpos.App;
using logicpos.Classes.Enums.Dialogs;
using logicpos.Classes.Gui.Gtk.Widgets.BackOffice;
using logicpos.Classes.Gui.Gtk.WidgetsGeneric;
using LogicPOS.Domain.Entities;
using LogicPOS.Globalization;
using LogicPOS.PaymentTerminals;
using LogicPOS.PaymentTerminals.Kaspi;
using LogicPOS.Utility;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace logicpos.Classes.Gui.Gtk.BackOffice
{
    internal class DialogConfigurationPaymentTerminal : BOBaseDialog
    {
        private Entry _entryHost;
        private Entry _entryPort;
        private Entry _entryPosClientName;
        private ComboBox _comboBrand;
        private CheckButton _checkUseHttps;
        private TextView _textViewLog;
        private Button _buttonTest;
        private Button _buttonDiscover;
        private Button _buttonRefundTest;
        private CancellationTokenSource _operationCts;

        public DialogConfigurationPaymentTerminal(Window pSourceWindow, GenericTreeViewXPO pTreeView, DialogFlags pFlags, DialogMode pDialogMode, Entity pXPGuidObject)
            : base(pSourceWindow, pTreeView, pFlags, pDialogMode, pXPGuidObject)
        {
            Title = logicpos.Utils.GetWindowTitle(GeneralUtils.GetResourceByName("window_title_edit_dialogconfigurationpaymentterminal"));
            SetSizeRequest(600, 640);
            Resizable = true;
            InitUI();
            InitConnectionTab();
            InitNotes();
            ShowAll();
        }

        private void InitConnectionTab()
        {
            VBox vboxTab2 = new VBox(false, _boxSpacing) { BorderWidth = (uint)_boxSpacing };

            Label labelHint = new Label(GeneralUtils.GetResourceByName("global_payment_terminal_log_hint"))
            {
                Xalign = 0f,
                LineWrap = true
            };
            vboxTab2.PackStart(labelHint, false, false, 0);

            HBox hboxButtons = new HBox(true, _boxSpacing);
            _buttonTest = new Button(GeneralUtils.GetResourceByName("global_payment_terminal_test_connection"));
            _buttonDiscover = new Button(GeneralUtils.GetResourceByName("global_payment_terminal_discover"));
            _buttonRefundTest = new Button("Тест возврата");
            _buttonTest.Clicked += ButtonTest_Clicked;
            _buttonDiscover.Clicked += ButtonDiscover_Clicked;
            _buttonRefundTest.Clicked += ButtonRefundTest_Clicked;
            hboxButtons.PackStart(_buttonTest, true, true, 0);
            hboxButtons.PackStart(_buttonDiscover, true, true, 0);
            hboxButtons.PackStart(_buttonRefundTest, true, true, 0);
            vboxTab2.PackStart(hboxButtons, false, false, 0);

            _textViewLog = new TextView
            {
                Editable = false,
                WrapMode = WrapMode.Word,
                CursorVisible = false
            };
            _textViewLog.ModifyFont(Pango.FontDescription.FromString("Consolas 9"));
            _textViewLog.Buffer.Text = GeneralUtils.GetResourceByName("global_payment_terminal_log_ready") + Environment.NewLine;

            ScrolledWindow scrolledLog = new ScrolledWindow
            {
                HeightRequest = 280,
                ShadowType = ShadowType.In
            };
            scrolledLog.SetPolicy(PolicyType.Automatic, PolicyType.Automatic);
            scrolledLog.Add(_textViewLog);
            vboxTab2.PackStart(scrolledLog, true, true, 0);

            _notebook.AppendPage(vboxTab2, new Label(GeneralUtils.GetResourceByName("global_payment_terminal_log_tab")));
        }

        private void InitUI()
        {
            try
            {
                VBox vboxTab1 = new VBox(false, _boxSpacing) { BorderWidth = (uint)_boxSpacing };

                Entry entryOrd = new Entry();
                BOWidgetBox boxOrd = new BOWidgetBox(GeneralUtils.GetResourceByName("global_record_order"), entryOrd);
                vboxTab1.PackStart(boxOrd, false, false, 0);
                _crudWidgetList.Add(new GenericCRUDWidgetXPO(boxOrd, _dataSourceRow, "Ord", RegexUtils.RegexIntegerGreaterThanZero, true));

                Entry entryCode = new Entry();
                BOWidgetBox boxCode = new BOWidgetBox(GeneralUtils.GetResourceByName("global_record_code"), entryCode);
                vboxTab1.PackStart(boxCode, false, false, 0);
                _crudWidgetList.Add(new GenericCRUDWidgetXPO(boxCode, _dataSourceRow, "Code", RegexUtils.RegexIntegerGreaterThanZero, true));

                Entry entryDesignation = new Entry();
                BOWidgetBox boxDesignation = new BOWidgetBox(GeneralUtils.GetResourceByName("global_designation"), entryDesignation);
                vboxTab1.PackStart(boxDesignation, false, false, 0);
                _crudWidgetList.Add(new GenericCRUDWidgetXPO(boxDesignation, _dataSourceRow, "Designation", RegexUtils.RegexAlfaNumericExtended, true));

                _comboBrand = new ComboBox(new string[] { "KASPI", "HALYK", "JUSAN" });
                sys_configurationpaymentterminal terminalRow = _dataSourceRow as sys_configurationpaymentterminal;
                if (!string.IsNullOrWhiteSpace(terminalRow?.Brand))
                {
                    int brandIndex = Array.IndexOf(new[] { "KASPI", "HALYK", "JUSAN" }, terminalRow.Brand.ToUpperInvariant());
                    if (brandIndex >= 0)
                    {
                        _comboBrand.Active = brandIndex;
                    }
                }
                _comboBrand.Changed += delegate
                {
                    if (terminalRow != null)
                    {
                        terminalRow.Brand = _comboBrand.ActiveText;
                    }
                };
                BOWidgetBox boxBrand = new BOWidgetBox(GeneralUtils.GetResourceByName("global_payment_terminal_brand"), _comboBrand);
                vboxTab1.PackStart(boxBrand, false, false, 0);

                _entryHost = new Entry();
                BOWidgetBox boxHost = new BOWidgetBox(GeneralUtils.GetResourceByName("global_payment_terminal_host"), _entryHost);
                vboxTab1.PackStart(boxHost, false, false, 0);
                _crudWidgetList.Add(new GenericCRUDWidgetXPO(boxHost, _dataSourceRow, "Host", RegexUtils.RegexAlfaNumericExtended, false));

                _entryPort = new Entry();
                BOWidgetBox boxPort = new BOWidgetBox(GeneralUtils.GetResourceByName("global_payment_terminal_port"), _entryPort);
                vboxTab1.PackStart(boxPort, false, false, 0);
                _crudWidgetList.Add(new GenericCRUDWidgetXPO(boxPort, _dataSourceRow, "Port", RegexUtils.RegexIntegerGreaterThanZero, true));

                _entryPosClientName = new Entry();
                BOWidgetBox boxPosClientName = new BOWidgetBox(GeneralUtils.GetResourceByName("global_payment_terminal_pos_client_name"), _entryPosClientName);
                vboxTab1.PackStart(boxPosClientName, false, false, 0);
                _crudWidgetList.Add(new GenericCRUDWidgetXPO(boxPosClientName, _dataSourceRow, "PosClientName", RegexUtils.RegexAlfaNumericExtended, false));

                _checkUseHttps = new CheckButton(GeneralUtils.GetResourceByName("global_payment_terminal_use_https"));
                if (_dialogMode == DialogMode.Insert)
                {
                    _checkUseHttps.Active = false;
                }
                vboxTab1.PackStart(_checkUseHttps, false, false, 0);
                _crudWidgetList.Add(new GenericCRUDWidgetXPO(_checkUseHttps, _dataSourceRow, "UseHttps"));

                CheckButton checkButtonDisabled = new CheckButton(GeneralUtils.GetResourceByName("global_record_disabled"));
                if (_dialogMode == DialogMode.Insert)
                {
                    checkButtonDisabled.Active = POSSettings.BOXPOObjectsStartDisabled;
                }
                vboxTab1.PackStart(checkButtonDisabled, false, false, 0);
                _crudWidgetList.Add(new GenericCRUDWidgetXPO(checkButtonDisabled, _dataSourceRow, "Disabled"));

                _notebook.AppendPage(vboxTab1, new Label(GeneralUtils.GetResourceByName("global_record_main_detail")));

                entryOrd.Sensitive = false;
                entryCode.Sensitive = false;
            }
            catch (Exception ex)
            {
                _logger.Error(ex.Message, ex);
            }
        }

        private void SwitchToLogTab()
        {
            if (_notebook != null && _notebook.NPages > 1)
            {
                _notebook.CurrentPage = 1;
            }
        }

        private void SetOperationButtonsSensitive(bool sensitive)
        {
            Application.Invoke(delegate
            {
                if (_buttonTest != null) _buttonTest.Sensitive = sensitive;
                if (_buttonDiscover != null) _buttonDiscover.Sensitive = sensitive;
                if (_buttonRefundTest != null) _buttonRefundTest.Sensitive = sensitive;
            });
        }

        private void ClearLog()
        {
            Application.Invoke(delegate
            {
                if (_textViewLog == null)
                {
                    return;
                }

                _textViewLog.Buffer.Clear();
            });
        }

        private void AppendLog(string message)
        {
            if (string.IsNullOrWhiteSpace(message))
            {
                return;
            }

            Application.Invoke(delegate
            {
                if (_textViewLog == null)
                {
                    return;
                }

                string line = string.Format("[{0:HH:mm:ss}] {1}", DateTime.Now, message.Trim());
                TextBuffer buffer = _textViewLog.Buffer;
                buffer.Insert(buffer.EndIter, line + Environment.NewLine);

                TextIter endIter = buffer.EndIter;
                _textViewLog.ScrollToIter(endIter, 0, false, 0, 1);
            });
        }

        private sys_configurationpaymentterminal GetTerminalFromForm()
        {
            sys_configurationpaymentterminal terminal = _dataSourceRow as sys_configurationpaymentterminal;
            if (terminal == null)
            {
                return null;
            }

            terminal.Brand = _comboBrand.ActiveText;
            terminal.Host = _entryHost.Text?.Trim();
            int.TryParse(_entryPort.Text, out int port);
            if (port > 0)
            {
                terminal.Port = port;
            }
            terminal.PosClientName = _entryPosClientName.Text?.Trim();
            terminal.UseHttps = _checkUseHttps.Active;
            return terminal;
        }

        private void ButtonTest_Clicked(object sender, EventArgs e)
        {
            sys_configurationpaymentterminal terminal = GetTerminalFromForm();
            if (terminal == null)
            {
                return;
            }

            if (string.IsNullOrWhiteSpace(terminal.Host))
            {
                SwitchToLogTab();
                ClearLog();
                AppendLog(GeneralUtils.GetResourceByName("global_payment_terminal_host_required"));
                return;
            }

            CancelOperation();
            SwitchToLogTab();
            ClearLog();
            _operationCts = new CancellationTokenSource();
            SetOperationButtonsSensitive(false);
            AppendLog(GeneralUtils.GetResourceByName("global_payment_terminal_test_started"));

            Task.Run(async () =>
            {
                try
                {
                    await PaymentTerminalService.TestConnectionAsync(
                        terminal.Session,
                        terminal,
                        AppendLog,
                        _operationCts.Token).ConfigureAwait(false);

                    AppendLog(GeneralUtils.GetResourceByName("global_payment_terminal_test_finished"));
                }
                catch (Exception ex)
                {
                    AppendLog(ex.Message);
                }
                finally
                {
                    SetOperationButtonsSensitive(true);
                }
            });
        }

        private void ButtonRefundTest_Clicked(object sender, EventArgs e)
        {
            sys_configurationpaymentterminal terminal = GetTerminalFromForm();
            if (terminal == null)
            {
                return;
            }

            if (string.IsNullOrWhiteSpace(terminal.Host))
            {
                SwitchToLogTab();
                ClearLog();
                AppendLog(GeneralUtils.GetResourceByName("global_payment_terminal_host_required"));
                return;
            }

            logicpos.Utils.ResponseText amountInput = logicpos.Utils.GetInputText(
                this,
                DialogFlags.Modal,
                "Тест возврата",
                string.Empty,
                "Сумма (тенге):",
                "100",
                RegexUtils.RegexIntegerGreaterThanZero,
                true);
            if (amountInput.ResponseType != ResponseType.Ok || !decimal.TryParse(amountInput.Text, out decimal amount) || amount <= 0)
            {
                return;
            }

            logicpos.Utils.ResponseText txnInput = logicpos.Utils.GetInputText(
                this,
                DialogFlags.Modal,
                "Тест возврата",
                string.Empty,
                "transactionId / tagRRN:",
                string.Empty,
                RegexUtils.RegexAlfaNumericExtended,
                true);
            if (txnInput.ResponseType != ResponseType.Ok || string.IsNullOrWhiteSpace(txnInput.Text))
            {
                return;
            }

            string method = null;
            string brand = (terminal.Brand ?? string.Empty).Trim().ToUpperInvariant();
            if (brand == "KASPI" || brand == string.Empty)
            {
                ResponseType isCard = logicpos.Utils.ShowMessageNonTouch(
                    this,
                    DialogFlags.Modal,
                    MessageType.Question,
                    ButtonsType.YesNo,
                    "Оплата была картой? (Да = Card, Нет = Qr)",
                    "Метод Kaspi");
                method = isCard == ResponseType.Yes ? "Card" : "Qr";
            }

            CancelOperation();
            SwitchToLogTab();
            ClearLog();
            _operationCts = new CancellationTokenSource();
            SetOperationButtonsSensitive(false);
            AppendLog("Refund test started...");

            string txn = txnInput.Text.Trim();
            Task.Run(async () =>
            {
                try
                {
                    PaymentTerminalChargeResult result = await PaymentTerminalService.RefundAsync(
                        terminal.Session,
                        terminal,
                        amount,
                        txn,
                        method,
                        AppendLog,
                        _operationCts.Token).ConfigureAwait(false);

                    AppendLog(result != null
                        ? string.Format("{0}: {1}", result.Status, result.Message)
                        : "No result");
                }
                catch (Exception ex)
                {
                    AppendLog(ex.Message);
                }
                finally
                {
                    SetOperationButtonsSensitive(true);
                }
            });
        }

        private void ButtonDiscover_Clicked(object sender, EventArgs e)
        {
            sys_configurationpaymentterminal terminal = GetTerminalFromForm();
            if (terminal == null)
            {
                return;
            }

            CancelOperation();
            SwitchToLogTab();
            ClearLog();
            _operationCts = new CancellationTokenSource();
            SetOperationButtonsSensitive(false);
            AppendLog(GeneralUtils.GetResourceByName("global_payment_terminal_discover_started"));

            Task.Run(async () =>
            {
                try
                {
                    var found = await KaspiTerminalDiscovery.DiscoverAsync(
                        terminal.Host,
                        terminal.Port > 0 ? terminal.Port : 8080,
                        terminal.UseHttps,
                        ignoreSslErrors: true,
                        progress: new Progress<string>(AppendLog),
                        cancellationToken: _operationCts.Token).ConfigureAwait(false);

                    if (found == null || found.Count == 0)
                    {
                        AppendLog(GeneralUtils.GetResourceByName("global_payment_terminal_discover_not_found"));
                        return;
                    }

                    AppendLog(GeneralUtils.GetResourceByName("global_payment_terminal_discover_found"));
                    foreach (string host in found)
                    {
                        AppendLog("  " + host);
                    }

                    Application.Invoke(delegate
                    {
                        _entryHost.Text = found.First();
                        terminal.Host = found.First();
                    });

                    AppendLog(GeneralUtils.GetResourceByName("global_payment_terminal_discover_ip_applied"));
                }
                catch (Exception ex)
                {
                    AppendLog(ex.Message);
                }
                finally
                {
                    SetOperationButtonsSensitive(true);
                }
            });
        }

        private void CancelOperation()
        {
            if (_operationCts != null)
            {
                _operationCts.Cancel();
                _operationCts.Dispose();
                _operationCts = null;
            }
        }

        protected override void OnDestroyed()
        {
            CancelOperation();
            base.OnDestroyed();
        }
    }
}
