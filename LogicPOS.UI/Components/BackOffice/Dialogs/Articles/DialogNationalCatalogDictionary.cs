using Gtk;
using LogicPOS.NationalCatalog;
using LogicPOS.NationalCatalog.Models;
using LogicPOS.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace logicpos.Classes.Gui.Gtk.BackOffice
{
    /// <summary>
    /// Simple search picker for flat NKT dictionaries (e.g. TNVED).
    /// </summary>
    internal class DialogNationalCatalogDictionary : Dialog
    {
        private const int ColDisplay = 0;
        private const int ColCode = 1;

        private readonly NationalCatalogDictionaryService _dictionaryService;
        private readonly TreeStore _treeStore;
        private readonly TreeView _treeView;
        private readonly Entry _entrySearch;
        private readonly Label _labelStatus;
        private CancellationTokenSource _loadCts;
        private bool _alive = true;
        private bool _closing;

        public string SelectedCode { get; private set; }
        public string SelectedNameRu { get; private set; }

        public DialogNationalCatalogDictionary(
            Window parent,
            NationalCatalogClient client,
            string dictionaryCode,
            string title,
            string hint,
            string currentCode,
            string initialSearch)
            : base(title, parent, DialogFlags.Modal)
        {
            _dictionaryService = new NationalCatalogDictionaryService(client, dictionaryCode);
            SetDefaultSize(720, 480);
            SetPosition(WindowPosition.CenterOnParent);
            BorderWidth = 8;
            DeleteEvent += delegate(object o, DeleteEventArgs args)
            {
                CaptureSelection();
                args.RetVal = false;
            };

            VBox vbox = new VBox(false, 6);

            Label labelHint = new Label(hint)
            {
                Xalign = 0f,
                LineWrap = true
            };
            vbox.PackStart(labelHint, false, false, 0);

            HBox hboxSearch = new HBox(false, 6);
            // Prefer already chosen code; do not auto-fill shop product name (e.g. "Топ") — it is not a TNVED term.
            string searchSeed = string.Empty;
            if (!string.IsNullOrWhiteSpace(currentCode) && currentCode.Trim().All(char.IsDigit))
            {
                searchSeed = currentCode.Trim();
            }

            _entrySearch = new Entry { Text = searchSeed };
            Button buttonSearch = new Button(GeneralUtils.GetResourceByName("global_national_catalog_oktru_search"));
            buttonSearch.Clicked += ButtonSearch_Clicked;
            _entrySearch.Activated += delegate { ButtonSearch_Clicked(buttonSearch, EventArgs.Empty); };
            hboxSearch.PackStart(new Label(GeneralUtils.GetResourceByName("widget_generictreeviewsearch_search_label")) { Xalign = 0f }, false, false, 0);
            hboxSearch.PackStart(_entrySearch, true, true, 0);
            hboxSearch.PackStart(buttonSearch, false, false, 0);
            vbox.PackStart(hboxSearch, false, false, 0);

            string statusSeed = GeneralUtils.GetResourceByName("global_national_catalog_tnved_search_hint");
            if (!string.IsNullOrWhiteSpace(initialSearch))
            {
                statusSeed = string.Format(
                    GeneralUtils.GetResourceByName("global_national_catalog_tnved_product_hint"),
                    initialSearch.Trim());
            }

            _labelStatus = new Label(statusSeed)
            {
                Xalign = 0f,
                LineWrap = true,
                Selectable = true
            };
            vbox.PackStart(_labelStatus, false, false, 0);

            _treeStore = new TreeStore(typeof(string), typeof(string));
            _treeView = new TreeView(_treeStore);
            _treeView.HeadersVisible = true;
            _treeView.AppendColumn(new TreeViewColumn(GeneralUtils.GetResourceByName("global_designation"), new CellRendererText(), "text", ColDisplay) { Resizable = true });
            _treeView.AppendColumn(new TreeViewColumn(GeneralUtils.GetResourceByName("global_national_catalog_tnved"), new CellRendererText(), "text", ColCode) { Resizable = true });
            _treeView.RowActivated += TreeView_RowActivated;
            _treeView.Selection.Changed += delegate { CaptureSelection(); };

            ScrolledWindow scrolled = new ScrolledWindow();
            scrolled.SetPolicy(PolicyType.Automatic, PolicyType.Automatic);
            scrolled.Add(_treeView);
            vbox.PackStart(scrolled, true, true, 0);

            VBox.Add(vbox);
            AddButton(GeneralUtils.GetResourceByName("global_button_label_cancel"), ResponseType.Cancel);
            AddButton(GeneralUtils.GetResourceByName("global_button_label_ok"), ResponseType.Ok);
            DefaultResponse = ResponseType.Ok;
            Response += DialogNationalCatalogDictionary_Response;

            ShowAll();

            // Auto-search only for numeric TNVED codes already on the form.
            if (!string.IsNullOrWhiteSpace(_entrySearch.Text) && _entrySearch.Text.Trim().All(char.IsDigit))
            {
                SearchAsync(_entrySearch.Text.Trim());
            }
        }

        private void DialogNationalCatalogDictionary_Response(object o, ResponseArgs args)
        {
            if (_closing)
            {
                return;
            }

            _closing = true;
            _loadCts?.Cancel();
            if (args.ResponseId == ResponseType.Ok)
            {
                CaptureSelection();
            }
        }

        private void CaptureSelection()
        {
            if (!_alive || _treeView == null || _treeStore == null)
            {
                return;
            }

            TreeIter iter;
            if (!_treeView.Selection.GetSelected(out iter))
            {
                return;
            }

            SelectedCode = (_treeStore.GetValue(iter, ColCode) as string)?.Trim();
            SelectedNameRu = (_treeStore.GetValue(iter, ColDisplay) as string)?.Trim();
        }

        private void TreeView_RowActivated(object o, RowActivatedArgs args)
        {
            if (!_alive || _closing)
            {
                return;
            }

            CaptureSelection();
            if (string.IsNullOrWhiteSpace(SelectedCode))
            {
                return;
            }

            GLib.Idle.Add(delegate
            {
                if (_alive && !_closing)
                {
                    Respond(ResponseType.Ok);
                }

                return false;
            });
        }

        private void ButtonSearch_Clicked(object sender, EventArgs e)
        {
            SearchAsync(_entrySearch.Text?.Trim());
        }

        private void SearchAsync(string query)
        {
            _loadCts?.Cancel();
            _loadCts = new CancellationTokenSource();
            CancellationToken token = _loadCts.Token;
            SetStatusText(GeneralUtils.GetResourceByName("global_national_catalog_oktru_searching"));
            _treeStore.Clear();

            Task.Run(async () =>
            {
                try
                {
                    DictionarySearchResult results = await _dictionaryService.SearchAsync(query, token).ConfigureAwait(false);
                    Application.Invoke(delegate
                    {
                        if (!_alive || token.IsCancellationRequested)
                        {
                            return;
                        }

                        _treeStore.Clear();
                        foreach (NktDictionaryItem item in results.Items)
                        {
                            string code = item.ResolvedCode ?? string.Empty;
                            string display = item.GetDisplayName();
                            _treeStore.AppendValues(display, code);
                        }

                        SetStatusText(results.StatusMessage);
                    });
                }
                catch (OperationCanceledException)
                {
                }
                catch (Exception ex)
                {
                    Application.Invoke(delegate
                    {
                        if (_alive)
                        {
                            SetStatusText(ex.Message);
                        }
                    });
                }
            }, token);
        }

        private void SetStatusText(string message)
        {
            if (_labelStatus != null && _alive)
            {
                _labelStatus.Text = message ?? string.Empty;
            }
        }

        protected override void OnDestroyed()
        {
            _alive = false;
            _closing = true;
            _loadCts?.Cancel();
            base.OnDestroyed();
        }
    }
}
