using Gtk;
using logicpos.App;
using logicpos.Classes.Gui.Gtk.Widgets.BackOffice;
using LogicPOS.Data.XPO.Settings;
using LogicPOS.Domain.Entities;
using LogicPOS.Globalization;
using LogicPOS.NationalCatalog;
using LogicPOS.Settings;
using LogicPOS.Utility;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace logicpos.Classes.Gui.Gtk.BackOffice
{
    internal partial class DialogArticle
    {
        private Entry _entryNktOktru;
        private Entry _entryNktNameKk;
        private Entry _entryNktTnved;
        private Entry _entryNktManufacturer;
        private Entry _entryNktQuantity;
        private Label _labelNktStatus;
        private Label _labelNktRequestId;
        private TextView _textViewNktLog;
        private Button _buttonNktSubmit;
        private Button _buttonNktStatus;
        private Button _buttonNktPublish;
        private Button _buttonNktLink;
        private Button _buttonNktDelete;
        private Button _buttonNktReconcile;
        private fin_articlenationalcatalog _nktLink;
        private NationalCatalogService _nktService;
        private CancellationTokenSource _nktOperationCts;

        private bool IsNationalCatalogEnabled()
        {
            if (XPOSettings.ConfigurationSystemCountry == null
                || !string.Equals(XPOSettings.ConfigurationSystemCountry.Code2, "KZ", StringComparison.OrdinalIgnoreCase))
            {
                return false;
            }

            bool enabled = false;
            bool.TryParse(GeneralSettings.Settings["nationalCatalogEnabled"], out enabled);
            string apiKey = GeneralSettings.Settings["nationalCatalogApiKey"];
            return NationalCatalogService.IsConfigured(apiKey, enabled);
        }

        private NationalCatalogService GetNationalCatalogService()
        {
            if (_nktService != null)
            {
                return _nktService;
            }

            string baseUrl = GeneralSettings.Settings["nationalCatalogBaseUrl"] ?? "https://nationalcatalog.kz/gwp";
            string apiKey = GeneralSettings.Settings["nationalCatalogApiKey"];
            _nktService = new NationalCatalogService(baseUrl, apiKey);
            return _nktService;
        }

        private void InitNationalCatalogTab()
        {
            if (!IsNationalCatalogEnabled())
            {
                return;
            }

            try
            {
                fin_article article = _dataSourceRow as fin_article;
                if (article == null)
                {
                    return;
                }

                _nktLink = GetNationalCatalogService().GetLink(article.Session, article);

                VBox vboxNkt = new VBox(false, _boxSpacing) { BorderWidth = (uint)_boxSpacing };

                Label labelHint = new Label(GeneralUtils.GetResourceByName("global_national_catalog_hint"))
                {
                    Xalign = 0f,
                    LineWrap = true
                };
                vboxNkt.PackStart(labelHint, false, false, 0);

                _entryNktOktru = new Entry { Text = _nktLink?.Oktru ?? string.Empty };
                BOWidgetBox boxOktru = new BOWidgetBox(GeneralUtils.GetResourceByName("global_national_catalog_oktru"), _entryNktOktru);

                Button buttonPickOktru = new Button(GeneralUtils.GetResourceByName("global_national_catalog_pick_oktru"));
                buttonPickOktru.Clicked += ButtonPickOktru_Clicked;

                HBox hboxOktru = new HBox(false, _boxSpacing);
                hboxOktru.PackStart(boxOktru, true, true, 0);
                hboxOktru.PackStart(buttonPickOktru, false, false, 0);
                vboxNkt.PackStart(hboxOktru, false, false, 0);

                _entryNktNameKk = new Entry
                {
                    Text = !string.IsNullOrWhiteSpace(_nktLink?.NameKk) ? _nktLink.NameKk : article.Designation ?? string.Empty
                };
                BOWidgetBox boxNameKk = new BOWidgetBox(GeneralUtils.GetResourceByName("global_national_catalog_name_kk"), _entryNktNameKk);
                vboxNkt.PackStart(boxNameKk, false, false, 0);

                string defaultTnved = GeneralSettings.Settings["nationalCatalogDefaultTnved"] ?? string.Empty;
                _entryNktTnved = new Entry
                {
                    Text = !string.IsNullOrWhiteSpace(_nktLink?.Tnved) ? _nktLink.Tnved : defaultTnved
                };
                BOWidgetBox boxTnved = new BOWidgetBox(GeneralUtils.GetResourceByName("global_national_catalog_tnved"), _entryNktTnved);
                Button buttonPickTnved = new Button(GeneralUtils.GetResourceByName("global_national_catalog_pick_tnved"));
                buttonPickTnved.Clicked += ButtonPickTnved_Clicked;
                HBox hboxTnved = new HBox(false, _boxSpacing);
                hboxTnved.PackStart(boxTnved, true, true, 0);
                hboxTnved.PackStart(buttonPickTnved, false, false, 0);
                vboxNkt.PackStart(hboxTnved, false, false, 0);

                string defaultManufacturer = GetDefaultManufacturerName();
                _entryNktManufacturer = new Entry
                {
                    Text = !string.IsNullOrWhiteSpace(_nktLink?.ManufacturerName)
                        ? _nktLink.ManufacturerName
                        : defaultManufacturer
                };
                BOWidgetBox boxManufacturer = new BOWidgetBox(GeneralUtils.GetResourceByName("global_national_catalog_manufacturer"), _entryNktManufacturer);
                vboxNkt.PackStart(boxManufacturer, false, false, 0);

                _entryNktQuantity = new Entry
                {
                    Text = !string.IsNullOrWhiteSpace(_nktLink?.Quantity) ? _nktLink.Quantity : "1"
                };
                BOWidgetBox boxQuantity = new BOWidgetBox(GeneralUtils.GetResourceByName("global_national_catalog_quantity"), _entryNktQuantity);
                vboxNkt.PackStart(boxQuantity, false, false, 0);

                _labelNktStatus = new Label(FormatNktStatusLabel()) { Xalign = 0f };
                vboxNkt.PackStart(_labelNktStatus, false, false, 0);

                _labelNktRequestId = new Label(FormatNktRequestIdLabel()) { Xalign = 0f };
                vboxNkt.PackStart(_labelNktRequestId, false, false, 0);

                HBox hboxRow1 = new HBox(true, _boxSpacing);
                _buttonNktSubmit = new Button(GeneralUtils.GetResourceByName("global_national_catalog_submit"));
                _buttonNktStatus = new Button(GeneralUtils.GetResourceByName("global_national_catalog_refresh_status"));
                _buttonNktSubmit.Clicked += ButtonNktSubmit_Clicked;
                _buttonNktStatus.Clicked += ButtonNktStatus_Clicked;
                hboxRow1.PackStart(_buttonNktSubmit, true, true, 0);
                hboxRow1.PackStart(_buttonNktStatus, true, true, 0);
                vboxNkt.PackStart(hboxRow1, false, false, 0);

                HBox hboxRow2 = new HBox(true, _boxSpacing);
                _buttonNktPublish = new Button(GeneralUtils.GetResourceByName("global_national_catalog_publish"));
                _buttonNktLink = new Button(GeneralUtils.GetResourceByName("global_national_catalog_link"));
                _buttonNktPublish.Clicked += ButtonNktPublish_Clicked;
                _buttonNktLink.Clicked += ButtonNktLink_Clicked;
                hboxRow2.PackStart(_buttonNktPublish, true, true, 0);
                hboxRow2.PackStart(_buttonNktLink, true, true, 0);
                vboxNkt.PackStart(hboxRow2, false, false, 0);

                _buttonNktDelete = new Button(GeneralUtils.GetResourceByName("global_national_catalog_delete_request"));
                _buttonNktDelete.Clicked += ButtonNktDelete_Clicked;
                vboxNkt.PackStart(_buttonNktDelete, false, false, 0);

                _buttonNktReconcile = new Button(GeneralUtils.GetResourceByName("global_national_catalog_reconcile_all"));
                _buttonNktReconcile.Clicked += ButtonNktReconcile_Clicked;
                vboxNkt.PackStart(_buttonNktReconcile, false, false, 0);

                _textViewNktLog = new TextView
                {
                    Editable = false,
                    WrapMode = WrapMode.Word,
                    CursorVisible = false
                };
                _textViewNktLog.ModifyFont(Pango.FontDescription.FromString("Consolas 9"));
                _textViewNktLog.Buffer.Text = GeneralUtils.GetResourceByName("global_national_catalog_log_ready") + Environment.NewLine;

                ScrolledWindow scrolledLog = new ScrolledWindow
                {
                    HeightRequest = 200,
                    ShadowType = ShadowType.In
                };
                scrolledLog.SetPolicy(PolicyType.Automatic, PolicyType.Automatic);
                scrolledLog.Add(_textViewNktLog);
                vboxNkt.PackStart(scrolledLog, true, true, 0);

                _notebook.AppendPage(vboxNkt, new Label(GeneralUtils.GetResourceByName("global_national_catalog_tab")));
            }
            catch (Exception ex)
            {
                _logger.Error(ex.Message, ex);
            }
        }

        private string FormatNktStatusLabel()
        {
            string status = _nktLink?.Status;
            if (string.IsNullOrWhiteSpace(status))
            {
                return GeneralUtils.GetResourceByName("global_national_catalog_status_none");
            }

            return string.Format("{0}: {1}",
                GeneralUtils.GetResourceByName("global_national_catalog_status"),
                status);
        }

        private string FormatNktRequestIdLabel()
        {
            if (_nktLink?.RequestId == null || _nktLink.RequestId.Value <= 0)
            {
                return GeneralUtils.GetResourceByName("global_national_catalog_request_none");
            }

            return string.Format("{0}: {1}",
                GeneralUtils.GetResourceByName("global_national_catalog_request_id"),
                _nktLink.RequestId);
        }

        private void RefreshNktLabels()
        {
            Application.Invoke(delegate
            {
                if (_labelNktStatus != null) _labelNktStatus.Text = FormatNktStatusLabel();
                if (_labelNktRequestId != null) _labelNktRequestId.Text = FormatNktRequestIdLabel();
            });
        }

        private NationalCatalogClient CreateNationalCatalogClientOrShowError()
        {
            string baseUrl = GeneralSettings.Settings["nationalCatalogBaseUrl"] ?? "https://nationalcatalog.kz/gwp";
            string apiKey = GeneralSettings.Settings["nationalCatalogApiKey"];
            if (string.IsNullOrWhiteSpace(apiKey))
            {
                logicpos.Utils.ShowMessageBox(
                    this,
                    DialogFlags.Modal,
                    new System.Drawing.Size(500, 260),
                    MessageType.Warning,
                    ButtonsType.Ok,
                    GeneralUtils.GetResourceByName("global_national_catalog_tab"),
                    GeneralUtils.GetResourceByName("global_national_catalog_api_key_required"));
                return null;
            }

            return new NationalCatalogClient(baseUrl, apiKey);
        }

        private void ButtonPickOktru_Clicked(object sender, EventArgs e)
        {
            try
            {
                NationalCatalogClient client = CreateNationalCatalogClientOrShowError();
                if (client == null)
                {
                    return;
                }

                DialogNationalCatalogOktru dialog = new DialogNationalCatalogOktru(this, client, _entryNktOktru?.Text);
                string selectedOktru = null;
                try
                {
                    ResponseType response = (ResponseType)dialog.Run();
                    if (response == ResponseType.Ok)
                    {
                        selectedOktru = dialog.SelectedOktruCode;
                    }
                }
                finally
                {
                    dialog.Destroy();
                }

                if (string.IsNullOrWhiteSpace(selectedOktru))
                {
                    return;
                }

                _entryNktOktru.Text = selectedOktru.Trim();
                SaveNktFieldsFromForm();
            }
            catch (Exception ex)
            {
                _logger.Error(ex.Message, ex);
                logicpos.Utils.ShowMessageBox(
                    this,
                    DialogFlags.Modal,
                    new System.Drawing.Size(560, 280),
                    MessageType.Error,
                    ButtonsType.Ok,
                    GeneralUtils.GetResourceByName("global_national_catalog_tab"),
                    ex.Message);
            }
        }

        private void ButtonPickTnved_Clicked(object sender, EventArgs e)
        {
            try
            {
                NationalCatalogClient client = CreateNationalCatalogClientOrShowError();
                if (client == null)
                {
                    return;
                }

                fin_article article = _dataSourceRow as fin_article;
                string initialSearch = !string.IsNullOrWhiteSpace(_entryNktTnved?.Text)
                    ? _entryNktTnved.Text
                    : (article?.Designation ?? string.Empty);

                DialogNationalCatalogDictionary dialog = new DialogNationalCatalogDictionary(
                    this,
                    client,
                    "tnved",
                    GeneralUtils.GetResourceByName("global_national_catalog_tnved_dialog_title"),
                    GeneralUtils.GetResourceByName("global_national_catalog_tnved_dialog_hint"),
                    _entryNktTnved?.Text,
                    initialSearch);

                string selectedCode = null;
                try
                {
                    ResponseType response = (ResponseType)dialog.Run();
                    if (response == ResponseType.Ok)
                    {
                        selectedCode = dialog.SelectedCode;
                    }
                }
                finally
                {
                    dialog.Destroy();
                }

                if (string.IsNullOrWhiteSpace(selectedCode))
                {
                    return;
                }

                _entryNktTnved.Text = selectedCode.Trim();
                SaveNktFieldsFromForm();
            }
            catch (Exception ex)
            {
                _logger.Error(ex.Message, ex);
                logicpos.Utils.ShowMessageBox(
                    this,
                    DialogFlags.Modal,
                    new System.Drawing.Size(560, 280),
                    MessageType.Error,
                    ButtonsType.Ok,
                    GeneralUtils.GetResourceByName("global_national_catalog_tab"),
                    ex.Message);
            }
        }

        private fin_articlenationalcatalog EnsureNktLink()
        {
            fin_article article = _dataSourceRow as fin_article;
            if (article == null)
            {
                return null;
            }

            if (_nktLink == null)
            {
                _nktLink = GetNationalCatalogService().GetOrCreateLink(article.Session, article);
            }

            return _nktLink;
        }

        private void SaveNktFieldsFromForm()
        {
            fin_article article = _dataSourceRow as fin_article;
            fin_articlenationalcatalog link = EnsureNktLink();
            if (article == null || link == null)
            {
                return;
            }

            link.Article = article;
            link.Oktru = _entryNktOktru?.Text?.Trim();
            link.NameKk = _entryNktNameKk?.Text?.Trim();
            link.Tnved = _entryNktTnved?.Text?.Trim();
            link.ManufacturerName = !string.IsNullOrWhiteSpace(_entryNktManufacturer?.Text)
                ? _entryNktManufacturer.Text.Trim()
                : GetDefaultManufacturerName();
            if (string.IsNullOrWhiteSpace(link.ManufacturerName))
            {
                link.ManufacturerName = "Не указан";
            }

            link.Quantity = string.IsNullOrWhiteSpace(_entryNktQuantity?.Text) ? "1" : _entryNktQuantity.Text.Trim();

            string barCode = GetWidgetTextValue("BarCode");
            if (!string.IsNullOrWhiteSpace(barCode))
            {
                link.Gtin = NationalCatalogMapper.NormalizeGtin(barCode);
            }
        }

        private static string GetDefaultManufacturerName()
        {
            try
            {
                if (GeneralSettings.PreferenceParameters != null
                    && GeneralSettings.PreferenceParameters.ContainsKey("COMPANY_NAME")
                    && !string.IsNullOrWhiteSpace(GeneralSettings.PreferenceParameters["COMPANY_NAME"]))
                {
                    return GeneralSettings.PreferenceParameters["COMPANY_NAME"].Trim();
                }
            }
            catch
            {
            }

            return string.Empty;
        }

        private void AppendNktLog(string message)
        {
            if (string.IsNullOrWhiteSpace(message))
            {
                return;
            }

            Application.Invoke(delegate
            {
                if (_textViewNktLog == null)
                {
                    return;
                }

                string line = string.Format("[{0:HH:mm:ss}] {1}", DateTime.Now, message.Trim());
                TextBuffer buffer = _textViewNktLog.Buffer;
                buffer.Insert(buffer.EndIter, line + Environment.NewLine);
                _textViewNktLog.ScrollToIter(buffer.EndIter, 0, false, 0, 1);
            });
        }

        private void SetNktButtonsSensitive(bool sensitive)
        {
            Application.Invoke(delegate
            {
                if (_buttonNktSubmit != null) _buttonNktSubmit.Sensitive = sensitive;
                if (_buttonNktStatus != null) _buttonNktStatus.Sensitive = sensitive;
                if (_buttonNktPublish != null) _buttonNktPublish.Sensitive = sensitive;
                if (_buttonNktLink != null) _buttonNktLink.Sensitive = sensitive;
                if (_buttonNktDelete != null) _buttonNktDelete.Sensitive = sensitive;
                if (_buttonNktReconcile != null) _buttonNktReconcile.Sensitive = sensitive;
            });
        }

        private void SwitchToNktTab()
        {
            if (_notebook == null)
            {
                return;
            }

            for (int i = 0; i < _notebook.NPages; i++)
            {
                Widget page = _notebook.GetNthPage(i);
                if (page == null)
                {
                    continue;
                }

                Widget labelWidget = _notebook.GetTabLabel(page);
                if (labelWidget is Label label
                    && label.Text == GeneralUtils.GetResourceByName("global_national_catalog_tab"))
                {
                    _notebook.CurrentPage = i;
                    break;
                }
            }
        }

        private void RunNktOperation(Func<NationalCatalogService, fin_article, fin_articlenationalcatalog, Task<NationalCatalogOperationResult>> operation)
        {
            fin_article article = _dataSourceRow as fin_article;
            if (article == null)
            {
                return;
            }

            SaveNktFieldsFromForm();
            SwitchToNktTab();

            _nktOperationCts?.Cancel();
            _nktOperationCts = new CancellationTokenSource();
            CancellationToken token = _nktOperationCts.Token;

            SetNktButtonsSensitive(false);
            AppendNktLog("---");

            Task.Run(async () =>
            {
                try
                {
                    NationalCatalogService service = GetNationalCatalogService();
                    NationalCatalogOperationResult result = await operation(service, article, _nktLink).ConfigureAwait(false);
                    AppendNktLog(result.Message);
                    RefreshNktLabels();
                }
                catch (Exception ex)
                {
                    AppendNktLog(ex.Message);
                    _logger.Error(ex.Message, ex);
                }
                finally
                {
                    SetNktButtonsSensitive(true);
                }
            }, token);
        }

        private void ButtonNktSubmit_Clicked(object sender, EventArgs e)
        {
            RunNktOperation(async (service, article, link) =>
            {
                link.Save();
                return await service.SubmitRegistrationAsync(
                    article.Session,
                    article,
                    link,
                    autoPublication: false,
                    AppendNktLog,
                    _nktOperationCts.Token).ConfigureAwait(false);
            });
        }

        private void ButtonNktStatus_Clicked(object sender, EventArgs e)
        {
            RunNktOperation(async (service, article, link) =>
            {
                link.Save();
                return await service.RefreshStatusAsync(link, AppendNktLog, _nktOperationCts.Token).ConfigureAwait(false);
            });
        }

        private void ButtonNktPublish_Clicked(object sender, EventArgs e)
        {
            RunNktOperation(async (service, article, link) =>
            {
                link.Save();
                return await service.PublishAsync(link, AppendNktLog, _nktOperationCts.Token).ConfigureAwait(false);
            });
        }

        private void ButtonNktLink_Clicked(object sender, EventArgs e)
        {
            RunNktOperation(async (service, article, link) =>
            {
                link.Save();
                return await service.LinkByGtinAsync(article.Session, article, link, AppendNktLog, _nktOperationCts.Token).ConfigureAwait(false);
            });
        }

        private void ButtonNktDelete_Clicked(object sender, EventArgs e)
        {
            string confirm = GeneralUtils.GetResourceByName("global_national_catalog_delete_confirm");
            ResponseType answer = logicpos.Utils.ShowMessageNonTouch(
                this,
                DialogFlags.DestroyWithParent,
                MessageType.Question,
                ButtonsType.YesNo,
                confirm,
                GeneralUtils.GetResourceByName("global_national_catalog_tab"));

            if (answer != ResponseType.Yes)
            {
                return;
            }

            RunNktOperation(async (service, article, link) =>
            {
                link.Save();
                NationalCatalogOperationResult result = await service.DeleteRequestAsync(
                    link,
                    AppendNktLog,
                    _nktOperationCts.Token).ConfigureAwait(false);
                _nktLink = link;
                return result;
            });
        }

        private void ButtonNktReconcile_Clicked(object sender, EventArgs e)
        {
            fin_article article = _dataSourceRow as fin_article;
            if (article == null)
            {
                return;
            }

            SwitchToNktTab();
            _nktOperationCts?.Cancel();
            _nktOperationCts = new CancellationTokenSource();
            SetNktButtonsSensitive(false);
            AppendNktLog(GeneralUtils.GetResourceByName("global_national_catalog_reconcile_started"));

            Task.Run(async () =>
            {
                try
                {
                    NationalCatalogOperationResult result = await GetNationalCatalogService()
                        .ReconcileAllAsync(article.Session, AppendNktLog, _nktOperationCts.Token)
                        .ConfigureAwait(false);
                    AppendNktLog(result.Message);
                    _nktLink = GetNationalCatalogService().GetLink(article.Session, article) ?? _nktLink;
                    RefreshNktLabels();
                }
                catch (Exception ex)
                {
                    AppendNktLog(ex.Message);
                    _logger.Error(ex.Message, ex);
                }
                finally
                {
                    SetNktButtonsSensitive(true);
                }
            });
        }

        protected override void OnResponse(ResponseType pResponse)
        {
            if (IsNationalCatalogEnabled() && (pResponse == ResponseType.Ok || pResponse == ResponseType.Apply))
            {
                try
                {
                    SaveNktFieldsFromForm();
                    _nktLink?.Save();
                }
                catch (Exception ex)
                {
                    _logger.Error(ex.Message, ex);
                }
            }

            base.OnResponse(pResponse);
        }
    }
}
