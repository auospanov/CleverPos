using LogicPOS.Settings;
using System;
using System.Collections.Generic;
using System.IO;

namespace logicpos.App
{
    public static class POSSettings 
    {
    
        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        //Developer

        // To Override Database add <add key="databaseName" value="logicposdbtest" /> to .config

#if (DEBUG)
        //Used to Force/Override Intellilock assigned GlobalFramework.LicenceRegistered in BootStrap
        public static bool LicenceRegistered = true;
        //Valid databaseType Values: SQLite, MySql, MSSqlServer (DBName Must be lowercase)
        public static string DatabaseName = "logicposdbdevelopment";
        //Used to Force create DatabaseSchema and Fixtures with XPO (Non Script Mode): Requirements for Work: Empty or Non Exist Database
        //Notes: OnError "An exception of type 'DevExpress.Xpo.DB.Exceptions.SchemaCorrectionNeededException'", UnCheck [X] Break when this exception is user-unhandled and continue, watch log and wait until sucefull message appear
        public static bool XPOCreateDatabaseAndSchema = false;
        //Use file based Protected Files
        public static bool ProtectedFilesUse = false;
        //Used to Recreate Protection File, based on ProtectedFilesList | the files must be in bin folder, else dont be generated (File.Exist)
        public static bool ProtectedFilesRecreateCSV = false;
        //Used to develop reports or tickets, to permit changes in debug mode, ex design reports without check permissions
        public static bool ProtectedFilesIgnoreProtection = false;
        //Used to Work in DEBUG Mode and Fake Hardware ID, Must be UNIQUE for Terminals
        //TIP: Must be changed if Work in Multi User Database Environments, else all Terminals act like there is only one Terminal
        //Disable > public static string AppHardwareId = null;
        public static string AppHardwareId = "92A4-EADD-8AF0-B693-DBD0-2A22";
#else
        public static bool LicenceRegistered = true;
        public static string DatabaseName = "logicposdb";
        public static bool ProtectedFilesIgnoreProtection = true;
        public static bool XPOCreateDatabaseAndSchema = false;
        public static bool ProtectedFilesUse = false;
        public static bool ProtectedFilesRecreateCSV = false;
        public static string AppHardwareId = string.Empty;
#endif

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        //Application

        public static string AppName = "CleverPos";
        public static string AppIcon = "application.ico";
        public static string AppUrl = "www.logicpulse.com";

        //Custom licence, Outside of Config, if exist use it overriding intelilock mechanism
        public static string LicenceFileName = "licence.lic";
        //Override Intellilock HardWareId Method : Old Method Commented, not Used Anymore
        //public static string AppTerminalIdConfigFile = "terminal.id";
        //DEBUG and OPTIONAL - CAN BE COMMENTED to use DEFAULT ####-####-####-####-####-#### 

        //Executables
        public static string ExecutableComposer = "logicpos.composer.exe";
        public static string ExecutableReports = "logicpos.reports.exe";

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        //Override Settings

        public static bool EnablePosSessionApp = true;
        public static bool EnablePosWorkSessionPeriod = true;
        public static bool EnablePosTables = true;

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        //ProtectedFiles

        //Protected Files Settings
        public static string ProtectedFilesFileName = "logicpos.exe.files";
        public static List<string> ProtectedFilesList { get { return GetProtectedFilesList(); } }

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        //DataBase Backup System

        /* ERR201810#15 - Database backup issues */
        public static uint BackupTimerInterval = 1000 * 60;
        public static string BackupExtension = "bak";

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        //Formats

        //Dont change This, Required to use . in many things like SAF-T etc
        public static string CultureNumberFormat = "en-US";

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        //Files/File Formats

        //DataBase Backup File Format : {databasetype}_{databasename}_{version}_{date}.{extension}
        public static string FileFormatDataBaseBackup = "{0}_{1}_{2}_{3}.{4}";

        //Theme File Format : ex.: {theme}_{default}_{default}_{1024}x{768}.xml (LOWERCASE) - {0}: appTheme, {1}: appOperationModeToken, {2}: Width, {3}: Height
        //private static string FileFormatThemeFile = "theme_{0}_{1}_{2}x{3}.xml";//Deprecated
        private static readonly string FileFormatThemeFile = "theme_{0}_{1}.xml";
        public static string FileTheme { get { return GetFileTheme(); } }

        //Database Script Files
        public static string FileDatabaseSchema = @"Resources\Database\{0}\databaseschema.sql";

        public static string FileDatabaseUpdate = @"Resources\Database\{0}\databaseschemaupdate.sql";

        /* IN009035 */
        public static string FileDatabaseDataPath = @"Resources\Database\Data\{0}\{1}\databasedata.sql"; // "Resources\Database\Data\Default\en\databasedata.sql"
        public static string FileDatabaseData => GetDatabaseFileName(false, FileDatabaseDataPath);
        /* IN008024 */
        public static string FileDatabaseDataDemoPath = @"Resources\Database\Demos\{0}\{1}\{2}"; // "Resources\Database\Demos\Backery\en\databasedatademo_backery.sql"
        public static string FileDatabaseDataDemo => GetDatabaseFileName(true, FileDatabaseDataDemoPath);

        public static string FileDatabaseViews = @"Resources\Database\databaseviews.sql";
        // public static string FileDatabaseOtherDatabaseType = @"Resources\Database\{0}\Other\";/* IN009045: Not in use */
        public static string FileDatabaseOtherCommon = @"Resources\Database\Other\";
        /* IN009035: data being included by databasedata.sql accordingly to its specific theme/language */
        // public static string FileDatabaseOtherCommonAppMode = @"Resources\Database\Other\AppMode";
        //Encrypted Scripts
        /* IN009035 */
        public static string FileDatabaseOtherCommonPluginsSoftwareVendorPath = @"Resources\Database\Other\Plugins\SoftwareVendor\Data\{0}\{1}"; // "Resources\Database\Other\Plugins\SoftwareVendor\Data\Default\en"
        public static string FileDatabaseOtherCommonPluginsSoftwareVendor => GetDatabaseFileName(false, FileDatabaseOtherCommonPluginsSoftwareVendorPath);

        //Country Scripts
        public static string FileDatabaseOtherCommonCountry = @"Resources\Database\Other\Country";
        //Country Encrypted Scripts
        public static string FileDatabaseOtherCommonPluginsSoftwareVendorOtherCommonCountry = @"Resources\Database\Other\Plugins\SoftwareVendor\Other\Country";

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        //User Config Oids - Values in Config, Proxy here to always use SettingsApp.VAR in Code

        //Database Oids/Guids

        //Payment Defaults
        public static Guid XpoOidConfigurationPaymentConditionDefaultInvoicePaymentCondition = new Guid(GeneralSettings.Settings["xpoOidConfigurationPaymentConditionDefaultInvoicePaymentCondition"]);
        public static Guid XpoOidConfigurationPaymentMethodDefaultInvoicePaymentMethod = new Guid(GeneralSettings.Settings["xpoOidConfigurationPaymentMethodDefaultInvoicePaymentMethod"]);

        //ConfigurationPlaceTable
        public static Guid XpoOidConfigurationPlaceTableDefaultOpenTable = new Guid(GeneralSettings.Settings["xpoOidConfigurationPlaceTableDefaultOpenTable"]);

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        // Other

        //Privileges {table} Prefix
        public static string PrivilegesBackOfficeCRUDOperationPrefix = "BACKOFFICE_MAN_{0}";
        public static string PrivilegesBackOfficeMenuOperationFormat = string.Format("{0}_{1}", PrivilegesBackOfficeCRUDOperationPrefix, "MENU");
        public static string PrivilegesReportDialogFormat = "{0}";

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        //AT Web Services

        public static bool ServiceATSendDocuments { get { return GetServiceATSendDocuments(); } }
        public static bool ServiceATSendDocumentsWayBill { get { return GetServiceATSendDocumentsWayBill(); } }

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        //BackOffice

        //BackOffice Insert Objects start Disabled
        public static bool BOXPOObjectsStartDisabled = false;

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        //Payments Window

        //Use CurrentAccount or CustomerCard in PaymentsDialog
        public static bool PosPaymentsDialogUseCurrentAccount = Convert.ToBoolean(GeneralSettings.Settings["posPaymentsDialogUseCurrentAccount"]);

        //First time boot POS flag
        public static bool FirstBoot;
        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        //Pagination Related
        /// <summary>
        /// Define Rows per Page for pagination load
        /// </summary>
        public static int PaginationRowsPerPage = 30;

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        //Helper Methods

        private static List<string> GetProtectedFilesList()
        {
            List<string> result = new List<string>
            {
                //result.Add(@"Assets\Themes\Default\Backgrounds\Dialogs\dialog_default.jpg");
                //result.Add(@"Assets\Themes\Default\Backgrounds\Dialogs\dialog_tables.jpg");
                //result.Add(@"Assets\Themes\Default\Backgrounds\Windows\window_pos_1024x768.jpg");
                //result.Add(@"Assets\Themes\Default\Backgrounds\Windows\window_pos_800x600.jpg");
                //result.Add(@"Assets\Themes\Default\Backgrounds\Windows\window_startup_1024x768.jpg");
                //result.Add(@"Assets\Themes\Default\Backgrounds\Windows\window_startup_800x600.jpg");
                //result.Add(@"Assets\Themes\Default\Images\logo_backoffice.png");
                //result.Add(@"Assets\Themes\Default\Images\logo_pos.png");
                //result.Add(@"Assets\Themes\theme_default_default_1024x768.xml");
                //result.Add(@"Assets\Themes\theme_default_default_800x600.xml");
                //result.Add(@"Assets\Themes\theme_default_retail_1024x768.xml");
                //result.Add(@"Assets\Themes\theme_default_retail_800x600.xml");
                //result.Add(@"Resources\Database\databasedata.sql");
                //result.Add(@"Resources\Database\databasedatademo.sql");
                //result.Add(@"Resources\Database\databaseviews.sql");
                //result.Add(@"Resources\Database\MSSqlServer\databaseschema.sql");
                //result.Add(@"Resources\Database\MySql\databaseschema.sql");
                //result.Add(@"Resources\Database\Other\configurationpreferenceparameter.sql");
                //result.Add(@"Resources\Database\Other\Country\AO\configurationcurrency.sql");
                //result.Add(@"Resources\Database\Other\Country\AO\configurationholidays.sql");
                //result.Add(@"Resources\Database\Other\Country\AO\configurationprinters.sql");
                //result.Add(@"Resources\Database\Other\Country\AO\configurationvatrate.sql");
                //result.Add(@"Resources\Database\Other\Country\AO\customer.sql");
                //result.Add(@"Resources\Database\Other\Country\MZ\configurationcurrency.sql");
                //result.Add(@"Resources\Database\Other\Country\MZ\configurationholidays.sql");
                //result.Add(@"Resources\Database\Other\Country\MZ\configurationprinters.sql");
                //result.Add(@"Resources\Database\Other\Country\MZ\configurationvatrate.sql");
                //result.Add(@"Resources\Database\Other\Country\MZ\customer.sql");
                //result.Add(@"Resources\Database\SQLite\databaseschema.sql");
                //result.Add(@"Resources\Hardware\Printers\Templates\template_abertura_caixa.ticket");
                //result.Add(@"Resources\Hardware\Printers\Templates\template_abertura_de_caixa_e_entrada_saida_numerario.ticket");
                //result.Add(@"Resources\Hardware\Printers\Templates\template_artigo.ticket");
                //result.Add(@"Resources\Hardware\Printers\Templates\template_consulta_mesa.ticket");
                //result.Add(@"Resources\Hardware\Printers\Templates\template_consulta_mesa_pantera.ticket");
                //result.Add(@"Resources\Hardware\Printers\Templates\template_documento_fiscal.ticket");
                //result.Add(@"Resources\Hardware\Printers\Templates\template_entrada_conta_corrente.ticket");
                //result.Add(@"Resources\Hardware\Printers\Templates\template_fecho_caixa.ticket");
                //result.Add(@"Resources\Hardware\Printers\Templates\template_recibo.ticket");
                //result.Add(@"Resources\Hardware\Printers\Templates\template_ticket.ticket");
                //result.Add(@"Resources\Keyboards\163.xml");
                @"Resources\Reports\UserReports\ReportArticle.frx",
                @"Resources\Reports\UserReports\ReportDocumentFinance.frx",
                /// <summary>
                ///     This change refers to "ENH201810#04".
                /// </summary>
                /// <remarks>
                ///     <para>DESCRIPTION: This code change covers MZ and AO invoice layout enhancement, based on "CurrentCulture" settings.</para>
                ///     <para>ISSUE: all prices greater than million were being cut on invoice.</para>
                ///     <para>CAUSE: there was no proper locale based invoice files.</para>
                ///     <para>SOLUTION: It was created a file for each of those specific locale settings, based on original files. 
                ///     For example: based on "ReportDocumentFinance.frx" it was created "ReportDocumentFinance_pt-MZ.frx".
                ///     </para>
                /// </remarks>
                /// <example>
                ///     "Preço" value: 35 000 000,00
                ///     Shows the value:  000 000,00
                /// </example>
                //result.Add(@"Resources\Reports\UserReports\ReportDocumentFinance.pt-PT.frx");
                //result.Add(@"Resources\Reports\UserReports\ReportDocumentFinance.pt-MZ.frx");
                //result.Add(@"Resources\Reports\UserReports\ReportDocumentFinance.pt-AO.frx");
                @"Resources\Reports\UserReports\ReportDocumentFinancePayment.frx",
                @"Resources\Reports\UserReports\ReportDocumentFinanceWayBill.frx",
                @"Resources\Reports\UserReports\ReportTest.frx"
            };
            //result.Add(@"Resources\Reports\UserReports\TemplateBase.frx");
            //result.Add(@"Resources\Reports\UserReports\TemplateBaseSimple.frx");

            return result;
        }

        /// <summary>
        /// It is responsible for loading the file theme based on user´s choice during POS installation.
        /// Please see #IN008024# for further details.
        /// </summary>
        /// <returns></returns>
        private static string GetFileTheme()
        {
            log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

            string result = string.Empty;

            try
            {
                /* IN008024 */
                //logicpos.datalayer.Enums.CustomAppOperationMode customAppOperationMode = logicpos.datalayer.Enums.CustomAppOperationMode.GetAppOperationMode(LogicPOS.Settings.GeneralSettings.Settings["appOperationModeToken"]);
                CustomAppOperationMode customAppOperationMode = AppOperationModeSettings.CustomAppOperationMode;

                /* 
                 * Possible themes:
                 * theme_default_default.xml
                 * theme_default_retail.xml
                 */
                result = string.Format(
                    "{0}{1}",
                    PathsSettings.Paths["themes"],
                    string.Format(
                        FileFormatThemeFile
                        , GeneralSettings.AppTheme.ToLower() /* IN008024: Before, from Database :LogicPOS.Settings.AppSettings.PreferenceParameters["APP_THEME"].ToLower() */
                        , customAppOperationMode.AppOperationTheme.ToLower()/*  From App.Config: Default|Coffee|Bakery|Fish|Butchery|Shoe|Clothing|Hardware */
                    )
                );
            }
            catch (Exception ex)
            {
                log.Error("string GetFileTheme() :: " + ex.Message, ex);
            }

            return result;
        }

        private static bool GetServiceATSendDocuments()
        {
            return Convert.ToBoolean(GeneralSettings.PreferenceParameters["SERVICE_AT_SEND_DOCUMENTS"]);
        }

        private static bool GetServiceATSendDocumentsWayBill()
        {
            return Convert.ToBoolean(GeneralSettings.PreferenceParameters["SERVICE_AT_SEND_DOCUMENTS_WAYBILL"]);
        }

        /// <summary>
        /// This method is responsible for loading the proper Demo database script for selected user's option during POS installation.
        /// For further details, please see #IN008024# and #IN009035#.
        /// </summary>
        /// <returns></returns>
        private static string GetDatabaseFileName(bool demo, string basePath)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

            string result;

            /* Custom scripts */
            try
            {
                CustomAppOperationMode customAppOperationMode = CustomAppOperationMode.GetAppOperationMode(GeneralSettings.Settings["appOperationModeToken"]);

                string cultureName = GeneralSettings.Settings["customCultureResourceDefinition"];
                if (string.IsNullOrWhiteSpace(cultureName))
                    cultureName = "ru-RU";

                int dashIndex = cultureName.IndexOf('-');
                string cultureCountryPrefix = dashIndex > 0
                    ? cultureName.Substring(0, dashIndex)
                    : cultureName;

                if (demo)
                {
                    string appOperationModeToken = customAppOperationMode.AppOperationModeToken;
                    string fileName = customAppOperationMode.DatabaseDemoFileName;

                    result = string.Format(basePath,
                        appOperationModeToken,
                        cultureCountryPrefix,
                        fileName
                    );
                }
                else
                {
                    if (cultureName == "pt-AO" && basePath == "Resources\\Database\\Data\\{0}\\{1}\\databasedata.sql")
                    {
                        cultureCountryPrefix = "ao";
                    }

                    string appOperationTheme = customAppOperationMode.AppOperationTheme;
                    if (AppOperationModeSettings.CustomAppOperationMode.AppOperationModeToken == "BackOfficeMode")
                    {
                        appOperationTheme = "BackOfficeMode";
                    }

                    result = string.Format(basePath,
                        appOperationTheme,
                        cultureCountryPrefix
                    );
                }

                result = ResolveExistingDatabaseScriptPath(result, demo, basePath, cultureCountryPrefix, customAppOperationMode);
                log.Info(string.Format("GetDatabaseFileName: using script [{0}]", result));
            }
            catch (Exception ex)
            {
                log.Error("string GetDatabaseFileName(bool demo) :: " + ex.Message, ex);
                result = demo
                    ? @"Resources\Database\databasedatademo.sql"
                    : string.Format(FileDatabaseDataPath, "Retail", "en");
            }

            return result;
        }

        private static string ResolveExistingDatabaseScriptPath(
            string primaryPath,
            bool demo,
            string basePath,
            string cultureCountryPrefix,
            CustomAppOperationMode customAppOperationMode)
        {
            if (File.Exists(primaryPath))
                return primaryPath;

            log4net.ILog log = log4net.LogManager.GetLogger(typeof(POSSettings));
            log.Warn(string.Format("Database script not found: [{0}]", primaryPath));

            string[] fallbackPrefixes;
            if (string.Equals(cultureCountryPrefix, "ru", StringComparison.OrdinalIgnoreCase))
                fallbackPrefixes = new[] { "ru", "en" };
            else if (string.Equals(cultureCountryPrefix, "en", StringComparison.OrdinalIgnoreCase))
                fallbackPrefixes = new[] { "en" };
            else
                fallbackPrefixes = new[] { cultureCountryPrefix, "en" };

            foreach (string prefix in fallbackPrefixes)
            {
                string candidate;
                if (demo)
                {
                    candidate = string.Format(
                        basePath,
                        customAppOperationMode.AppOperationModeToken,
                        prefix,
                        customAppOperationMode.DatabaseDemoFileName);
                }
                else
                {
                    string theme = customAppOperationMode.AppOperationTheme;
                    if (customAppOperationMode.AppOperationModeToken == "BackOfficeMode")
                        theme = "BackOfficeMode";

                    candidate = string.Format(basePath, theme, prefix);
                }

                if (File.Exists(candidate))
                {
                    log.Warn(string.Format("Database script fallback: [{0}] -> [{1}]", primaryPath, candidate));
                    return candidate;
                }
            }

            return primaryPath;
        }
    }
}
