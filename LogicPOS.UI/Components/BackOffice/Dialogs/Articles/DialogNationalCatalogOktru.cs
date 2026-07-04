using Gtk;
using LogicPOS.NationalCatalog;
using LogicPOS.NationalCatalog.Models;
using LogicPOS.Utility;
using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace logicpos.Classes.Gui.Gtk.BackOffice
{
    internal class DialogNationalCatalogOktru : Dialog
    {
        private const int ColDisplay = 0;
        private const int ColCode = 1;
        private const int ColId = 2;
        private const int ColChildrenLoaded = 3;
        private const int ColHasChildren = 4;

        private readonly NationalCatalogOktruService _oktruService;
        private readonly TreeStore _treeStore;
        private readonly TreeView _treeView;
        private readonly Entry _entrySearch;
        private readonly Label _labelStatus;
        private CancellationTokenSource _loadCts;
        private bool _alive = true;
        private bool _closing;

        public string SelectedOktruCode { get; private set; }
        public string SelectedNameRu { get; private set; }

        public DialogNationalCatalogOktru(Window parent, NationalCatalogClient client, string currentOktru)
            : base(GeneralUtils.GetResourceByName("global_national_catalog_oktru_dialog_title"), parent, DialogFlags.Modal)
        {
            _oktruService = new NationalCatalogOktruService(client);
            SetDefaultSize(720, 520);
            SetPosition(WindowPosition.CenterOnParent);
            BorderWidth = 8;
            DeleteEvent += DialogNationalCatalogOktru_DeleteEvent;

            VBox vbox = new VBox(false, 6);

            Label labelHint = new Label(GeneralUtils.GetResourceByName("global_national_catalog_oktru_dialog_hint"))
            {
                Xalign = 0f,
                LineWrap = true
            };
            vbox.PackStart(labelHint, false, false, 0);

            HBox hboxSearch = new HBox(false, 6);
            _entrySearch = new Entry { Text = currentOktru ?? string.Empty };
            Button buttonSearch = new Button(GeneralUtils.GetResourceByName("global_national_catalog_oktru_search"));
            buttonSearch.Clicked += ButtonSearch_Clicked;
            _entrySearch.Activated += delegate { ButtonSearch_Clicked(buttonSearch, EventArgs.Empty); };
            hboxSearch.PackStart(new Label(GeneralUtils.GetResourceByName("widget_generictreeviewsearch_search_label")) { Xalign = 0f }, false, false, 0);
            hboxSearch.PackStart(_entrySearch, true, true, 0);
            hboxSearch.PackStart(buttonSearch, false, false, 0);
            vbox.PackStart(hboxSearch, false, false, 0);

            _labelStatus = new Label(GeneralUtils.GetResourceByName("global_national_catalog_oktru_loading"))
            {
                Xalign = 0f,
                Yalign = 0f,
                LineWrap = true,
                Selectable = true,
                WidthRequest = 680
            };
            ScrolledWindow statusScroll = new ScrolledWindow
            {
                HeightRequest = 90,
                ShadowType = ShadowType.In
            };
            statusScroll.SetPolicy(PolicyType.Automatic, PolicyType.Automatic);
            statusScroll.AddWithViewport(_labelStatus);
            vbox.PackStart(statusScroll, false, false, 0);

            _treeStore = new TreeStore(typeof(string), typeof(string), typeof(string), typeof(bool), typeof(bool));
            _treeView = new TreeView(_treeStore);
            _treeView.HeadersVisible = true;
            _treeView.AppendColumn(CreateColumn(GeneralUtils.GetResourceByName("global_designation"), ColDisplay));
            _treeView.AppendColumn(CreateColumn(GeneralUtils.GetResourceByName("global_national_catalog_oktru"), ColCode));
            _treeView.RowActivated += TreeView_RowActivated;
            _treeView.RowExpanded += TreeView_RowExpanded;
            _treeView.Selection.Changed += TreeViewSelection_Changed;

            ScrolledWindow scrolled = new ScrolledWindow();
            scrolled.SetPolicy(PolicyType.Automatic, PolicyType.Automatic);
            scrolled.Add(_treeView);
            vbox.PackStart(scrolled, true, true, 0);

            VBox.Add(vbox);

            AddButton(GeneralUtils.GetResourceByName("global_button_label_cancel"), ResponseType.Cancel);
            AddButton(GeneralUtils.GetResourceByName("global_button_label_ok"), ResponseType.Ok);
            DefaultResponse = ResponseType.Ok;

            Response += DialogNationalCatalogOktru_Response;

            ShowAll();
            LoadRootsAsync();
        }

        private void DialogNationalCatalogOktru_DeleteEvent(object o, DeleteEventArgs args)
        {
            CaptureSelection();
            args.RetVal = false;
        }

        private void DialogNationalCatalogOktru_Response(object o, ResponseArgs args)
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

            SelectedOktruCode = (_treeStore.GetValue(iter, ColCode) as string)?.Trim();
            SelectedNameRu = (_treeStore.GetValue(iter, ColDisplay) as string)?.Trim();
        }

        private TreeViewColumn CreateColumn(string title, int columnIndex)
        {
            CellRendererText cell = new CellRendererText();
            TreeViewColumn column = new TreeViewColumn(title, cell, "text", columnIndex);
            column.Resizable = true;
            column.SortColumnId = columnIndex;
            return column;
        }

        private void TreeViewSelection_Changed(object sender, EventArgs e)
        {
            CaptureSelection();
        }

        private void TreeView_RowExpanded(object sender, RowExpandedArgs args)
        {
            if (!_alive)
            {
                return;
            }

            TreeIter iter;
            if (!_treeStore.GetIter(out iter, args.Path))
            {
                return;
            }

            if ((bool)_treeStore.GetValue(iter, ColChildrenLoaded))
            {
                return;
            }

            if (_treeStore.IterChildren(out TreeIter child, iter))
            {
                _treeStore.Remove(ref child);
            }

            LoadChildrenAsync(iter);
        }

        private void TreeView_RowActivated(object o, RowActivatedArgs args)
        {
            if (!_alive || _closing)
            {
                return;
            }

            TreeIter iter;
            if (!_treeStore.GetIter(out iter, args.Path))
            {
                return;
            }

            bool hasChildren = (bool)_treeStore.GetValue(iter, ColHasChildren);
            if (hasChildren)
            {
                return;
            }

            CaptureSelection();
            if (string.IsNullOrWhiteSpace(SelectedOktruCode))
            {
                return;
            }

            // Defer Respond so GTK finishes row-activation before closing the dialog.
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

        private void LoadRootsAsync()
        {
            StartAsyncOperation(async token =>
            {
                IReadOnlyList<NktDictionaryItem> roots = await _oktruService.GetRootsAsync(token).ConfigureAwait(false);
                InvokeUi(delegate
                {
                    if (!_alive || token.IsCancellationRequested)
                    {
                        return;
                    }

                    _treeStore.Clear();
                    foreach (NktDictionaryItem item in roots)
                    {
                        AppendItem(null, item);
                    }

                    SetStatusText(string.Format(GeneralUtils.GetResourceByName("global_national_catalog_oktru_loaded"), roots.Count));
                    SelectByCode(_entrySearch.Text?.Trim());
                });
            }, GeneralUtils.GetResourceByName("global_national_catalog_oktru_loading"));
        }

        private void LoadChildrenAsync(TreeIter parentIter)
        {
            string idText = _treeStore.GetValue(parentIter, ColId) as string;
            if (!long.TryParse(idText, out long parentId))
            {
                return;
            }

            if ((bool)_treeStore.GetValue(parentIter, ColChildrenLoaded))
            {
                return;
            }

            _treeStore.SetValue(parentIter, ColChildrenLoaded, true);
            TreePath parentPath = _treeStore.GetPath(parentIter);

            StartAsyncOperation(async token =>
            {
                IReadOnlyList<NktDictionaryItem> children = await _oktruService.GetChildrenAsync(parentId, token).ConfigureAwait(false);
                InvokeUi(delegate
                {
                    if (!_alive || token.IsCancellationRequested)
                    {
                        return;
                    }

                    TreeIter iter;
                    if (!_treeStore.GetIter(out iter, parentPath))
                    {
                        return;
                    }

                    foreach (NktDictionaryItem child in children)
                    {
                        AppendItem(iter, child);
                    }

                    if (children.Count == 0)
                    {
                        _treeStore.SetValue(iter, ColHasChildren, false);
                    }
                });
            });
        }

        private void SearchAsync(string query)
        {
            if (string.IsNullOrWhiteSpace(query))
            {
                LoadRootsAsync();
                return;
            }

            StartAsyncOperation(async token =>
            {
                IReadOnlyList<NktDictionaryItem> results = await _oktruService.SearchAsync(query, token).ConfigureAwait(false);
                InvokeUi(delegate
                {
                    if (!_alive || token.IsCancellationRequested)
                    {
                        return;
                    }

                    _treeStore.Clear();
                    foreach (NktDictionaryItem item in results)
                    {
                        AppendItem(null, item, forceLeaf: true);
                    }

                    SetStatusText(string.Format(GeneralUtils.GetResourceByName("global_national_catalog_oktru_search_result"), results.Count));
                    SelectByCode(query);
                });
            }, GeneralUtils.GetResourceByName("global_national_catalog_oktru_searching"));
        }

        private void AppendItem(TreeIter? parent, NktDictionaryItem item, bool forceLeaf = false)
        {
            if (item == null || !_alive)
            {
                return;
            }

            string code = item.ResolvedCode ?? string.Empty;
            string display = string.IsNullOrWhiteSpace(code)
                ? item.GetDisplayName()
                : string.Format("{0} ({1})", item.GetDisplayName(), code);

            bool hasChildren = !forceLeaf && item.IsExpandable();
            string idText = item.Id.HasValue ? item.Id.Value.ToString() : string.Empty;

            TreeIter iter = parent.HasValue
                ? _treeStore.AppendValues(parent.Value, display, code, idText, false, hasChildren)
                : _treeStore.AppendValues(display, code, idText, false, hasChildren);

            if (hasChildren)
            {
                _treeStore.AppendValues(iter, "…", string.Empty, string.Empty, false, false);
            }
        }

        private void SelectByCode(string code)
        {
            if (string.IsNullOrWhiteSpace(code) || !_alive)
            {
                return;
            }

            TreeIter iter;
            if (_treeStore.GetIterFirst(out iter))
            {
                TrySelectRecursive(iter, code);
            }
        }

        private bool TrySelectRecursive(TreeIter iter, string code)
        {
            do
            {
                string rowCode = _treeStore.GetValue(iter, ColCode) as string;
                if (string.Equals(rowCode, code, StringComparison.OrdinalIgnoreCase))
                {
                    _treeView.Selection.SelectIter(iter);
                    TreePath path = _treeStore.GetPath(iter);
                    _treeView.ScrollToCell(path, null, false, 0, 0);
                    SelectedOktruCode = rowCode;
                    SelectedNameRu = _treeStore.GetValue(iter, ColDisplay) as string;
                    return true;
                }

                if (_treeStore.IterChildren(out TreeIter child, iter))
                {
                    if (TrySelectRecursive(child, code))
                    {
                        return true;
                    }
                }
            }
            while (_treeStore.IterNext(ref iter));

            return false;
        }

        private void StartAsyncOperation(Func<CancellationToken, Task> operation, string statusMessage = null)
        {
            if (!_alive)
            {
                return;
            }

            if (!string.IsNullOrWhiteSpace(statusMessage))
            {
                SetStatusText(statusMessage);
            }

            _loadCts?.Cancel();
            _loadCts = new CancellationTokenSource();
            CancellationToken token = _loadCts.Token;

            Task.Run(async () =>
            {
                try
                {
                    await operation(token).ConfigureAwait(false);
                }
                catch (OperationCanceledException)
                {
                }
                catch (Exception ex)
                {
                    InvokeUi(delegate
                    {
                        if (_alive)
                        {
                            SetStatusText(FormatError(ex));
                        }
                    });
                }
            }, token);
        }

        private void InvokeUi(System.Action action)
        {
            Application.Invoke(delegate
            {
                if (!_alive)
                {
                    return;
                }

                try
                {
                    action();
                }
                catch
                {
                    // Dialog may already be torn down.
                }
            });
        }

        private void SetStatusText(string message)
        {
            if (_labelStatus == null || !_alive)
            {
                return;
            }

            _labelStatus.Text = message ?? string.Empty;
        }

        private static string FormatError(Exception ex)
        {
            if (ex is NationalCatalogApiException)
            {
                return ex.Message;
            }

            if (ex.InnerException is NationalCatalogApiException apiEx)
            {
                return apiEx.Message;
            }

            return ex.Message;
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
