using Gtk;
using LogicPOS.Globalization;
using LogicPOS.PaymentTerminals;
using LogicPOS.Settings;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace logicpos.Classes.Gui.Gtk.Pos.Dialogs
{
    internal class PaymentTerminalProcessingDialog : Dialog
    {
        private readonly TextView _textViewLog;
        private readonly Button _buttonContinueWithoutTerminal;
        private readonly Button _buttonCancel;
        private CancellationTokenSource _cts;
        private bool _finished;
        private PaymentTerminalChargeResult _result;

        public PaymentTerminalChargeResult Result => _result;

        public PaymentTerminalProcessingDialog(Window parent, string title)
            : base(title, parent, DialogFlags.Modal | DialogFlags.DestroyWithParent)
        {
            SetDefaultSize(520, 360);
            BorderWidth = 8;

            Label label = new Label(CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, "dialog_message_payment_terminal_processing"))
            {
                Xalign = 0f
            };

            _textViewLog = new TextView { Editable = false, WrapMode = WrapMode.Word };
            ScrolledWindow scrolled = new ScrolledWindow { HeightRequest = 220 };
            scrolled.Add(_textViewLog);

            _buttonContinueWithoutTerminal = new Button(CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, "dialog_button_payment_terminal_continue_without"));
            _buttonCancel = new Button(CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, "global_button_label_cancel"));

            _buttonContinueWithoutTerminal.Sensitive = false;
            _buttonContinueWithoutTerminal.Clicked += delegate
            {
                if (_finished)
                {
                    return;
                }

                _cts?.Cancel();
                _result = new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Skipped,
                    Message = "Continue without terminal"
                };
                _finished = true;
                Respond(ResponseType.Ok);
            };

            _buttonCancel.Clicked += delegate
            {
                _cts?.Cancel();
                _result = new PaymentTerminalChargeResult
                {
                    Status = PaymentTerminalChargeStatus.Cancelled,
                    Message = "Cancelled"
                };
                _finished = true;
                Respond(ResponseType.Cancel);
            };

            VBox vbox = new VBox(false, 8);
            vbox.PackStart(label, false, false, 0);
            vbox.PackStart(scrolled, true, true, 0);

            HBox buttons = new HBox(true, 8);
            buttons.PackStart(_buttonCancel, true, true, 0);
            buttons.PackStart(_buttonContinueWithoutTerminal, true, true, 0);
            vbox.PackStart(buttons, false, false, 0);

            VBox.Add(vbox);
            ShowAll();
        }

        public void AppendLog(string line)
        {
            Application.Invoke(delegate
            {
                TextBuffer buffer = _textViewLog.Buffer;
                buffer.Insert(buffer.EndIter, line + Environment.NewLine);
            });
        }

        public void RunPayment(Func<Action<string>, CancellationToken, Task<PaymentTerminalChargeResult>> paymentFunc)
        {
            _cts = new CancellationTokenSource();
            AppendLog(CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, "dialog_message_payment_terminal_started"));

            Task.Run(async () =>
            {
                try
                {
                    PaymentTerminalChargeResult result = await paymentFunc(AppendLog, _cts.Token).ConfigureAwait(false);
                    Application.Invoke(delegate
                    {
                        _result = result;
                        _finished = true;
                        if (result.Status == PaymentTerminalChargeStatus.Failed)
                        {
                            AppendLog(result.Message ?? "Failed");
                            _buttonContinueWithoutTerminal.Sensitive = true;
                        }
                        else
                        {
                            _finished = true;
                            Respond(ResponseType.Ok);
                        }
                    });
                }
                catch (OperationCanceledException)
                {
                    Application.Invoke(delegate
                    {
                        if (!_finished)
                        {
                            _result = new PaymentTerminalChargeResult
                            {
                                Status = PaymentTerminalChargeStatus.Cancelled,
                                Message = "Cancelled"
                            };
                            _finished = true;
                            Respond(ResponseType.Cancel);
                        }
                    });
                }
                catch (Exception ex)
                {
                    Application.Invoke(delegate
                    {
                        _result = new PaymentTerminalChargeResult
                        {
                            Status = PaymentTerminalChargeStatus.Failed,
                            Message = ex.Message,
                            Exception = ex
                        };
                        _finished = true;
                        AppendLog(ex.Message);
                        _buttonContinueWithoutTerminal.Sensitive = true;
                    });
                }
            });

            Run();
        }

        protected override void OnDestroyed()
        {
            _cts?.Cancel();
            _cts?.Dispose();
            base.OnDestroyed();
        }
    }
}
