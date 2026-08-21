using Gtk;
using logicpos.Classes.Enums.Dialogs;
using logicpos.Classes.Enums.Keyboard;
using logicpos.Classes.Gui.Gtk.BackOffice;
using logicpos.Classes.Gui.Gtk.Widgets;
using logicpos.Classes.Gui.Gtk.Widgets.Buttons;
using logicpos.Classes.Gui.Gtk.WidgetsXPO;
using LogicPOS.Domain.Entities;
using LogicPOS.Globalization;
using LogicPOS.Modules.StockManagement;
using LogicPOS.Settings;
using LogicPOS.Utility;
using System;
using System.Drawing;

namespace logicpos.Classes.Gui.Gtk.Pos.Dialogs
{
    /// <summary>
    /// Inventory adjust (counted qty). Used only from stock window.
    /// Safe for stores that never open this dialog — no effect on normal POS.
    /// </summary>
    public class PosInventoryAdjustDialog : PosBaseDialog
    {
        private readonly Fixed _fixedContent;
        private readonly TouchButtonIconWithText _buttonOk;
        private XPOEntryBoxSelectRecordValidation<fin_article, TreeViewArticle> _entryArticle;
        private EntryBoxValidation _entryBookQty;
        private EntryBoxValidation _entryCountedQty;
        private EntryBoxValidation _entryNotes;
        private Label _labelDelta;

        public PosInventoryAdjustDialog(Window pSourceWindow, DialogFlags pDialogFlags, fin_article preselected = null)
            : base(pSourceWindow, pDialogFlags)
        {
            string windowTitle = "Инвентаризация";
            Size windowSize = new Size(520, 400);
            string fileDefaultWindowIcon = PathsSettings.ImagesFolderLocation + @"Icons\Windows\icon_window_stocks.png";

            _fixedContent = new Fixed();
            InitUI(preselected);

            _buttonOk = ActionAreaButton.FactoryGetDialogButtonType(PosBaseDialogButtonType.Ok);
            TouchButtonIconWithText buttonCancel = ActionAreaButton.FactoryGetDialogButtonType(PosBaseDialogButtonType.Cancel);
            _buttonOk.Sensitive = false;

            ActionAreaButtons actionAreaButtons = new ActionAreaButtons
            {
                new ActionAreaButton(_buttonOk, ResponseType.Ok),
                new ActionAreaButton(buttonCancel, ResponseType.Cancel)
            };

            InitObject(this, pDialogFlags, fileDefaultWindowIcon, windowTitle, windowSize, _fixedContent, actionAreaButtons);
        }

        private void InitUI(fin_article preselected)
        {
            VBox vbox = new VBox(false, 6) { BorderWidth = 8 };

            _entryArticle = new XPOEntryBoxSelectRecordValidation<fin_article, TreeViewArticle>(
                this,
                CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, "global_article"),
                "Designation",
                "Oid",
                preselected,
                RegexUtils.RegexGuid,
                true);
            _entryArticle.EntryValidation.IsEditable = false;
            _entryArticle.ClosePopup += (s, e) =>
            {
                RefreshBookQty(_entryArticle.Value);
                RefreshDeltaAndOk();
            };

            _entryBookQty = new EntryBoxValidation(this, "Учёт (книга)", KeyboardMode.None, RegexUtils.RegexDecimalGreaterEqualThanZero, false);
            _entryBookQty.EntryValidation.Sensitive = false;
            _entryBookQty.EntryValidation.Text = "0";

            _entryCountedQty = new EntryBoxValidation(this, "Факт (пересчёт)", KeyboardMode.AlfaNumeric, RegexUtils.RegexDecimalGreaterEqualThanZero, true);
            _entryCountedQty.EntryValidation.Changed += (s, e) => RefreshDeltaAndOk();

            _entryNotes = new EntryBoxValidation(
                this,
                CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, "global_notes"),
                KeyboardMode.AlfaNumeric,
                RegexUtils.RegexAlfaNumericExtended,
                false);

            _labelDelta = new Label("Разница: 0") { Xalign = 0 };

            vbox.PackStart(_entryArticle, false, false, 0);
            vbox.PackStart(_entryBookQty, false, false, 0);
            vbox.PackStart(_entryCountedQty, false, false, 0);
            vbox.PackStart(_labelDelta, false, false, 4);
            vbox.PackStart(_entryNotes, false, false, 0);
            _fixedContent.Put(vbox, 0, 0);

            if (preselected != null)
            {
                RefreshBookQty(preselected);
            }
        }

        private void RefreshBookQty(fin_article article)
        {
            if (article == null)
            {
                _entryBookQty.EntryValidation.Text = "0";
                return;
            }

            decimal book = logicpos.Utils.GetArticleStockSum(article.Oid);
            _entryBookQty.EntryValidation.Text = DataConversionUtils.DecimalToString(book, "0.####");
            if (string.IsNullOrWhiteSpace(_entryCountedQty.EntryValidation.Text)
                || _entryCountedQty.EntryValidation.Text == "0")
            {
                _entryCountedQty.EntryValidation.Text = _entryBookQty.EntryValidation.Text;
            }
        }

        private void RefreshDeltaAndOk()
        {
            try
            {
                decimal book = ParseDecimal(_entryBookQty.EntryValidation.Text);
                decimal counted = ParseDecimal(_entryCountedQty.EntryValidation.Text);
                decimal delta = counted - book;
                _labelDelta.Text = string.Format(
                    "Разница: {0} ({1})",
                    DataConversionUtils.DecimalToString(delta, "0.####"),
                    delta > 0 ? "приход" : delta < 0 ? "списание" : "без изменений");

                _buttonOk.Sensitive = _entryArticle.Value != null
                    && _entryCountedQty.EntryValidation.Validated
                    && delta != 0m;
            }
            catch
            {
                _buttonOk.Sensitive = false;
            }
        }

        private static decimal ParseDecimal(string text)
        {
            if (string.IsNullOrWhiteSpace(text))
            {
                return 0m;
            }

            if (decimal.TryParse(
                text.Replace(',', '.'),
                System.Globalization.NumberStyles.Any,
                System.Globalization.CultureInfo.InvariantCulture,
                out decimal value))
            {
                return value;
            }

            return Convert.ToDecimal(text);
        }

        public fin_article SelectedArticle => _entryArticle?.Value;
        public string CountedQtyText => _entryCountedQty?.EntryValidation?.Text ?? "0";
        public string NotesText => _entryNotes?.EntryValidation?.Text ?? string.Empty;

        /// <summary>Show dialog; apply adjustment on Ok. Returns true if stock changed.</summary>
        public static bool RunAdjust(Window parent, fin_article preselected = null)
        {
            PosInventoryAdjustDialog dialog = new PosInventoryAdjustDialog(parent, DialogFlags.DestroyWithParent, preselected);
            int response = dialog.Run();
            bool changed = false;
            try
            {
                if (response == (int)ResponseType.Ok && dialog.SelectedArticle != null)
                {
                    fin_article article = dialog.SelectedArticle;
                    article.Reload();
                    decimal counted = ParseDecimal(dialog.CountedQtyText);
                    changed = ProcessArticleStock.AdjustToCountedQuantity(
                        article,
                        counted,
                        dialog.NotesText);

                    if (!changed)
                    {
                        logicpos.Utils.ShowMessageBox(
                            parent,
                            DialogFlags.Modal,
                            new Size(400, 200),
                            MessageType.Info,
                            ButtonsType.Ok,
                            "Инвентаризация",
                            "Факт совпадает с учётом — корректировка не нужна.");
                    }
                }
            }
            catch (Exception ex)
            {
                logicpos.Utils.ShowMessageBox(
                    parent,
                    DialogFlags.Modal,
                    new Size(420, 220),
                    MessageType.Error,
                    ButtonsType.Ok,
                    "Инвентаризация",
                    ex.Message);
            }
            finally
            {
                dialog.Destroy();
            }

            return changed;
        }
    }
}
