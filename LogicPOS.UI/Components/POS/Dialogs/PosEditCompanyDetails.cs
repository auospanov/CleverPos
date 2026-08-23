using DevExpress.Data.Filtering;
using DevExpress.Xpo;
using DevExpress.Xpo.DB;
using Gtk;
using logicpos.App;
using logicpos.Classes.Enums.Keyboard;
using logicpos.Classes.Gui.Gtk.BackOffice;
using logicpos.Classes.Gui.Gtk.Widgets;
using logicpos.Classes.Gui.Gtk.Widgets.Buttons;
using logicpos.Classes.Gui.Gtk.WidgetsXPO;
using LogicPOS.Data.XPO.Settings;
using LogicPOS.Data.XPO.Utility;
using LogicPOS.Domain.Entities;
using LogicPOS.Finance.Utility;
using LogicPOS.Globalization;
using LogicPOS.Settings;
using LogicPOS.Utility;
using System;
using System.Collections.Generic;
using System.Drawing;

namespace logicpos.Classes.Gui.Gtk.Pos.Dialogs
{
    internal class PosEditCompanyDetails : PosBaseDialog
    {
        //Private UI
        private readonly TouchButtonIconWithText _buttonOk;
        private readonly TouchButtonIconWithText _buttonDataDemo;
        private ScrolledWindow _scrolledWindow;
        private EntryBoxValidation _entryBoxFiscalNumber;
        private EntryBoxValidation _entryBoxZipCode;
        private XPOEntryBoxSelectRecordValidation<cfg_configurationcountry, TreeViewConfigurationCountry> _entryBoxSelectSystemCountry;
        private XPOEntryBoxSelectRecordValidation<cfg_configurationcurrency, TreeViewConfigurationCurrency> _entryBoxSelectSystemCurrency;
        //Non UI
        private Dictionary<cfg_configurationpreferenceparameter, EntryBoxValidation> _dictionaryObjectBag;

        public PosEditCompanyDetails(Window pSourceWindow, DialogFlags pDialogFlags, bool useDataDemo)
            : base(pSourceWindow, pDialogFlags, true, false)
        {
            //Init Local Vars
            string windowTitle = GeneralUtils.GetResourceByName("window_title_edit_configurationpreferenceparameter");
            Size windowSize = new Size(600, 600);
            string fileDefaultWindowIcon = PathsSettings.ImagesFolderLocation + @"Icons\Windows\icon_window_system.png";

            //References
            _sourceWindow = pSourceWindow;

            //ActionArea Buttons
            _buttonOk = new TouchButtonIconWithText("touchButtonOk_DialogActionArea", _colorBaseDialogActionAreaButtonBackground, GeneralUtils.GetResourceByName("global_button_label_ok"), _fontBaseDialogActionAreaButton, _colorBaseDialogActionAreaButtonFont, _fileActionOK, _sizeBaseDialogActionAreaButtonIcon, _sizeBaseDialogActionAreaButton.Width, _sizeBaseDialogActionAreaButton.Height) { Sensitive = false };
            _buttonDataDemo = new TouchButtonIconWithText("touchButtonDataDemo_DialogActionArea", _colorBaseDialogActionAreaButtonBackground, "Demo", _fontBaseDialogActionAreaButton, _colorBaseDialogActionAreaButtonFont, _fileDemoData, _sizeBaseDialogActionAreaButtonIcon, _sizeBaseDialogActionAreaButton.Width, _sizeBaseDialogActionAreaButton.Height) { Sensitive = true };

            //ActionArea
            ActionAreaButtons actionAreaButtons = new ActionAreaButtons
            {
                new ActionAreaButton(_buttonDataDemo, ResponseType.Apply),
                new ActionAreaButton(_buttonOk, ResponseType.Ok)
            };

            //Init Content
            InitUI(useDataDemo);

            //Start Validated
            Validate();

            //Init Object
            this.InitObject(this, pDialogFlags, fileDefaultWindowIcon, windowTitle, windowSize, _scrolledWindow, actionAreaButtons);

            //Set Focus to Window, To Hide Keyboard: Only Used if First SelectionBox are Hiden
            //this.GrabFocus();
        }

        private void InitUI(bool useDataDemo)
        {
            //Get Values from Config
            Guid systemCountry;
            Guid systemCurrency;
            //bool debug = false;
            bool useDatabaseDataDemo = Convert.ToBoolean(GeneralSettings.Settings["useDatabaseDataDemo"]);

            if (GeneralSettings.Settings["xpoOidConfigurationCountrySystemCountry"] != string.Empty)
            {
                systemCountry = new Guid(GeneralSettings.Settings["xpoOidConfigurationCountrySystemCountry"]);
            }
            else
            {
                systemCountry = CultureSettings.KazakhstanCountryId;
            }

            if (GeneralSettings.Settings["xpoOidConfigurationCurrencySystemCurrency"] != string.Empty)
            {
                systemCurrency = new Guid(GeneralSettings.Settings["xpoOidConfigurationCurrencySystemCurrency"]);
            }
            else
            {
                systemCurrency = CultureSettings.TengeCurrencyId;
            }

            //Init Inital Values (config OID may be missing in DB until seed/migration is applied)
            cfg_configurationcountry intialValueConfigurationCountry = ResolveInitialCountry(systemCountry);
            cfg_configurationcurrency intialValueConfigurationCurrency = ResolveInitialCurrency(
                systemCurrency, intialValueConfigurationCountry);

            try
            {
                //Init dictionary for Parameters + Widgets
                _dictionaryObjectBag = new Dictionary<cfg_configurationpreferenceparameter, EntryBoxValidation>();

                //Pack VBOX
                VBox vbox = new VBox(true, 2) { WidthRequest = 300 };

                //Country
                CriteriaOperator criteriaOperatorSystemCountry = CriteriaOperator.Parse("(Disabled IS NULL OR Disabled  <> 1) AND (RegExFiscalNumber IS NOT NULL)");
                _entryBoxSelectSystemCountry = new XPOEntryBoxSelectRecordValidation<cfg_configurationcountry, TreeViewConfigurationCountry>(this, GeneralUtils.GetResourceByName("global_country"), "Designation", "Oid", intialValueConfigurationCountry, criteriaOperatorSystemCountry, RegexUtils.RegexGuid, true);
                _entryBoxSelectSystemCountry.EntryValidation.IsEditable = false;
                if (_entryBoxSelectSystemCountry.Value != null)
                    _entryBoxSelectSystemCountry.EntryValidation.Validate(_entryBoxSelectSystemCountry.Value.Oid.ToString());
                //Disabled, Now Country and Currency are disabled
                _entryBoxSelectSystemCountry.ButtonSelectValue.Sensitive = true;
                _entryBoxSelectSystemCountry.EntryValidation.Sensitive = true;
                _entryBoxSelectSystemCountry.ClosePopup += delegate
                {
                    ////Require to Update RegEx
                    _entryBoxZipCode.EntryValidation.Rule = _entryBoxSelectSystemCountry.Value.RegExZipCode;
                    _entryBoxZipCode.EntryValidation.Validate();
                    //Require to Update RegEx and Criteria to filter Country Clients Only
                    _entryBoxFiscalNumber.EntryValidation.Rule = _entryBoxSelectSystemCountry.Value.RegExFiscalNumber;
                    _entryBoxFiscalNumber.EntryValidation.Validate();
                    if (_entryBoxFiscalNumber.EntryValidation.Validated)
                    {
                        bool isValidFiscalNumber = FiscalNumberUtils.IsValidFiscalNumber(_entryBoxFiscalNumber.EntryValidation.Text, _entryBoxSelectSystemCountry.Value.Code2);
                        _entryBoxFiscalNumber.EntryValidation.Validated = isValidFiscalNumber;
                    }
                    //Call Main Validate
                    Validate();
                };

                //Currency
                CriteriaOperator criteriaOperatorSystemCurrency = CriteriaOperator.Parse("(Disabled IS NULL OR Disabled  <> 1)");
                _entryBoxSelectSystemCurrency = new XPOEntryBoxSelectRecordValidation<cfg_configurationcurrency, TreeViewConfigurationCurrency>(this, GeneralUtils.GetResourceByName("global_currency"), "Designation", "Oid", intialValueConfigurationCurrency, criteriaOperatorSystemCurrency, RegexUtils.RegexGuid, true);
                _entryBoxSelectSystemCurrency.EntryValidation.IsEditable = false;
                if (_entryBoxSelectSystemCurrency.Value != null)
                    _entryBoxSelectSystemCurrency.EntryValidation.Validate(_entryBoxSelectSystemCurrency.Value.Oid.ToString());

                //Disabled, Now Country and Currency are disabled
                //_entryBoxSelectSystemCurrency.ButtonSelectValue.Sensitive = false;
                //_entryBoxSelectSystemCurrency.EntryValidation.Sensitive = false;
                _entryBoxSelectSystemCurrency.ClosePopup += delegate
                {
                    //Call Main Validate
                    Validate();
                };

                //Add to Vbox
                vbox.PackStart(_entryBoxSelectSystemCountry, true, true, 0);
                vbox.PackStart(_entryBoxSelectSystemCurrency, true, true, 0);

                //Start Render Dynamic Inputs
                CriteriaOperator criteriaOperator = CriteriaOperator.Parse("(Disabled = 0 OR Disabled is NULL) AND (FormType = 1 AND FormPageNo = 1)");
                SortProperty[] sortProperty = new SortProperty[2];
                sortProperty[0] = new SortProperty("Ord", SortingDirection.Ascending);
                XPCollection xpCollection = new XPCollection(XPOSettings.Session, typeof(cfg_configurationpreferenceparameter), criteriaOperator, sortProperty);
                if (xpCollection.Count > 0)
                {
                    string label = string.Empty;
                    string regEx = string.Empty;
                    object regExObj = null;
                    bool required = false;

                    foreach (cfg_configurationpreferenceparameter item in xpCollection)
                    {
                        label = (item.ResourceString != null && CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, item.ResourceString) != null)
                            ? CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, item.ResourceString)
                            : string.Empty;
                        regExObj = GeneralUtils.GetFieldValueFromType(typeof(POSSettings), item.RegEx);
                        regEx = (regExObj != null) ? regExObj.ToString() : string.Empty;
                        required = Convert.ToBoolean(item.Required);

                        //Override Db Regex
                        if (item.Token == "COMPANY_POSTALCODE") regEx = _entryBoxSelectSystemCountry.Value.RegExZipCode;
                        if (item.Token == "COMPANY_FISCALNUMBER") regEx = _entryBoxSelectSystemCountry.Value.RegExFiscalNumber;
                        //IN009295 Start POS - Capital Social com valor por defeito
                        if (item.Token == "COMPANY_STOCK_CAPITAL") item.Value = "1";
                        //Debug
                        //_logger.Debug(string.Format("Label: [{0}], RegEx: [{1}], Required: [{2}]", label, regEx, required));

                        EntryBoxValidation entryBoxValidation = new EntryBoxValidation(
                            this,
                            label,
                            KeyboardMode.AlfaNumeric,
                            regEx,
                            required
                        )
                        { Name = item.Token };

                        //Use demo data to fill values
                        if (useDataDemo)
                        {
                            if (item.Token == "COMPANY_NAME") { entryBoxValidation.EntryValidation.Text = "ARO Technologies, LTD (ТОО \"ARO Technologies\")"; }
                            if (item.Token == "COMPANY_BUSINESS_NAME") { entryBoxValidation.EntryValidation.Text = string.Empty; }
                            if (item.Token == "COMPANY_ADDRESS") { entryBoxValidation.EntryValidation.Text = string.Empty; }
                            if (item.Token == "COMPANY_CITY") { entryBoxValidation.EntryValidation.Text = "Астана"; }
                            if (item.Token == "COMPANY_POSTALCODE") { entryBoxValidation.EntryValidation.Text = "010000"; }
                            if (item.Token == "COMPANY_COUNTRY") { entryBoxValidation.EntryValidation.Text = "Казахстан"; }
                            if (item.Token == "COMPANY_FISCALNUMBER") { entryBoxValidation.EntryValidation.Text = "999999990"; }
                            if (item.Token == "COMPANY_STOCK_CAPITAL") { entryBoxValidation.EntryValidation.Text = "1000"; }
                            if (item.Token == "COMPANY_EMAIL") { entryBoxValidation.EntryValidation.Text = "helpdesk@arotech.kz"; }
                            if (item.Token == "COMPANY_WEBSITE") { entryBoxValidation.EntryValidation.Text = "arotech.kz"; }
                        }

                        //Only Assign Value if Debugger Attached: Now the value for normal user is cleaned in Init Database, we keep this code here, may be usefull
                        //if (Debugger.IsAttached == true || useDatabaseDataDemo && !useDataDemo) { entryBoxValidation.EntryValidation.Text = item.Value; }
                        //if (Debugger.IsAttached == true)
                        //{
                        //    if (debug) _logger.Debug(String.Format("[{0}:{1}]:item.Value: [{2}], entryBoxValidation.EntryValidation.Text: [{3}]", Debugger.IsAttached == true, useDatabaseDataDemo, item.Value, entryBoxValidation.EntryValidation.Text));
                        //}

                        //Assign shared Event
                        entryBoxValidation.EntryValidation.Changed += EntryValidation_Changed;

                        //If is ZipCode Assign it to _entryBoxZipCode Reference
                        if (item.Token == "COMPANY_POSTALCODE")
                        {
                            _entryBoxZipCode = entryBoxValidation;
                            _entryBoxZipCode.EntryValidation.Rule = _entryBoxSelectSystemCountry.Value.RegExZipCode;
                        }
                        //If is FiscalNumber Assign it to entryBoxSelectCustomerFiscalNumber Reference
                        else if (item.Token == "COMPANY_FISCALNUMBER")
                        {
                            _entryBoxFiscalNumber = entryBoxValidation;
                            _entryBoxFiscalNumber.EntryValidation.Rule = _entryBoxSelectSystemCountry.Value.RegExFiscalNumber;
                        }

                        if (item.Token == "COMPANY_TAX_ENTITY") entryBoxValidation.EntryValidation.Text = "Global";

                        //Call Validate
                        entryBoxValidation.EntryValidation.Validate();
                        //Pack and Add to ObjectBag
                        vbox.PackStart(entryBoxValidation, true, true, 0);
                        _dictionaryObjectBag.Add(item, entryBoxValidation);
                    }
                }

                Viewport viewport = new Viewport() { ShadowType = ShadowType.None };
                viewport.Add(vbox);

                _scrolledWindow = new ScrolledWindow();
                _scrolledWindow.ShadowType = ShadowType.EtchedIn;
                _scrolledWindow.SetPolicy(PolicyType.Automatic, PolicyType.Automatic);
                _scrolledWindow.Add(viewport);

                viewport.ResizeMode = ResizeMode.Parent;
                _scrolledWindow.ResizeMode = ResizeMode.Parent;
            }
            catch (Exception ex)
            {
                _logger.Error(ex.Message, ex);
            }
        }

        private void EntryValidation_Changed(object sender, EventArgs e)
        {
            try
            {
                EntryBoxValidation input = ((sender as ValidatableTextBox).Parent.Parent.Parent as EntryBoxValidation);

                input.EntryValidation.Validate();

                if (input.EntryValidation.Validated && input.Name == "COMPANY_FISCALNUMBER")
                {
                    bool isValidFiscalNumber = FiscalNumberUtils.IsValidFiscalNumber(input.EntryValidation.Text, _entryBoxSelectSystemCountry.Value.Code2);
                    input.EntryValidation.Validated = isValidFiscalNumber;
                }
                Validate();
            }
            catch (Exception ex)
            {
                _logger.Error(ex.Message, ex);
            }
        }

        private void Validate()
        {
            try
            {
                bool validated = true;
                foreach (var item in _dictionaryObjectBag)
                {
                    if (!item.Value.EntryValidation.Validated) validated = false;
                }
                _buttonOk.Sensitive = validated;
            }
            catch (Exception ex)
            {
                _logger.Error(ex.Message, ex);
            }
        }

        protected override void OnResponse(ResponseType pResponse)
        {
            try
            {
                if (pResponse == ResponseType.Ok)
                {
                    bool changed = false;

                    foreach (var item in _dictionaryObjectBag)
                    {
                        changed = logicpos.Utils.CheckIfFieldChanged(item.Key.Value, item.Value.EntryValidation.Text);
                        //_logger.Debug(string.Format("FieldDb:[{0}], FieldInput:[{1}], changed: [{2}]", item.Key.Value, item.Value.EntryValidation.Text, changed));
                        if (changed)
                        {
                            item.Key.Value = item.Value.EntryValidation.Text;
                            item.Key.Save();
                        }
                    }

                    //entryBoxSelect: COMPANY_COUNTRY
                    //Assign and Save Country and Country Code 2 From entryBoxSelectCustomerCountry
                    cfg_configurationpreferenceparameter configurationPreferenceParameterCompanyCountry = (XPOUtility.GetXPGuidObjectFromCriteria(typeof(cfg_configurationpreferenceparameter), string.Format("(Disabled IS NULL OR Disabled  <> 1) AND (Token = '{0}')", "COMPANY_COUNTRY")) as cfg_configurationpreferenceparameter);
                    configurationPreferenceParameterCompanyCountry.Value = _entryBoxSelectSystemCountry.Value.Designation;
                    configurationPreferenceParameterCompanyCountry.Save();
                    //entryBoxSelect: COMPANY_COUNTRY_CODE2
                    cfg_configurationpreferenceparameter configurationPreferenceParameterCompanyCountryCode2 = (XPOUtility.GetXPGuidObjectFromCriteria(typeof(cfg_configurationpreferenceparameter), string.Format("(Disabled IS NULL OR Disabled  <> 1) AND (Token = '{0}')", "COMPANY_COUNTRY_CODE2")) as cfg_configurationpreferenceparameter);
                    configurationPreferenceParameterCompanyCountryCode2.Value = _entryBoxSelectSystemCountry.Value.Code2;
                    configurationPreferenceParameterCompanyCountryCode2.Save();
                    //entryBoxSelect: SYSTEM_CURRENCY
                    cfg_configurationpreferenceparameter configurationPreferenceParameterSystemCurrency = (XPOUtility.GetXPGuidObjectFromCriteria(typeof(cfg_configurationpreferenceparameter), string.Format("(Disabled IS NULL OR Disabled  <> 1) AND (Token = '{0}')", "SYSTEM_CURRENCY")) as cfg_configurationpreferenceparameter);
                    configurationPreferenceParameterSystemCurrency.Value = _entryBoxSelectSystemCurrency.Value.Acronym;
                    configurationPreferenceParameterSystemCurrency.Save();
                    //entryBoxSelect: COMPANY_COUNTRY_OID
                    cfg_configurationpreferenceparameter configurationPreferenceParameterCompanyCountryOid = (XPOUtility.GetXPGuidObjectFromCriteria(typeof(cfg_configurationpreferenceparameter), string.Format("(Disabled IS NULL OR Disabled  <> 1) AND (Token = '{0}')", "COMPANY_COUNTRY_OID")) as cfg_configurationpreferenceparameter);
                    configurationPreferenceParameterCompanyCountryOid.Value = _entryBoxSelectSystemCountry.Value.Oid.ToString();
                    configurationPreferenceParameterCompanyCountryOid.Save();
                    //entryBoxSelect: SYSTEM_CURRENCY_OID
                    cfg_configurationpreferenceparameter configurationPreferenceParameterSystemCurrencyOid = (XPOUtility.GetXPGuidObjectFromCriteria(typeof(cfg_configurationpreferenceparameter), string.Format("(Disabled IS NULL OR Disabled  <> 1) AND (Token = '{0}')", "SYSTEM_CURRENCY_OID")) as cfg_configurationpreferenceparameter);
                    configurationPreferenceParameterSystemCurrencyOid.Value = _entryBoxSelectSystemCurrency.Value.Oid.ToString();
                    configurationPreferenceParameterSystemCurrencyOid.Save();

                    //Proccess Country Scripts
                    string commandSeparator = ";";
                    Dictionary<string, string> replaceables = logicpos.DataLayer.GetReplaceables(DatabaseSettings.DatabaseType);
                    string directoryCountry = string.Format(@"{0}/{1}", POSSettings.FileDatabaseOtherCommonCountry, _entryBoxSelectSystemCountry.Value.Code2);
                    logicpos.DataLayer.ProcessDumpDirectory(XPOSettings.Session, directoryCountry, commandSeparator, replaceables);
                    //Proccess Country Plugin Scripts
                    directoryCountry = string.Format(@"{0}/{1}", POSSettings.FileDatabaseOtherCommonPluginsSoftwareVendorOtherCommonCountry, _entryBoxSelectSystemCountry.Value.Code2);
                    logicpos.DataLayer.ProcessDumpDirectory(XPOSettings.Session, directoryCountry, commandSeparator, replaceables);

                    //Change Configuration : Currently only working outside Debugger, to prevent errors changing config with VS using app.config 
                    //System.ArgumentException: O nome de ficheiro 'c:\svn\logicpos\trunk\src\logicpos\bin\debug\logicpos.exe.config' é inválido porque o mesmo nome de ficheiro já é referido pela hierarquia de configuração aberta
                    Dictionary<string, string> configurationValues = new Dictionary<string, string>
                    {
                        { "xpoOidConfigurationCountrySystemCountry", _entryBoxSelectSystemCountry.Value.Oid.ToString() },
                        { "xpoOidConfigurationCountrySystemCountryCountryCode2", _entryBoxSelectSystemCountry.Value.Code2 },
                        { "xpoOidConfigurationCurrencySystemCurrency", _entryBoxSelectSystemCurrency.Value.Oid.ToString() }
                    };
                    logicpos.Utils.AddUpdateSettings(configurationValues);

                    //Require to assign to SettingsApp Singleton : Now Working in InitPlataformParameters() to prevent save to config catch and this code is never be executed
                    //SettingsApp.ConfigurationSystemCountry = _entryBoxSelectSystemCountry.Value;
                    //SettingsApp.ConfigurationSystemCurrency = _entryBoxSelectSystemCurrency.Value;

                    //UNDER CONSTRUCTION
                    //Call SaveSystemProtection() Here
                    //Utils.SaveSystemProtection();
                }
                else if (pResponse == ResponseType.Apply)
                {
                    this.Destroy();
                    PosEditCompanyDetails dialog = new PosEditCompanyDetails(this, DialogFlags.DestroyWithParent | DialogFlags.Modal, true);
                    ResponseType response = (ResponseType)dialog.Run();
                    dialog.Destroy();
                }
                else
                {
                    //Prevent ESC
                    this.Run();
                }
            }
            catch (Exception ex)
            {
                // This Error Occurs only id Debugger is Attached
                _logger.Error(ex.Message, ex);
            }
        }

        private static cfg_configurationcountry ResolveInitialCountry(Guid preferredOid)
        {
            cfg_configurationcountry entity = XPOUtility.GetEntityById<cfg_configurationcountry>(preferredOid);
            if (entity != null)
                return entity;

            string code2 = GeneralSettings.Settings["xpoOidConfigurationCountrySystemCountryCountryCode2"];
            if (!string.IsNullOrWhiteSpace(code2))
            {
                Guid oid = XPOUtility.GetGuidFromQuery(
                    string.Format("SELECT Oid FROM cfg_configurationcountry WHERE Code2 = '{0}';", code2));
                if (oid != Guid.Empty)
                {
                    entity = XPOUtility.GetEntityById<cfg_configurationcountry>(oid);
                    if (entity != null)
                        return entity;
                }
            }

            entity = XPOUtility.GetEntityById<cfg_configurationcountry>(CultureSettings.KazakhstanCountryId);
            if (entity != null)
                return entity;

            entity = XPOUtility.GetEntityById<cfg_configurationcountry>(CultureSettings.PortugalCountryId);
            if (entity != null)
                return entity;

            Guid fallbackOid = XPOUtility.GetGuidFromQuery(
                "SELECT Oid FROM cfg_configurationcountry WHERE (Disabled IS NULL OR Disabled <> 1) AND RegExFiscalNumber IS NOT NULL ORDER BY Ord LIMIT 1;");
            return fallbackOid != Guid.Empty
                ? XPOUtility.GetEntityById<cfg_configurationcountry>(fallbackOid)
                : null;
        }

        private static cfg_configurationcurrency ResolveInitialCurrency(
            Guid preferredOid, cfg_configurationcountry country)
        {
            if (country != null && string.Equals(country.Code2, "KZ", StringComparison.OrdinalIgnoreCase))
            {
                cfg_configurationcurrency kzt = GetCurrencyByAcronym("KZT");
                if (kzt != null)
                    return kzt;
            }

            cfg_configurationcurrency entity = XPOUtility.GetEntityById<cfg_configurationcurrency>(preferredOid);
            if (entity != null)
                return entity;

            entity = GetCurrencyByAcronym("KZT");
            if (entity != null)
                return entity;

            entity = XPOUtility.GetEntityById<cfg_configurationcurrency>(CultureSettings.EuroCurrencyId);
            if (entity != null)
                return entity;

            Guid fallbackOid = XPOUtility.GetGuidFromQuery(
                "SELECT Oid FROM cfg_configurationcurrency WHERE (Disabled IS NULL OR Disabled <> 1) ORDER BY Ord LIMIT 1;");
            return fallbackOid != Guid.Empty
                ? XPOUtility.GetEntityById<cfg_configurationcurrency>(fallbackOid)
                : null;
        }

        private static cfg_configurationcurrency GetCurrencyByAcronym(string acronym)
        {
            Guid oid = XPOUtility.GetGuidFromQuery(
                string.Format("SELECT Oid FROM cfg_configurationcurrency WHERE Acronym = '{0}';", acronym));
            return oid != Guid.Empty
                ? XPOUtility.GetEntityById<cfg_configurationcurrency>(oid)
                : null;
        }
    }
}
