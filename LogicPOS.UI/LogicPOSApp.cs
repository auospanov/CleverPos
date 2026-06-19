using DevExpress.Xpo;
using DevExpress.Xpo.DB;
using Gtk;
using logicpos.App;
using logicpos.Classes.DataLayer;
using logicpos.Classes.Enums.App;
using logicpos.Classes.Gui.Gtk.BackOffice;
using logicpos.Classes.Logic.Hardware;
using logicpos.Classes.Logic.Others;
using LogicPOS.Data.Services;
using LogicPOS.Data.XPO;
using LogicPOS.Data.XPO.Settings;
using LogicPOS.Data.XPO.Utility;
using LogicPOS.Domain.Enums;
using LogicPOS.Globalization;
using LogicPOS.Reporting.Utility;
using LogicPOS.Settings;
using LogicPOS.Settings.Enums;
using LogicPOS.Shared;
using LogicPOS.Utility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Text;
using System.Threading;

namespace logicpos
{
    internal class LogicPOSApp
    {
        //Log4Net
        private readonly log4net.ILog _logger = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        //BootStrap
        private bool _quitAfterBootStrap = false;
        /* IN009163 and IN009164 - Opt to auto-backup flow */
        private bool _autoBackupFlowIsEnabled = false;
        //Days, hours, minutes, seconds, milliseconds
        private TimeSpan _backupDatabaseTimeSpan = new TimeSpan();
        private TimeSpan _databaseBackupTimeSpanRangeStart = new TimeSpan();
        private TimeSpan _databaseBackupTimeSpanRangeEnd = new TimeSpan();
        private static bool needToUpdate = false;

        public void StartApp(AppMode pMode)
        {
            try
            {
                // Проверка файла лицензии в начале запуска
                CheckLicenseFile();

                Init();
                GlobalApp.DialogThreadNotify.WakeupMain();
                InitAppMode(pMode);

                InitBackupTimerProcess();

                StartBarcodeBroadcast();

                if (!_quitAfterBootStrap) Application.Run();
            }
            catch (Exception ex)
            {
                _logger.Error(ex.Message, ex);
                Utils.ShowMessageBox(
                    GlobalApp.StartupWindow,
                    DialogFlags.Modal,
                    new Size(500, 240),
                    MessageType.Error,
                    ButtonsType.Ok,
                    CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName,
                    "global_error"),
                    CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName,
                    "app_error_contact_support"));
            }
            finally
            {
                StopBarcodeBroadcast();
                // Dispose Devices

                // Always Close Display Device
                if (GlobalApp.UsbDisplay != null)
                {
                    GlobalApp.UsbDisplay.Close();
                }
                // Always Close Com Ports
                if (GlobalApp.WeighingBalance != null && GlobalApp.WeighingBalance.IsPortOpen())
                {
                    GlobalApp.WeighingBalance.ClosePort();
                }
            }
        }

        /// <summary>
        /// Проверка файла лицензии при старте приложения
        /// </summary>
        private void CheckLicenseFile()
        {
            string licenseFilePath = POSSettings.LicenceFileName;
            
            _logger.Info($"Checking license file: {licenseFilePath}");
            
            // Проверка существования файла
            if (!File.Exists(licenseFilePath))
            {
                _logger.Warn($"License file not found: {licenseFilePath}");
                return;
            }

            // Проверка размера файла
            FileInfo fileInfo = new FileInfo(licenseFilePath);
            if (fileInfo.Length == 0)
            {
                _logger.Error($"License file is empty: {licenseFilePath}");
                return;
            }

            // Попытка загрузки и проверки файла
            try
            {
                bool licenseLoaded = Utils.AssignLicence(licenseFilePath, true);
                if (licenseLoaded)
                {
                    _logger.Info($"License file successfully loaded: {licenseFilePath}");
                    _logger.Info($"License Company: {LicenseSettings.LicenseCompany}");
                    _logger.Info($"License HardwareId: {LicenseSettings.LicenseHardwareId}");
                }
                else
                {
                    _logger.Warn($"License file loaded but validation may have failed: {licenseFilePath}");
                }
            }
            catch (Exception ex)
            {
                _logger.Error($"Error checking license file: {licenseFilePath}. Error: {ex.Message}", ex);
            }
        }

        private void Init()
        {

            //Used to Force create DatabaseScema and Fixtures with XPO (Non Script Mode): Requirements for Work: Empty or Non Exist Database
            //Notes: OnError "An exception of type 'DevExpress.Xpo.DB.Exceptions.SchemaCorrectionNeededException'", UnCheck [X] Break when this exception is user-unhandled and continue, watch log and wait until sucefull message appear
            bool xpoCreateDatabaseAndSchema = POSSettings.XPOCreateDatabaseAndSchema;
            bool xpoCreateDatabaseObjectsWithFixtures = xpoCreateDatabaseAndSchema;
            //Prepare AutoCreateOption
            AutoCreateOption xpoAutoCreateOption = (xpoCreateDatabaseAndSchema) ? AutoCreateOption.DatabaseAndSchema : AutoCreateOption.None;

            //Init Settings Main Config Settings
            //LogicPOS.Settings.GeneralSettings.Settings = ConfigurationManager.AppSettings;

            //Override Licence data with Encrypted File Data
            if (File.Exists(POSSettings.LicenceFileName))
            {
                Utils.AssignLicence(POSSettings.LicenceFileName, true);
            }

            //Other Global App Settings
            GlobalApp.MultiUserEnvironment = Convert.ToBoolean(GeneralSettings.Settings["appMultiUserEnvironment"]);
            GlobalApp.UseVirtualKeyBoard = Convert.ToBoolean(GeneralSettings.Settings["useVirtualKeyBoard"]);

            //Init App Notifications
            GlobalApp.Notifications = new System.Collections.Generic.Dictionary<string, bool>
            {
                ["SHOW_PRINTER_UNDEFINED"] = true
            };

            //System
            GlobalApp.FilePickerStartPath = Directory.GetCurrentDirectory();

            //Get DataBase Details
            DatabaseSettings.DatabaseType = (DatabaseType)Enum.Parse(typeof(DatabaseType), GeneralSettings.Settings["databaseType"]);
            //Override default Database name with parameter from config
            string configDatabaseName = GeneralSettings.Settings["databaseName"];
            DatabaseSettings.DatabaseName = (string.IsNullOrEmpty(configDatabaseName)) ? POSSettings.DatabaseName : configDatabaseName;
            //Xpo Connection String
            string xpoConnectionString = string.Format(GeneralSettings.Settings["xpoConnectionString"], DatabaseSettings.DatabaseName.ToLower());
            DatabaseSettings.AssignConnectionStringToSettings(xpoConnectionString);

            //Removed Protected Files
            //ProtectedFiles, Before Create Database from Scripts, usefull if Scripts are modified by User
            if (POSSettings.ProtectedFilesUse) GlobalApp.ProtectedFiles = InitProtectedFiles();

            //Check if Database Exists if Not Create it from Scripts
            bool databaseCreated = false;

            if (!xpoCreateDatabaseAndSchema)
            {
                //Get result to check if DB is created (true)
                try
                {
                    // Launch Scripts
                    POSSettings.FirstBoot = true;
                    databaseCreated = DataLayer.CreateDatabaseSchema(
                        xpoConnectionString,
                        DatabaseSettings.DatabaseType,
                        DatabaseSettings.DatabaseName,
                        out needToUpdate);
                }
                catch (Exception ex)
                {
                    //Extra protection to prevent goes to login without a valid connection
                    _logger.Error("void Init() :: DataLayer.CreateDatabaseSchema :: " + ex.Message, ex);

                    /* IN009034 */
                    GlobalApp.DialogThreadNotify.WakeupMain();

                    Utils.ShowMessageBox(GlobalApp.StartupWindow, DialogFlags.Modal, new Size(900, 700), MessageType.Error, ButtonsType.Ok, GeneralUtils.GetResourceByName("global_error"), ex.Message);
                    Environment.Exit(0);
                }
            }
            POSSettings.FirstBoot = false;
            //Init XPO Connector DataLayer
            try
            {
                /* IN007011 */
                var connectionStringBuilder = new System.Data.Common.DbConnectionStringBuilder()
                { ConnectionString = xpoConnectionString };
                if (connectionStringBuilder.ContainsKey("password")) { connectionStringBuilder["password"] = "*****"; };
                _logger.Debug(string.Format("void Init() :: Init XpoDefault.DataLayer: [{0}]", connectionStringBuilder.ToString()));

                XpoDefault.DataLayer = XpoDefault.GetDataLayer(xpoConnectionString, xpoAutoCreateOption);
                XPOSettings.Session = new Session(XpoDefault.DataLayer) { LockingOption = LockingOption.None };
            }
            catch (Exception ex)
            {
                _logger.Error("void Init() :: Init XpoDefault.DataLayer: " + ex.Message, ex);

                /* IN009034 */
                GlobalApp.DialogThreadNotify.WakeupMain();

                Utils.ShowMessageBox(GlobalApp.StartupWindow, DialogFlags.Modal, new Size(900, 700), MessageType.Error, ButtonsType.Ok, GeneralUtils.GetResourceByName("global_error"), ex.Message);
                throw; // TO DO
            }

            //Check Valid Database Scheme
            if (!xpoCreateDatabaseAndSchema && !GeneralUtils.IsRunningOnMono)
            {
                bool isSchemaValid = DataLayer.IsSchemaValid(xpoConnectionString);
                _logger.Debug(string.Format("void Init() :: Check if Database Scheme: isSchemaValid : [{0}]", isSchemaValid));
                if (!isSchemaValid)
                {
                    /* IN009034 */
                    GlobalApp.DialogThreadNotify.WakeupMain();

                    string endMessage = "Invalid database Schema! Fix database Schema and Try Again!";
                    Utils.ShowMessageBox(GlobalApp.StartupWindow, DialogFlags.Modal, new Size(500, 300), MessageType.Error, ButtonsType.Ok, GeneralUtils.GetResourceByName("global_error"), string.Format(endMessage, Environment.NewLine));
                    Environment.Exit(0);
                }
            }

            //Compare DataBase version with software version
            ////Desempenho - Comparar versão da base de dados com o versão software [IN:017526]
            //if (Program.DebugMode == false)
            //{
            //    if (string.IsNullOrEmpty(DatabaseSettings.DatabaseVersion))
            //    {
            //        try
            //        {
            //            string sql = string.Format(@"SELECT Version FROM sys_databaseversion;", DatabaseSettings.DatabaseName);
            //            GlobalFramework.DatabaseVersion = XPOSettings.Session.ExecuteScalar(sql).ToString();

            //            string[] tmpDatabaseVersion = GlobalFramework.DatabaseVersion.Split('.');
            //            long tmpDatabaseVersionNumber = int.Parse(tmpDatabaseVersion[0]) * 10000000 + int.Parse(tmpDatabaseVersion[1]) * 10000 + int.Parse(tmpDatabaseVersion[2]);

            //            string[] tmpSoftwareVersion = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString().Split('.');
            //            long tmpSoftwareVersionNumber = int.Parse(tmpSoftwareVersion[0]) * 10000000 + int.Parse(tmpSoftwareVersion[1]) * 10000 + int.Parse(tmpSoftwareVersion[2]);

            //            if (tmpDatabaseVersionNumber > tmpSoftwareVersionNumber)
            //            {
            //                GlobalApp.DialogThreadNotify.WakeupMain();
            //                //throw new InvalidOperationException(string.Format(CultureResources.GetCustomResources(LogicPOS.Settings.CultureSettings.CurrentCultureName, "global_warning_message_database_version")) + " : " + GlobalFramework.DatabaseVersion);
            //                string fileName = "\\LPUpdater\\LPUpdater.exe";
            //                string lPathToUpdater = string.Format(@"{0}\{1}", Environment.CurrentDirectory, fileName);
            //                Utils.ShowMessageTouch(GlobalApp.StartupWindow, DialogFlags.Modal, new Size(500, 300), MessageType.Error, ButtonsType.Ok, CultureResources.GetCustomResources(LogicPOS.Settings.CultureSettings.CurrentCultureName, "global_error"), string.Format(CultureResources.GetCustomResources(LogicPOS.Settings.CultureSettings.CurrentCultureName, "global_warning_message_database_version")) + " : " + GlobalFramework.DatabaseVersion);
            //                System.Diagnostics.Process.Start(lPathToUpdater);
            //                Environment.Exit(0);
            //            }
            //        }
            //        catch (Exception Ex)
            //        {
            //            GlobalApp.DialogThreadNotify.Close();
            //            Utils.ShowMessageTouch(GlobalApp.WindowStartup, DialogFlags.Modal, new Size(500, 300), MessageType.Error, ButtonsType.Ok, CultureResources.GetCustomResources(LogicPOS.Settings.CultureSettings.CurrentCultureName, "global_error"), Ex.Message);
            //            Environment.Exit(0);
            //        }
            //    }
            //}

            // Assign PluginSoftwareVendor Reference to DataLayer SettingsApp to use In Date Protection, we Required to assign it Statically to Prevent Circular References
            // Required to be here, before it is used in above lines, ex Utils.GetTerminal()
            //if (PluginSettings.HasSoftwareVendorPlugin) PluginSettings.PluginSoftwareVendor = PluginSettings.SoftwareVendor; -> Trying to use only PluginSettings.SoftwareVendor @tchial0

            //If not in Xpo create database Scheme Mode, Get Terminal from Db
            if (!xpoCreateDatabaseAndSchema)
            {
                TerminalSettings.LoggedTerminal = Utils.GetTerminal();
            }

            //After Assigned LoggedUser
            if (xpoCreateDatabaseObjectsWithFixtures)
            {
                InitFixtures.InitUserAndTerminal(XPOSettings.Session);
                InitFixtures.InitOther(XPOSettings.Session);
                InitFixtures.InitDocumentFinance(XPOSettings.Session);
                InitFixtures.InitWorkSession(XPOSettings.Session);
            }

            //End Xpo Create Scheme and Fixtures, Terminate App and Request assign False to Developer Vars
            if (xpoCreateDatabaseAndSchema)
            {
                /* IN009034 */
                GlobalApp.DialogThreadNotify.WakeupMain();

                string endMessage = "Xpo Create Schema and Fixtures Done!{0}Please assign false to 'xpoCreateDatabaseAndSchema' and 'xpoCreateDatabaseObjectsWithFixtures' and run App again";
                _logger.Debug(string.Format("void Init() :: xpoCreateDatabaseAndSchema: {0}", endMessage));

                Utils.ShowMessageBox(GlobalApp.StartupWindow, DialogFlags.Modal, new Size(500, 300), MessageType.Info, ButtonsType.Ok, GeneralUtils.GetResourceByName("global_information"), string.Format(endMessage, Environment.NewLine));
                Environment.Exit(0);
            }

            //Init PreferenceParameters
            GeneralSettings.PreferenceParameters = XPOUtility.GetPreferencesParameters();
            //Init Preferences Path
            PathsSettings.InitializePreferencesPaths();

            //CultureInfo/Localization
            // Принудительно устанавливаем русский язык в PreferenceParameters
            GeneralSettings.PreferenceParameters["CULTURE"] = "ru-RU";
            string culture = GeneralSettings.PreferenceParameters["CULTURE"];

            // Отладочная информация
            _logger.Debug(string.Format("CULTURE DEBUG :: PreferenceParameters CULTURE = '{0}'", culture));
            _logger.Debug(string.Format("CULTURE DEBUG :: CultureSettings.CurrentCultureName = '{0}'", CultureSettings.CurrentCultureName));

            /* IN008013 */
            if (string.IsNullOrEmpty(culture))
            {
                culture = CultureSettings.CurrentCultureName;
            }



            //if (!string.IsNullOrEmpty(culture))
            //{
            /* IN006018 and IN007009 */
            //logicpos.shared.App.CustomRegion.RegisterCustomRegion();
            //Thread.CurrentThread.CurrentUICulture = CultureInfo.GetCultureInfo(culture);
            //}
            //if (!Utils.IsLinux)
            //{
            //    Thread.CurrentThread.CurrentUICulture = CultureInfo.GetCultureInfo(culture);
            //}                
            CultureSettings.CurrentCulture = CultureSettings.CurrentCulture = new System.Globalization.CultureInfo(ConfigurationManager.AppSettings["customCultureResourceDefinition"]);

            // Устанавливаем культуру потока из настроек приложения
            var threadCulture = CultureSettings.CurrentCultureName;
            System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(threadCulture);
            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(threadCulture);

            // Обновляем ресурсы локализации для текущего языка
            CultureResources.ForceUpdateLanguage(CultureSettings.CurrentCultureName);

            /* IN006018 and IN007009 */
            _logger.Debug(string.Format("CUSTOM CULTURE :: CurrentUICulture '{0}' in use.", CultureInfo.CurrentUICulture));

            //Always use en-US NumberFormat because of mySql Requirements
            CultureSettings.CurrentCultureNumberFormat = CultureInfo.GetCultureInfo(POSSettings.CultureNumberFormat);

            //Init AppSession
            string appSessionFile = Utils.GetSessionFileName();
            if (databaseCreated && File.Exists(appSessionFile)) File.Delete(appSessionFile);
            POSSession.CurrentSession = POSSession.GetSessionFromFile(appSessionFile);

            //Try to Get open Session Day/Terminal for this Terminal
            XPOSettings.WorkSessionPeriodDay = WorkSessionProcessor.GetSessionPeriod(WorkSessionPeriodType.Day);
            XPOSettings.WorkSessionPeriodTerminal = WorkSessionProcessor.GetSessionPeriod(WorkSessionPeriodType.Terminal);

            //Use Detected ScreenSize
            string appScreenSize = string.IsNullOrEmpty(GeneralSettings.Settings["appScreenSize"])
                ? GeneralSettings.PreferenceParameters["APP_SCREEN_SIZE"]
                : GeneralSettings.Settings["appScreenSize"];
            if (appScreenSize.Replace(" ", string.Empty).Equals("0,0") || string.IsNullOrEmpty(appScreenSize))
            {
                // Force Unknown Screen Size
                //GlobalApp.ScreenSize = new Size(2000, 1800);
                GlobalApp.ScreenSize = Utils.GetThemeScreenSize();
            }
            //Use config ScreenSize
            else
            {
                Size configAppScreenSize = Utils.StringToSize(appScreenSize);
                GlobalApp.ScreenSize = Utils.GetThemeScreenSize(configAppScreenSize);
            }

            // Init ExpressionEvaluator
            GlobalApp.ExpressionEvaluator.EvaluateFunction += ExpressionEvaluatorExtended.ExpressionEvaluator_EvaluateFunction;
            // Init Variables
            ExpressionEvaluatorExtended.InitVariablesStartupWindow();
            ExpressionEvaluatorExtended.InitVariablesPosMainWindow();

            // Define Max Dialog Window Size
            GlobalApp.MaxWindowSize = new Size(GlobalApp.ScreenSize.Width - 40, GlobalApp.ScreenSize.Height - 40);
            // Add Variables to ExpressionEvaluator.Variables Singleton
            GlobalApp.ExpressionEvaluator.Variables.Add("globalScreenSize", GlobalApp.ScreenSize);
            //to used in shared projects
            GeneralSettings.ScreenSize = GlobalApp.ScreenSize;
            //Parse and store Theme in Singleton
            try
            {
                GlobalApp.Theme = XmlToObjectParser.ParseFromFile(POSSettings.FileTheme);
                // Use with dynamic Theme properties like: 
                // GlobalApp.Theme.Theme.Frontoffice.Window[0].Globals.Name = PosBaseWindow
                // GlobalApp.Theme.Theme.Frontoffice.Window[1].Objects.TablePadUser.Position = 50,50
                // or use predicate with from object id ex 
                //var predicate = (Predicate<dynamic>)((dynamic x) => x.ID == "StartupWindow");
                //var themeWindow = GlobalApp.Theme.Theme.Frontoffice.Window.Find(predicate);
                //_logger.Debug(string.Format("Message: [{0}]", themeWindow.Globals.Title));
            }
            catch (Exception ex)
            {
                /* IN009034 */
                GlobalApp.DialogThreadNotify.WakeupMain();

                _logger.Debug("void Init() :: XmlToObjectParser.ParseFromFile(SettingsApp.FileTheme) :: " + ex);
                Utils.ShowMessageTouchErrorRenderTheme(GlobalApp.StartupWindow, ex.Message);
            }

            //Init FastReports Custom Functions and Custom Vars
            FastReportUtils.InitializeFastReports(POSSettings.AppName);

            //Hardware : Init Display
            if (TerminalSettings.LoggedTerminal.PoleDisplay != null)
            {
                GlobalApp.UsbDisplay = (UsbDisplayDevice)UsbDisplayDevice.InitDisplay();
                GlobalApp.UsbDisplay.WriteCentered(string.Format("{0} {1}", POSSettings.AppName, GeneralSettings.ProductVersion), 1);
                GlobalApp.UsbDisplay.WriteCentered(POSSettings.AppUrl, 2);
                GlobalApp.UsbDisplay.EnableStandBy();
            }

            //Hardware : Init BarCodeReader 
            if (TerminalSettings.LoggedTerminal.BarcodeReader != null)
            {
                GlobalApp.BarCodeReader = new InputReader();
            }

            //Hardware : Init WeighingBalance
            if (TerminalSettings.LoggedTerminal.WeighingMachine != null)
            {
                //Protecções de integridade das BD's [IN:013327]
                //Check if port is used by pole display
                if (TerminalSettings.LoggedTerminal.WeighingMachine.PortName == TerminalSettings.LoggedTerminal.PoleDisplay.COM)
                {
                    _logger.Debug(string.Format("Port " + TerminalSettings.LoggedTerminal.WeighingMachine.PortName + "Already taken by pole display"));
                }
                else
                {
                    if (Utils.IsPortOpen(TerminalSettings.LoggedTerminal.WeighingMachine.PortName))
                    {
                        GlobalApp.WeighingBalance = new WeighingBalance(TerminalSettings.LoggedTerminal.WeighingMachine);
                        //_logger.Debug(string.Format("IsPortOpen: [{0}]", GlobalApp.WeighingBalance.IsPortOpen())); }
                    }

                }

            }

            //Send To Log
            _logger.Debug(string.Format("void Init() :: ProductVersion: [{0}], ImageRuntimeVersion: [{1}], IsLicensed: [{2}]", GeneralSettings.ProductVersion, GeneralSettings.ProductAssembly.ImageRuntimeVersion, LicenseSettings.LicenceRegistered));

            //Audit
            XPOUtility.Audit("APP_START", string.Format("{0} {1} clr {2}", POSSettings.AppName, GeneralSettings.ProductVersion, GeneralSettings.ProductAssembly.ImageRuntimeVersion));
            if (databaseCreated) XPOUtility.Audit("DATABASE_CREATE");

            // Plugin Errors Messages
            if (PluginSettings.HasSoftwareVendorPlugin == false)
            {
                _logger.Warn("SoftwareVendor plugin not found. Some features may be disabled.");
            }
            else if (PluginSettings.SoftwareVendor.IsValidSecretKey(PluginSettings.SecretKey) == false)
            {
                /* IN009034 */
                GlobalApp.DialogThreadNotify.WakeupMain();

                _logger.Debug(string.Format("void Init() :: Wrong key detected [{0}]. Use a valid LogicposFinantialLibrary with same key as SoftwareVendorPlugin", PluginSettings.SecretKey));
                Utils.ShowMessageBox(
                    GlobalApp.StartupWindow,
                    DialogFlags.Modal,
                    new Size(650, 380),
                    MessageType.Error,
                    ButtonsType.Ok,
                    CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName,
                    "global_error"),
                    CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName,
                    "dialog_message_error_plugin_softwarevendor_not_registered"));
            }

            // Вывод информации о лицензии (независимо от проверки плагина SoftwareVendor)
            ShowLicenseInformation();

            // TK013134: HardCoded Modules : PakingTicket
            try
            {
                // Override default AppUseParkingTicketModule
                /* IN009239 */
                //GlobalFramework.AppUseParkingTicketModule = Convert.ToBoolean(LogicPOS.Settings.GeneralSettings.Settings["appMultiUserEnvironment"]);
                CustomAppOperationMode customAppOperationMode = AppOperationModeSettings.GetCustomAppOperationMode();
                GeneralSettings.AppUseParkingTicketModule = CustomAppOperationMode.PARKING.Equals(customAppOperationMode);

                //TK016235 BackOffice - Mode
                GeneralSettings.AppUseBackOfficeMode = CustomAppOperationMode.BACKOFFICE.Equals(customAppOperationMode);

                // Init Global Object GlobalApp.ParkingTicket
                if (GeneralSettings.AppUseParkingTicketModule)
                {
                    GlobalApp.ParkingTicket = new ParkingTicket();
                }
            }
            catch (Exception)
            {
                _logger.Error(string.Format("void Init() :: Missing AppUseParkingTicketModule Token in Settings, using default value: [{0}]", GeneralSettings.AppUseParkingTicketModule));
            }


            //Create SystemNotification
            XPOUtility.SystemNotification();

            //Activate stock module for debug
#if DEBUG
            LicenseSettings.LicenseModuleStocks = true;
            PluginSettings.AppCompanyName = LicenseSettings.LicenseCompany = LicenseSettings.LicenseReseller = "Logicpulse";
#endif

            //Clean Documents Folder on New Database, else we have Document files that dont correspond to Database
            if (databaseCreated && Directory.Exists(PathsSettings.Paths["documents"].ToString()))
            {
                string documentsFolder = PathsSettings.Paths["documents"].ToString();
                System.IO.DirectoryInfo di = new DirectoryInfo(documentsFolder);
                if (di.GetFiles().Length > 0)
                {
                    _logger.Debug(string.Format("void Init() :: New database created. Start Delete [{0}] document(s) from [{1}] folder!", di.GetFiles().Length, documentsFolder));
                    foreach (FileInfo file in di.GetFiles())
                    {
                        try
                        {
                            file.Delete();
                        }
                        catch (Exception)
                        {
                            _logger.Error(string.Format("void Init() :: Error! Cant delete Document file: [{0}]", file.Name));
                        }
                    }
                }
            }

        }

        /// <summary>
        /// It creates automatic backup process and its call to TimerHandler.
        /// 
        /// Please see IN009163 and IN009164
        /// </summary>
        private void InitBackupTimerProcess()
        {
            bool xpoCreateDatabaseAndSchema = POSSettings.XPOCreateDatabaseAndSchema;
            Directory.CreateDirectory(PathsSettings.BackupsFolderLocation);
            bool backupsFolderExists = Directory.Exists(PathsSettings.BackupsFolderLocation);

            if (backupsFolderExists == false)
            {
                ResponseType response = Utils.ShowMessageTouch(GlobalApp.StartupWindow, DialogFlags.Modal, MessageType.Question, ButtonsType.YesNo, GeneralUtils.GetResourceByName("global_error"), string.Format(GeneralUtils.GetResourceByName("dialog_message_error_create_directory_backups"), PathsSettings.BackupsFolderLocation));
                //Enable Quit After BootStrap, Preventing Application.Run()
                if (response == ResponseType.No) _quitAfterBootStrap = true;
            }

            //Start Database Backup Timer if not create XPO Schema and SoftwareVendor is Active
            if (PluginSettings.HasSoftwareVendorPlugin && backupsFolderExists && xpoCreateDatabaseAndSchema == false)
            {
                /* IN009163 and IN009164 - Opt to auto-backup flow */
                _autoBackupFlowIsEnabled = bool.Parse(GeneralSettings.PreferenceParameters["DATABASE_BACKUP_AUTOMATIC_ENABLED"]);

                /* IN009164 */
                if (_autoBackupFlowIsEnabled)
                {
                    /* IN009164 - considering these variables are only used for automatic backup purposes, will be settled only when Auto-Backup Flow is enabled */
                    _backupDatabaseTimeSpan = TimeSpan.Parse(GeneralSettings.PreferenceParameters["DATABASE_BACKUP_TIMESPAN"]);
                    _databaseBackupTimeSpanRangeStart = TimeSpan.Parse(GeneralSettings.PreferenceParameters["DATABASE_BACKUP_TIME_SPAN_RANGE_START"]);
                    _databaseBackupTimeSpanRangeEnd = TimeSpan.Parse(GeneralSettings.PreferenceParameters["DATABASE_BACKUP_TIME_SPAN_RANGE_END"]);
                    /* IN009164 - TimeoutHandler() for UpdateBackupTimer() will not be created if Auto-Backup Flow is enabled */
                    StartBackupTimer();
                }
            }
        }

        private const int BarcodeBroadcastHttpPort = 5000;
        private const int BarcodeBroadcastUdpPort = 8888;
        /// <summary>Интервал рассылки UDP broadcast (мс). Постоянная рассылка, чтобы мобильное приложение могло найти сервер при подключении/переподключении.</summary>
        private const int BarcodeBroadcastIntervalMs = 1000;

        private static void StartBarcodeBroadcast()
        {
            try
            {
                string serverIp = GetLocalIPAddress();
                if (string.IsNullOrEmpty(serverIp)) return;
                GlobalApp.BarcodeBroadcastCancellation = new CancellationTokenSource();
                var token = GlobalApp.BarcodeBroadcastCancellation.Token;
                GlobalApp.BarcodeBroadcastThread = new Thread(() => RunBarcodeBroadcastLoop(serverIp, token))
                {
                    IsBackground = true
                };
                GlobalApp.BarcodeHttpThread = new Thread(() => RunBarcodeHttpServer(serverIp, token))
                {
                    IsBackground = true
                };
                GlobalApp.BarcodeBroadcastThread.Start();
                try
                {
                    GlobalApp.BarcodeHttpThread.Start();
                }
                catch (Exception httpEx)
                {
                    log4net.LogManager.GetLogger(typeof(LogicPOSApp)).Debug(
                        "StartBarcodeBroadcast: HTTP server not started: " + httpEx.Message);
                }

                log4net.LogManager.GetLogger(typeof(LogicPOSApp)).Info(
                    string.Format("Barcode UDP broadcast started: {0} -> port {1}", serverIp, BarcodeBroadcastUdpPort));
            }
            catch (Exception ex)
            {
                log4net.LogManager.GetLogger(typeof(LogicPOSApp)).Debug("StartBarcodeBroadcast: " + ex.Message);
            }
        }

        private static void StopBarcodeBroadcast()
        {
            try
            {
                GlobalApp.BarcodeBroadcastCancellation?.Cancel();
                if (GlobalApp.BarcodeBroadcastThread != null && GlobalApp.BarcodeBroadcastThread.IsAlive)
                    GlobalApp.BarcodeBroadcastThread.Join(3000);
                if (GlobalApp.BarcodeHttpThread != null && GlobalApp.BarcodeHttpThread.IsAlive)
                    GlobalApp.BarcodeHttpThread.Join(3000);
                GlobalApp.BarcodeBroadcastCancellation?.Dispose();
                GlobalApp.BarcodeBroadcastCancellation = null;
                GlobalApp.BarcodeBroadcastThread = null;
                GlobalApp.BarcodeHttpThread = null;
            }
            catch { }
        }

        private static void RunBarcodeBroadcastLoop(string serverIp, CancellationToken token)
        {
            try
            {
                var localIp = IPAddress.Parse(serverIp);
                var subnetBroadcast = GetSubnetBroadcastAddress(serverIp);
                var message = string.Format("BARCODE_SERVER:{0}:{1}", serverIp, BarcodeBroadcastHttpPort);
                var bytes = Encoding.UTF8.GetBytes(message);

                using (var udp = new UdpClient(new IPEndPoint(localIp, 0)))
                {
                    udp.EnableBroadcast = true;
                    var globalBroadcast = new IPEndPoint(IPAddress.Broadcast, BarcodeBroadcastUdpPort);
                    IPEndPoint directedBroadcast = null;
                    bool useDirectedBroadcast = false;
                    if (subnetBroadcast != null)
                    {
                        directedBroadcast = new IPEndPoint(subnetBroadcast, BarcodeBroadcastUdpPort);
                        useDirectedBroadcast = true;
                    }

                    while (!token.IsCancellationRequested)
                    {
                        try
                        {
                            udp.Send(bytes, bytes.Length, globalBroadcast);
                            if (useDirectedBroadcast)
                                udp.Send(bytes, bytes.Length, directedBroadcast);
                        }
                        catch (SocketException) { }
                        if (token.WaitHandle.WaitOne(BarcodeBroadcastIntervalMs)) break;
                    }
                }
            }
            catch (Exception) { }
        }

        /// <summary>
        /// TCP-сервер вместо HttpListener: не требует netsh urlacl на Windows,
        /// слушает на всех интерфейсах (телефон подключается по IP из UDP broadcast).
        /// </summary>
        private static void RunBarcodeHttpServer(string serverIp, CancellationToken token)
        {
            TcpListener listener = null;
            try
            {
                listener = new TcpListener(IPAddress.Any, BarcodeBroadcastHttpPort);
                listener.Start();
                log4net.LogManager.GetLogger(typeof(LogicPOSApp)).Info(
                    string.Format(
                        "Barcode TCP server listening on 0.0.0.0:{0} (advertised IP {1})",
                        BarcodeBroadcastHttpPort, serverIp));

                while (!token.IsCancellationRequested)
                {
                    if (!listener.Pending())
                    {
                        if (token.WaitHandle.WaitOne(100))
                            break;
                        continue;
                    }

                    try
                    {
                        var client = listener.AcceptTcpClient();
                        ThreadPool.QueueUserWorkItem(_ => ProcessBarcodeTcpClient(client));
                    }
                    catch (SocketException) { }
                    catch (ObjectDisposedException) { break; }
                }
            }
            catch (Exception ex)
            {
                log4net.LogManager.GetLogger(typeof(LogicPOSApp)).Error(
                    "Barcode TCP server failed: " + ex.Message, ex);
            }
            finally
            {
                try { listener?.Stop(); }
                catch { }
            }
        }

        private static void ProcessBarcodeTcpClient(TcpClient client)
        {
            string barcode = string.Empty;
            var statusCode = 200;
            try
            {
                using (client)
                using (var stream = client.GetStream())
                {
                    stream.ReadTimeout = 5000;
                    stream.WriteTimeout = 5000;

                    using (var reader = new StreamReader(stream, Encoding.UTF8, detectEncodingFromByteOrderMarks: false, bufferSize: 1024, leaveOpen: true))
                    {
                        var requestLine = reader.ReadLine();
                        if (string.IsNullOrEmpty(requestLine))
                            return;

                        var parts = requestLine.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                        var method = parts.Length > 0 ? parts[0] : string.Empty;
                        var path = parts.Length > 1 ? parts[1] : string.Empty;

                        var contentLength = 0;
                        string headerLine;
                        while (!string.IsNullOrEmpty(headerLine = reader.ReadLine()))
                        {
                            if (headerLine.StartsWith("Content-Length:", StringComparison.OrdinalIgnoreCase))
                                int.TryParse(headerLine.Substring(15).Trim(), out contentLength);
                        }

                        if (method == "POST" && path == "/barcode" && contentLength > 0)
                        {
                            var bodyChars = new char[contentLength];
                            var read = reader.Read(bodyChars, 0, contentLength);
                            if (read > 0)
                                barcode = new string(bodyChars, 0, read);
                        }
                        else
                        {
                            statusCode = 404;
                        }
                    }

                    var response = string.Format(
                        "HTTP/1.1 {0} OK\r\nConnection: close\r\nContent-Length: 0\r\n\r\n",
                        statusCode);
                    var responseBytes = Encoding.ASCII.GetBytes(response);
                    stream.Write(responseBytes, 0, responseBytes.Length);
                    stream.Flush();
                }
            }
            catch
            {
                statusCode = 500;
            }

            if (!string.IsNullOrWhiteSpace(barcode))
                ShowMobileBarcodeReceived(barcode.Trim());
        }

        private static void ShowMobileBarcodeReceived(string barcode)
        {
            GLib.Timeout.Add(0, delegate
            {
                try
                {
                    Window window = GlobalApp.PosMainWindow;
                    if (window == null)
                        window = GlobalApp.StartupWindow;
                    if (window == null)
                        window = GlobalApp.BackOfficeMainWindow;

                    if (window != null)
                    {
                        Utils.ShowMessageBox(
                            window,
                            DialogFlags.Modal,
                            new Size(500, 280),
                            MessageType.Info,
                            ButtonsType.Ok,
                            "Штрихкод с телефона",
                            barcode);
                    }
                }
                catch { }
                return false;
            });
        }

        private static string GetLocalIPAddress()
        {
            try
            {
                string wifiIp = null;
                string ethernetIp = null;
                string fallback = null;

                foreach (var ni in NetworkInterface.GetAllNetworkInterfaces())
                {
                    if (ni.OperationalStatus != OperationalStatus.Up) continue;
                    if (ni.NetworkInterfaceType == NetworkInterfaceType.Loopback) continue;
                    if (ni.NetworkInterfaceType == NetworkInterfaceType.Tunnel) continue;

                    var hasGateway = ni.GetIPProperties().GatewayAddresses
                        .Any(g => g.Address.AddressFamily == AddressFamily.InterNetwork && !g.Address.Equals(IPAddress.Any));

                    foreach (var ua in ni.GetIPProperties().UnicastAddresses)
                    {
                        if (ua.Address.AddressFamily != AddressFamily.InterNetwork) continue;
                        if (IPAddress.IsLoopback(ua.Address)) continue;

                        var ip = ua.Address.ToString();
                        if (ip.StartsWith("169.254.")) continue;
                        if (!IsPrivateLanAddress(ua.Address))
                        {
                            if (fallback == null)
                                fallback = ip;
                            continue;
                        }

                        if (ni.NetworkInterfaceType == NetworkInterfaceType.Wireless80211 && hasGateway)
                            wifiIp = ip;
                        else if (ni.NetworkInterfaceType == NetworkInterfaceType.Ethernet && hasGateway)
                            ethernetIp = ip;
                        else if (fallback == null)
                            fallback = ip;
                    }
                }

                return wifiIp ?? ethernetIp ?? fallback;
            }
            catch { }
            return null;
        }

        private static bool IsPrivateLanAddress(IPAddress address)
        {
            var bytes = address.GetAddressBytes();
            if (bytes.Length != 4) return false;
            if (bytes[0] == 10) return true;
            if (bytes[0] == 172 && bytes[1] >= 16 && bytes[1] <= 31) return true;
            if (bytes[0] == 192 && bytes[1] == 168) return true;
            return false;
        }

        private static IPAddress GetSubnetBroadcastAddress(string serverIp)
        {
            try
            {
                foreach (var ni in NetworkInterface.GetAllNetworkInterfaces())
                {
                    if (ni.OperationalStatus != OperationalStatus.Up) continue;

                    foreach (var ua in ni.GetIPProperties().UnicastAddresses)
                    {
                        if (ua.Address.AddressFamily != AddressFamily.InterNetwork) continue;
                        if (!ua.Address.ToString().Equals(serverIp, StringComparison.Ordinal)) continue;
                        if (ua.IPv4Mask == null) continue;

                        var ipBytes = ua.Address.GetAddressBytes();
                        var maskBytes = ua.IPv4Mask.GetAddressBytes();
                        var broadcastBytes = new byte[4];
                        for (int i = 0; i < 4; i++)
                            broadcastBytes[i] = (byte)(ipBytes[i] | (maskBytes[i] ^ 255));

                        return new IPAddress(broadcastBytes);
                    }
                }
            }
            catch { }
            return null;
        }

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

        private ProtectedFiles InitProtectedFiles()
        {
            bool debug = true;
            string filePath = POSSettings.ProtectedFilesFileName;
            List<string> fileList = POSSettings.ProtectedFilesList;

            ProtectedFiles protectedFiles;
            //ReCreate File MODE
            if (POSSettings.ProtectedFilesRecreateCSV)
            {
                protectedFiles = new ProtectedFiles(fileList, filePath);
                string md5FromFile = CryptographyUtils.MD5HashFile(filePath);
                //End Xpo Create Scheme and Fixtures, Terminate App and Request assign False to Developer Vars
                //string message = string.Format(@"ProtectedFiles '{1}' re-created with {2} files found!
                //    {0}- Assign false to 'SettingsApp.ProtectedFilesRecreateCsv'.
                //    {0}- Update logicpos.financial.library SettingsApp.ProtectedFilesFileHash with Hash: '{3}.'"
                //    , Environment.NewLine, filePath, fileList.Count, md5FromFile
                //);
                //_logger.Debug(String.Format("Protected files: [{0}]", message));
                string message = string.Format(@"ProtectedFiles '{1}' re-created with {2} files found!{0}{0}Assign false to 'SettingsApp.ProtectedFilesRecreateCsv' and run app again.", Environment.NewLine, filePath, fileList.Count);

                ExportProtectedFiles(fileList);
                Utils.ShowMessageBox(GlobalApp.StartupWindow, DialogFlags.Modal, new System.Drawing.Size(600, 350), MessageType.Info, ButtonsType.Ok, GeneralUtils.GetResourceByName("global_information"), message);
                Environment.Exit(0);
            }
            //Dont check changed files if Developer, Uncomment to Enable
            //else if (SettingsApp.DeveloperMode)
            //{
            //    protectedFiles = new ProtectedFiles(filePath);
            //}
            //Use File
            else
            {
                protectedFiles = new ProtectedFiles(filePath);
                foreach (var item in protectedFiles)
                {
                    if (debug) _logger.Debug(string.Format("Message: [{0}], Valid: [{1}], IsValidFile: [{2}]", item.Key, item.Value.Valid, protectedFiles.IsValidFile(item.Key)));
                }

                List<string> getInvalidAndMissingFiles = protectedFiles.GetInvalidAndMissingFiles(fileList);

                if (getInvalidAndMissingFiles.Count > 0)
                {
                    string filesMessage = string.Empty;
                    for (int i = 0; i < getInvalidAndMissingFiles.Count; i++)
                    {
                        if (debug) _logger.Debug(string.Format("InvalidFile: [{0}]", getInvalidAndMissingFiles[i]));
                        filesMessage += string.Format("{0}{1}", getInvalidAndMissingFiles[i], Environment.NewLine);
                    }

                    //If Not IgnoreProtection, show alert and exit
                    if (!POSSettings.ProtectedFilesIgnoreProtection)
                    {
                        Utils.ShowMessageBox(
                            GlobalApp.StartupWindow,
                            DialogFlags.Modal,
                            new Size(800, 400),
                            MessageType.Error,
                            ButtonsType.Close,
                            CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName,
                            "global_error"), string.Format(CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName,
                            "dialog_message_error_protected_files_invalid_files_detected"),
                            filesMessage));

                        Environment.Exit(0);
                    }
                }
            }

            return protectedFiles;
        }

        //Export Files
        public bool ExportProtectedFiles(List<string> pFileList)
        {
            bool result = false;
            string[] files = new string[pFileList.Count + 1];
            string filename = string.Format("{0}{1}", PathsSettings.TempFolderLocation, "protected.zip");

            try
            {
                for (int i = 0; i < pFileList.Count; i++)
                {
                    files[i] = pFileList[i];
                }
                files[pFileList.Count] = POSSettings.ProtectedFilesFileName;

                //Empty password, to zip without password
                result = CompressionUtils.ZipPack(files, filename, string.Empty);
            }
            catch (Exception ex)
            {
                _logger.Error(ex.Message, ex);
            }

            return result;
        }

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

        private void InitAppMode(AppMode pAppMode)
        {
            //Run in BackOffice Mode
            if (pAppMode == AppMode.Backoffice)
            {
                GlobalApp.BackOfficeMainWindow = new BackOfficeMainWindow();
            }
            //Run in POS Mode
            else
            {
                //Init Theme Object
                _logger.Debug("Init Theme Object ");
                var predicate = (Predicate<dynamic>)((dynamic x) => x.ID == "StartupWindow");
                var themeWindow = GlobalApp.Theme.Theme.Frontoffice.Window.Find(predicate);

                //// Inject themeWindow into 
                //GlobalApp.ExpressionEvaluator.Variables.Add("themeWindow", themeWindow);

                try
                {
                    _logger.Debug("Init windowImageFileName ");
                    string windowImageFileName = string.Format(themeWindow.Globals.ImageFileName, GlobalApp.ScreenSize.Width, GlobalApp.ScreenSize.Height);
                    _logger.Debug("StartupWindow " + windowImageFileName);
                    GlobalApp.StartupWindow = new StartupWindow(windowImageFileName, needToUpdate);


                }
                catch (Exception ex)
                {
                    _logger.Error(ex.Message, ex);
                }
            };
        }


        public static void QuitWithoutConfirmation(bool pAudit = true)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

            StopBarcodeBroadcast();
            try
            {
                //Audit
                if (pAudit) XPOUtility.Audit("APP_CLOSE");
                //Before use DeleteSession()
                /* IN005943 */
                POSSession.CurrentSession.CleanSession();
                POSSession.CurrentSession.Save();
                //GlobalFramework.SessionApp.DeleteSession();
                //Disconnect SessionXpo
                XPOSettings.Session.Disconnect();
            }
            catch (Exception ex)
            {
                log.Error(ex.Message, ex);
            }

            Application.Quit();
            //Environment.Exit(0);
        }

        public static void Quit(Window pSourceWindow)
        {
            ResponseType responseType = Utils.ShowMessageBox(
                pSourceWindow,
                DialogFlags.Modal,
                new Size(400, 300),
                MessageType.Question,
                ButtonsType.YesNo,
                CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName,
                "global_quit_title"),
                CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName,
                "global_quit_message"));

            if (responseType == ResponseType.Yes)
            {
                QuitWithoutConfirmation();
            }
        }

        //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        //BackupTimer

        private void StartBackupTimer()
        {
            try
            {
                // Every second call update_status' (1000 milliseconds)
                GLib.Timeout.Add(POSSettings.BackupTimerInterval, new GLib.TimeoutHandler(UpdateBackupTimer));
            }
            catch (Exception ex)
            {
                _logger.Error("void StartBackupTimer() :: _autoBackupFlowIsActive: [" + _autoBackupFlowIsEnabled + "] :: " + ex.Message, ex);
            }
        }

        private bool UpdateBackupTimer()
        {
            _logger.Debug("bool UpdateBackupTimer()");
            bool debug = false;

            DateTime currentDateTime = XPOUtility.CurrentDateTimeAtomic();
            DateTime currentDateTimeLastBackup = DataBaseBackup.GetLastBackupDate();
            TimeSpan timeSpanDiference = currentDateTime - currentDateTimeLastBackup;

            //Check if is in Start end Range
            if (currentDateTime.TimeOfDay > _databaseBackupTimeSpanRangeStart && currentDateTime.TimeOfDay < _databaseBackupTimeSpanRangeEnd)
            {
                if (timeSpanDiference >= _backupDatabaseTimeSpan)
                {
                    /* ERR201810#15 - Database backup issues */
                    DataBaseBackup.Backup(null);
                    //DataBaseBackup.Backup();
                }
                else
                {
                    if (debug) _logger.Debug(string.Format("Inside of TimeRange: currentDateTime:[{0}], backupLastDateTime:[{1}], timeSpanDiference:[{2}], backupDatabaseTimeSpan:[{3}] ", currentDateTime, currentDateTimeLastBackup, timeSpanDiference, _backupDatabaseTimeSpan));
                }
            }
            else
            {
                if (debug) _logger.Debug(string.Format("Outside of TimeRange: [{0}] > [{1}] && [{2}] < [{3}]", currentDateTime.TimeOfDay, _databaseBackupTimeSpanRangeStart, currentDateTime.TimeOfDay, _databaseBackupTimeSpanRangeEnd));
            }

            // Returning true means that the timeout routine should be invoked
            // again after the timeout period expires. Returning false would
            // terminate the timeout.
            return true;
        }

        /// <summary>
        /// Вывод информации о текущей лицензии
        /// </summary>
        private void ShowLicenseInformation()
        {
            try
            {
                string licenseInfo = string.Empty;

                // Формируем сообщение с информацией о лицензии
                if (!string.IsNullOrEmpty(LicenseSettings.LicenseVersion))
                {
                    licenseInfo += string.Format("Версия лицензии: {0}{1}", LicenseSettings.LicenseVersion, Environment.NewLine);
                }

                if (!string.IsNullOrEmpty(LicenseSettings.LicenseCompany))
                {
                    licenseInfo += string.Format("Компания: {0}{1}", LicenseSettings.LicenseCompany, Environment.NewLine);
                }

                if (!string.IsNullOrEmpty(LicenseSettings.LicenseName))
                {
                    licenseInfo += string.Format("Имя: {0}{1}", LicenseSettings.LicenseName, Environment.NewLine);
                }

                if (!string.IsNullOrEmpty(LicenseSettings.LicenseDate))
                {
                    licenseInfo += string.Format("Дата: {0}{1}", LicenseSettings.LicenseDate, Environment.NewLine);
                }

                if (!string.IsNullOrEmpty(LicenseSettings.LicenseHardwareId))
                {
                    licenseInfo += string.Format("ID оборудования: {0}{1}", LicenseSettings.LicenseHardwareId, Environment.NewLine);
                }

                if (!string.IsNullOrEmpty(LicenseSettings.LicenseReseller))
                {
                    licenseInfo += string.Format("Реселлер: {0}{1}", LicenseSettings.LicenseReseller, Environment.NewLine);
                }

                licenseInfo += string.Format("Статус: {0}", LicenseSettings.LicenceRegistered ? "Зарегистрирована" : "Не зарегистрирована");

                // Логируем информацию
                _logger.Info("Информация о лицензии:");
                _logger.Info(licenseInfo);

                // Выводим сообщение пользователю только если есть информация о лицензии
                if (!string.IsNullOrEmpty(licenseInfo) && 
                    (!string.IsNullOrEmpty(LicenseSettings.LicenseVersion) || 
                     !string.IsNullOrEmpty(LicenseSettings.LicenseCompany) ||
                     LicenseSettings.LicenceRegistered))
                {
                    /* IN009034 */
                    GlobalApp.DialogThreadNotify.WakeupMain();

                    Utils.ShowMessageBox(
                        GlobalApp.StartupWindow,
                        DialogFlags.Modal,
                        new Size(600, 400),
                        MessageType.Info,
                        ButtonsType.Ok,
                        "Информация о лицензии",
                        licenseInfo);
                }
                else
                {
                    _logger.Debug("Информация о лицензии не загружена или отсутствует");
                }
            }
            catch (Exception ex)
            {
                _logger.Error($"Ошибка при выводе информации о лицензии: {ex.Message}", ex);
            }
        }
    }
}
