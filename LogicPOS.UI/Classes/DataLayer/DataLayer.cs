using DevExpress.Xpo;
using DevExpress.Xpo.DB;
using logicpos.App;
using LogicPOS.Settings;
using LogicPOS.Settings.Enums;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;

namespace logicpos
{
    public class DataLayer
    {
        /// <summary>
        /// Create initial database Scheme and Initial scripts
        /// </summary>
        /// <param name="ConnectionString"></param>
        /// <param name="DatabaseType"></param>
        /// <param name="DatabaseName"></param>
        /// <returns></returns>
        public static bool CreateDatabaseSchema(string pXpoConnectionString, DatabaseType pDatabaseType, string pDatabaseName, out bool needToUpdate)
        {
            //Log4Net
            log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
            Session xpoSession = null;
            try
            {

                needToUpdate = false;
                bool result = false;
                string xpoConnectionString = pXpoConnectionString;
                DatabaseType databaseType = pDatabaseType;
                string databaseTypeString = Enum.GetName(typeof(DatabaseType), DatabaseSettings.DatabaseType);
                string databaseName = pDatabaseName;
                IDataLayer xpoDataLayer = null;
                string sql = string.Empty;
                object resultCmd;
                Hashtable commands = new Hashtable();
                string commandSeparator = ";";
                bool databaseExists = false;
                Dictionary<string, string> replace = GetReplaceables(pDatabaseType);

                string sqlDatabaseSchema = string.Format(POSSettings.FileDatabaseSchema, databaseTypeString);
                string sqlDatabaseUpdate = string.Format(POSSettings.FileDatabaseUpdate, databaseTypeString);
                //string sqlDatabaseOtherDatabaseType = SharedUtils.OSSlash(string.Format(SettingsApp.FileDatabaseOtherDatabaseType, databaseTypeString)); /* IN009045: Not in use */
                string sqlDatabaseOtherCommon = POSSettings.FileDatabaseOtherCommon;
                /* IN008024 and after IN009035: data being included by databasedata.sql accordingly to its specific theme/language */
                // string sqlDatabaseOtherCommonAppMode = string.Format("{0}/{1}", SharedUtils.OSSlash(SettingsApp.FileDatabaseOtherCommonAppMode), SettingsApp.CustomAppOperationMode.AppOperationTheme.ToLower());
                string sqlDatabaseOtherCommonPluginsSoftwareVendor = POSSettings.FileDatabaseOtherCommonPluginsSoftwareVendor;
                string FileDatabaseOtherCommonPluginsSoftwareVendorOtherCommonCountry = POSSettings.FileDatabaseOtherCommonPluginsSoftwareVendor;
                string sqlDatabaseData = POSSettings.FileDatabaseData;
                string sqlDatabaseDataDemo = POSSettings.FileDatabaseDataDemo;
                string sqlDatabaseViews = POSSettings.FileDatabaseViews;
                bool useDatabaseDataDemo = Convert.ToBoolean(GeneralSettings.Settings["useDatabaseDataDemo"]);

                string version = GeneralSettings.ProductVersion.Replace("v", "");
                //string version = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();

                switch (databaseType)
                {
                    case DatabaseType.SQLite:
                    case DatabaseType.MonoLite:
                        //connectionstring = string.Format(LogicPOS.Settings.GeneralSettings.Settings["xpoConnectionString"], databaseName);
                        commands.Add("check_version", string.Format(@"SELECT name FROM sqlite_master WHERE type='table' AND name='sys_databaseversion';"));
                        commands.Add("create_version", string.Format(@"CREATE TABLE [sys_databaseversion] ([Version] [varchar](20)); INSERT INTO sys_databaseversion (version) VALUES ('{0}');", version));
                        commands.Add("select_version", string.Format(@"SELECT version FROM sys_databaseversion;"));
                        commands.Add("insert_version", string.Format(@"INSERT INTO sys_databaseversion (version) VALUES ('{0}');", version));
                        commands.Add("update_version", string.Format(@"UPDATE sys_databaseversion SET version = '{0}';", version));
                        break;
                    case DatabaseType.MSSqlServer:
                        //Required to Remove DataBase Name From Connection String
                        xpoConnectionString = xpoConnectionString.Replace(string.Format("Initial Catalog={0};", pDatabaseName), string.Empty);
                        commands.Add("select_schema", string.Format(@"SELECT name FROM sys.databases WHERE name = '{0}' AND name NOT IN ('master', 'tempdb', 'model', 'msdb');", databaseName));
                        commands.Add("create_database", string.Format(@"IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = '{0}') CREATE DATABASE {0};", databaseName));
                        commands.Add("use_database", string.Format(@"USE {0};", databaseName));
                        commands.Add("drop_database", string.Format(@"USE master; IF EXISTS(SELECT name FROM sys.databases WHERE name = '{0}') DROP DATABASE {0};", databaseName));

                        commands.Add("check_version", string.Format(@"USE {0}; SELECT name FROM sys.objects WHERE object_id = OBJECT_ID(N'[sys_databaseversion]') AND type in (N'U');", databaseName));
                        commands.Add("create_version", string.Format(@"USE {0}; CREATE TABLE [sys_databaseversion] ([Version] [varchar](20) NOT NULL) ON [PRIMARY]; INSERT INTO sys_databaseversion (version) VALUES ('{1}');", databaseName, version));
                        commands.Add("select_version", string.Format(@"USE {0}; SELECT version FROM sys_databaseversion;", databaseName));
                        commands.Add("insert_version", string.Format(@"USE {0}; INSERT INTO sys_databaseversion (version) VALUES ('{1}');", databaseName, version));
                        commands.Add("update_version", string.Format(@"USE {0}; UPDATE sys_databaseversion SET version = '{1}';", databaseName, version));
                        //ByPass Default commandSeparator ;
                        commandSeparator = "GO";
                        break;
                    case DatabaseType.MySql:
                        //Required to Remove DataBase Name From Connection String
                        xpoConnectionString = xpoConnectionString.Replace(string.Format("database={0};", pDatabaseName), string.Empty);
                        commands.Add("select_schema", string.Format(@"SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '{0}';", databaseName));
                        commands.Add("create_database", string.Format(@"CREATE DATABASE IF NOT EXISTS {0} CHARACTER SET utf8 COLLATE utf8_bin /*!40100 DEFAULT CHARACTER SET utf8*/;", databaseName));
                        commands.Add("use_database", string.Format(@"USE {0};", databaseName));
                        commands.Add("drop_database", string.Format(@"DROP DATABASE IF EXISTS {0};", databaseName));

                        commands.Add("check_version", string.Format(@"USE {0}; SELECT table_name FROM information_schema.tables WHERE table_name = 'sys_databaseversion' LIMIT 1;", databaseName));
                        commands.Add("create_version", string.Format(@"USE {0}; CREATE TABLE sys_databaseversion (Version varchar(10) DEFAULT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8; INSERT INTO sys_databaseversion (Version) VALUES ('{1}');", databaseName, version));
                        commands.Add("select_version", string.Format(@"USE {0}; SELECT version FROM sys_databaseversion;", databaseName));
                        commands.Add("insert_version", string.Format(@"USE {0}; INSERT INTO sys_databaseversion (Version) VALUES ('{1}');", databaseName, version));
                        commands.Add("update_version", string.Format(@"USE {0}; UPDATE sys_databaseversion SET Version = '{1}' WHERE Version = 'OLD_VERSION';", databaseName, version));
                        break;
                }

                //Get DataLayer
                try
                {
                    xpoDataLayer = XpoDefault.GetDataLayer(xpoConnectionString, AutoCreateOption.None);
                }
                catch (Exception ex)
                {
                    log.Error(string.Format("CreateDatabaseSchema(): {0}", ex.Message), ex);
                    throw;
                }

                //Init Session
                xpoSession = new Session(xpoDataLayer);

                //Start CreateDatabaseSchema Process
                try
                {
                    switch (databaseType)
                    {
                        case DatabaseType.SQLite:
                        case DatabaseType.MonoLite:
                            string filename = string.Format("{0}.db", databaseName);
                            databaseExists = (File.Exists(filename) && new FileInfo(filename).Length > 0);
                            log.Debug(string.Format("DatabaseExists: [{0}], databaseName: [{1}]", databaseExists, string.Format("{0}.db", databaseName)));
                            break;
                        case DatabaseType.MSSqlServer:
                        case DatabaseType.MySql:
                        default:
                            sql = commands["select_schema"].ToString();
                            //log.Debug(string.Format("ExecuteScalar: [{0}]", sql));
                            resultCmd = xpoSession.ExecuteScalar(sql);
                            log.Debug(string.Format("Use Database resultCmd: [{0}]", resultCmd));
                            databaseExists = ((string)resultCmd == databaseName);
                            log.Debug(string.Format("DatabaseExists:[{0}] [{1}]", databaseName, databaseExists));
                            break;
                    }
                    //FileVersionInfo fvi = FileVersionInfo.GetVersionInfo(CurrentAppFileName);
                    //CurrentAppVersion = fvi.FileVersion;

                    //Create Database and Data
                    if (!databaseExists)
                    {
                        log.Debug(string.Format("Creating {0} Database: [{1}]", databaseType, databaseName));

                        //Always Delete Old appsession.json file when Create new Database
                        if (File.Exists(Utils.GetSessionFileName()))
                        {
                            File.Delete(Utils.GetSessionFileName());
                        }

                        if (pDatabaseType != DatabaseType.SQLite && pDatabaseType != DatabaseType.MonoLite)
                        {
                            sql = commands["create_database"].ToString();
                            log.Debug(string.Format("ExecuteScalar create_database: [{0}]", sql));
                            resultCmd = xpoSession.ExecuteScalar(sql);
                            log.Debug(string.Format("Create Database resultCmd: [{0}]", resultCmd));

                            sql = commands["use_database"].ToString();
                            log.Debug(string.Format("ExecuteScalar use_database: [{0}]", sql));
                            resultCmd = xpoSession.ExecuteScalar(sql);
                            log.Debug(string.Format("Use Database resultCmd: [{0}]", resultCmd));
                        }

                        //Restore Script Files

                        //Schema
                        result = ProcessDump(xpoSession, sqlDatabaseSchema, commandSeparator, replace);
                        //Data
                        if (result)
                        {
                            log.Info(string.Format("CreateDatabaseSchema: loading databasedata from [{0}]", sqlDatabaseData));
                            result = ProcessDump(xpoSession, sqlDatabaseData, ";", replace);
                        }
                        //DataDemo
                        if (useDatabaseDataDemo && result)
                        {
                            log.Info(string.Format("CreateDatabaseSchema: loading demo data from [{0}]", sqlDatabaseDataDemo));
                            result = ProcessDump(xpoSession, sqlDatabaseDataDemo, ";", replace);
                        }
                        //Process Other Files: DatabaseOtherCommonPluginsSoftwareVendor
                        if (result)
                        {
                            result = ProcessDumpDirectory(xpoSession, sqlDatabaseOtherCommonPluginsSoftwareVendor, ";", replace);
                        }
                        //Views
                        if (result)
                        {
                            result = ProcessDump(xpoSession, sqlDatabaseViews, ";", replace);
                        }
                        //Directory Scripts
                        //Process Other Files: DatabaseOtherDatabaseType
                        /* IN009045: not in use */
                        /*if (result)
                        {
                            result = ProcessDumpDirectory(xpoSession, sqlDatabaseOtherDatabaseType, ";", replace);//commandSeparator
                        }*/
                        //Process Other Files: DatabaseOtherCommon
                        if (result)
                        {
                            result = ProcessDumpDirectory(xpoSession, sqlDatabaseOtherCommon, ";", replace); /* IN009045 */
                        }
                        ////Process Other Files: DatabaseOtherCommonPluginsSoftwareVendor
                        //if (result)
                        //{
                        //    result = ProcessDumpDirectory(xpoSession, sqlDatabaseOtherCommonPluginsSoftwareVendor, commandSeparator, replace);
                        //}
                        //Process Other Files: DatabaseOtherCommonAppMode
                        /* IN009045 and IN009035: data being included by databasedata.sql accordingly to its specific theme/language */
                        /*if (result)
                        {
                            result = ProcessDumpDirectory(xpoSession, sqlDatabaseOtherCommonAppMode, ";", replace);
                        }*/

                        //Clean ConfigurationPreferenceParameter
                        string sqlConfigurationPreferenceParameter = @"UPDATE cfg_configurationpreferenceparameter SET Value = NULL WHERE (Token = 'COMPANY_COUNTRY' OR Token = 'COMPANY_COUNTRY_CODE2' OR Token = 'SYSTEM_CURRENCY' OR Token = 'COMPANY_COUNTRY_OID' OR Token = 'SYSTEM_CURRENCY_OID')";
                        if (result && Debugger.IsAttached == true)
                        {
                            xpoSession.ExecuteScalar(sqlConfigurationPreferenceParameter);
                        }
                        else
                        {
                            sqlConfigurationPreferenceParameter = string.Format("{0} {1}", sqlConfigurationPreferenceParameter, "OR (FormPageNo = 1 AND FormType = 1 AND Token <> 'COMPANY_TAX_ENTITY')");
                            xpoSession.ExecuteScalar(sqlConfigurationPreferenceParameter);
                        }

                        sql = commands["check_version"].ToString();
                        log.Debug(string.Format("ExecuteScalar check_version: [{0}]", sql));
                        resultCmd = xpoSession.ExecuteScalar(sql);

                        log.Debug(string.Format("check_version resultCmd: [{0}]", resultCmd));

                        //Se cria tabela database_version, faz update
                        if (resultCmd == null)
                        {
                            sql = commands["create_version"].ToString();
                            log.Debug(string.Format("ExecuteScalar create_version: [{0}]", sql));
                            resultCmd = xpoSession.ExecuteScalar(sql);
                            log.Debug(string.Format("create_version resultCmd: [{0}]", resultCmd));

                            result = ProcessDump(xpoSession, sqlDatabaseUpdate, commandSeparator, replace);


                            if (result)
                            {
                                sql = commands["update_version"].ToString().Replace("OLD_VERSION", resultCmd.ToString());
                                log.Debug(string.Format("ExecuteScalar update_version: [{0}]", sql));
                                resultCmd = xpoSession.ExecuteScalar(sql);
                                log.Debug(string.Format("update_version resultCmd: [{0}]", resultCmd));
                            }
                        }

                        else
                        {
                            sql = commands["insert_version"].ToString();
                            log.Debug(string.Format("ExecuteScalar insert_version: [{0}]", sql));
                            resultCmd = xpoSession.ExecuteScalar(sql);
                            log.Debug(string.Format("insert_version resultCmd: [{0}]", resultCmd));
                        }

                        ApplyRussianCountryNamesIfNeeded(xpoSession, databaseType, replace);
                        ApplyRussianCurrencyNamesIfNeeded(xpoSession, databaseType, replace);
                    }
                    else
                    {
                        sql = commands["check_version"].ToString();
                        log.Debug(string.Format("ExecuteScalar check_version: [{0}]", sql));
                        resultCmd = xpoSession.ExecuteScalar(sql);
                        log.Debug(string.Format("check_version resultCmd: [{0}]", resultCmd));

                        if (resultCmd == null)
                        {
                            sql = commands["create_version"].ToString();
                            log.Debug(string.Format("ExecuteScalar create_version: [{0}]", sql));
                            resultCmd = xpoSession.ExecuteQuery(sql);
                            log.Debug(string.Format("create_version resultCmd: [{0}]", resultCmd));

                            result = ProcessDump(xpoSession, sqlDatabaseUpdate, commandSeparator, replace);

                            if (result)
                            {
                                sql = commands["update_version"].ToString().Replace("OLD_VERSION", resultCmd.ToString());
                                log.Debug(string.Format("ExecuteScalar update_version: [{0}]", sql));
                                resultCmd = xpoSession.ExecuteScalar(sql);
                                log.Debug(string.Format("update_version resultCmd: [{0}]", resultCmd));
                            }
                        }
                        else
                        {
                            sql = commands["select_version"].ToString();
                            log.Debug(string.Format("ExecuteScalar select_version: [{0}]", sql));
                            resultCmd = xpoSession.ExecuteScalar(sql);
                            log.Debug(string.Format("select_version resultCmd: [{0}]", resultCmd));

                            needToUpdate = false;
                            try
                            {
                                string[] tmpNew = version.Split('.');
                                long tmpNewVer = int.Parse(tmpNew[0]) * 10000000 + int.Parse(tmpNew[1]) * 10000 + int.Parse(tmpNew[2]);

                                string[] tmpOld = resultCmd.ToString().Split('.');
                                long tmpOldVer = int.Parse(tmpOld[0]) * 10000000 + int.Parse(tmpOld[1]) * 10000 + int.Parse(tmpOld[2]);

                                if (tmpNewVer > tmpOldVer)
                                {
                                    needToUpdate = true;
                                }
                            }
                            catch (Exception ex)
                            {
                                log.Error(ex.Message, ex);
                            }

                            if (needToUpdate)
                            {      //update                           

                                result = ProcessDump(xpoSession, sqlDatabaseUpdate, commandSeparator, replace);


                                if (result)
                                {
                                    sql = commands["update_version"].ToString().Replace("OLD_VERSION", resultCmd.ToString());
                                    log.Debug(string.Format("ExecuteScalar update_version: [{0}]", sql));
                                    resultCmd = xpoSession.ExecuteScalar(sql);
                                    log.Debug(string.Format("update_version resultCmd: [{0}]", resultCmd));
                                }
                            }
                        }

                        ApplyRussianCountryNamesIfNeeded(xpoSession, databaseType, replace);
                        ApplyRussianCurrencyNamesIfNeeded(xpoSession, databaseType, replace);

                        log.Debug(string.Format("{0} Database: [{1}] Already Exist! Skip Creating Database", databaseType, databaseName));
                        result = false;
                        return false;
                    }
                }
                catch (Exception ex)
                {
                    log.Error(ex.Message, ex);
                    result = false;
                }

                //If detect errors Drop Incompleted Database
                //if (onErrorsDropDatabase && !result)
                //{
                //    //Drop Database 
                //    sql = commands["drop_database"].ToString();
                //    log.Debug(string.Format("ExecuteScalar drop_database: [{0}]", sql));
                //    resultCmd = xpoSession.ExecuteScalar(sql);
                //    log.Debug(string.Format("drop_database resultCmd: [{0}]", resultCmd));
                //}

                return result;
            }
            catch (Exception Ex)
            {
                log.Error(Ex.Message, Ex);
                needToUpdate = false;
                return false;
            }
            finally
            {
                ReleaseXpoSession(xpoSession);
            }

        }

        private static void ReleaseXpoSession(Session xpoSession)
        {
            if (xpoSession == null)
                return;

            try
            {
                xpoSession.Disconnect();
            }
            catch
            {
                // ignore disconnect errors during cleanup
            }

            try
            {
                xpoSession.Dispose();
            }
            catch
            {
                // ignore dispose errors during cleanup
            }
        }

        /// <summary>
        /// Check if current database Schema is Valid
        /// </summary>
        /// <param name="ConnectionString"></param>
        /// <returns></returns>
        public static bool IsSchemaValid(string pConnectionString)
        {
            //Log4Net
            log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

            IDataLayer dl = XpoDefault.GetDataLayer(pConnectionString, AutoCreateOption.None);
            try
            {
                using (Session session = new Session(dl))
                {
                    session.UpdateSchema();
                    return true;
                }
            }
            catch (DevExpress.Xpo.DB.Exceptions.SchemaCorrectionNeededException ex)
            {
                log.Error(string.Format("IsSchemaValid(): [{0}]", ex.Message), ex);
                return false;
            }
        }

        /// <summary>
        /// GetReplaceables for current Database Type
        /// </summary>
        /// <param name="DataBaseType"></param>
        /// <returns></returns>
        public static Dictionary<string, string> GetReplaceables(DatabaseType pDataBaseType)
        {
            //Log4Net
            log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
            Dictionary<string, string> result = new Dictionary<string, string>();

            try
            {
                switch (pDataBaseType)
                {
                    case DatabaseType.MySql:
                        /* IN009024 */
                        result.Add(@"\w", @"\\w");
                        result.Add(@"\d", @"\\d");
                        //result.Add(@"GETDATE()", @"'2018-10-01 23:16:18'");
                        //result.Add(@"\s", @"\\s");
                        break;
                    case DatabaseType.MonoLite:
                    case DatabaseType.SQLite:
                        //connectionstring = string.Format(LogicPOS.Settings.GeneralSettings.Settings["xpoConnectionString"], databaseName);
                        //Replace content - Currently not used, Here only for Example
                        //result.Add("dm.Table", "dm.[Table]");
                        //result.Add("dt.Table", "dt.[Table]");
                        result.Add(@"\\", @"\");
                        result.Add("\\n", "' || CHAR(13) || '");
                        //view_articlestockmovement
                        result.Add("DATE_FORMAT(stk.Date, '%Y-%m-%d') AS stkDateDay,", "strftime('%Y-%m-%d', stk.Date) AS stkDateDay,");
                        //view_systemaudit
                        result.Add("DATE_FORMAT(sau.Date, '%Y-%m-%d') AS sauDateDay,", "strftime('%Y-%m-%d', sau.Date) AS sauDateDay,");
                        //view_systemaudit
                        result.Add("DATE_FORMAT(dmDateStart, '%Y-%m-%d') AS DateDay,", "strftime('%Y-%m-%d', dmDateStart) AS DateDay,");
                        //view_usercommission
                        result.Add("DATE_FORMAT(fmDate, '%Y-%m-%d') AS DateDay,", "strftime('%Y-%m-%d', fmDate) AS DateDay,");
                        //view_articlestocksupplier && view_articlestock
                        result.Add("DATE_FORMAT(stm.Date, '%Y-%m-%d') AS stmDateDay,", "strftime('%Y-%m-%d', stm.Date) AS stmDateDay,");
                        result.Add("DATE_FORMAT(stk.CreatedAt, '%Y-%m-%d') AS stkDateDay,", "strftime('%Y-%m-%d', stk.CreatedAt) AS stkDateDay,");
                        break;
                    case DatabaseType.MSSqlServer:
                        //Replace content
                        result.Add(@"\\", @"\");
                        //Required to Replace with CHAR(13) else nothing seems to work
                        result.Add("\\n", "' + CHAR(13) + '");
                        // view_articlestockmovement
                        // Above SQLServer2008
                        //result.Add("DATE_FORMAT(stk.Date, '%Y-%m-%d') AS stkDateDay,", "FORMAT(stk.Date, 'yyyy-MM-dd', 'en-us') AS stkDateDay,");
                        // Lower SQLServer2008
                        result.Add("DATE_FORMAT(stk.Date, '%Y-%m-%d') AS stkDateDay,", "CONVERT(VARCHAR(19), stk.Date, 23) AS stkDateDay,");
                        // view_systemaudit
                        //result.Add("DATE_FORMAT(sau.Date, '%Y-%m-%d') AS sauDateDay,", "FORMAT(sau.Date, 'yyyy-MM-dd', 'en-us') AS sauDateDay,");
                        // Lower SQLServer2008
                        result.Add("DATE_FORMAT(sau.Date, '%Y-%m-%d') AS sauDateDay,", "CONVERT(VARCHAR(19), sau.Date, 23) AS sauDateDay,");
                        //view_documentfinance
                        result.Add("DATE_FORMAT(dmDateStart, '%Y-%m-%d') AS DateDay,", "CONVERT(VARCHAR(19), dmDateStart, 23) AS DateDay,");
                        //view_usercommission
                        result.Add("DATE_FORMAT(fmDate, '%Y-%m-%d') AS DateDay,", "CONVERT(VARCHAR(19), fmDate, 23) AS DateDay,");
                        //view_articlestocksupplier && view_articlestock
                        result.Add("DATE_FORMAT(stm.Date, '%Y-%m-%d') AS stmDateDay,", "CONVERT(VARCHAR(19), stm.Date, 23) AS stmDateDay,");
                        result.Add("DATE_FORMAT(stk.CreatedAt, '%Y-%m-%d') AS stkDateDay,", "CONVERT(VARCHAR(19), stk.CreatedAt, 23) AS stkDateDay,");
                        break;
                }
            }
            catch (Exception ex)
            {
                log.Error(ex.Message, ex);
            }

            return result;
        }

        private static string ResolveDatabaseScriptPath(string relativePath)
        {
            if (File.Exists(relativePath))
                return relativePath;

            string baseDir = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
            if (!string.IsNullOrEmpty(baseDir))
            {
                string candidate = Path.Combine(baseDir, relativePath.Replace('/', Path.DirectorySeparatorChar));
                if (File.Exists(candidate))
                    return candidate;
            }

            return relativePath;
        }

        private static bool NeedsCisCurrencyPatch(Session xpoSession)
        {
            string[] requiredAcronyms = { "KZT", "RUB", "UAH", "BYN", "KGS", "TJS", "UZS", "AMD", "AZN", "GEL", "MDL", "TMT" };
            foreach (string acronym in requiredAcronyms)
            {
                object count = xpoSession.ExecuteScalar(
                    string.Format("SELECT COUNT(*) FROM cfg_configurationcurrency WHERE Acronym = '{0}';", acronym));
                if (count == null || Convert.ToInt32(count) == 0)
                    return true;
            }

            object eurDesignation = xpoSession.ExecuteScalar(
                "SELECT Designation FROM cfg_configurationcurrency WHERE Acronym = 'EUR' LIMIT 1;");
            string eurName = eurDesignation?.ToString() ?? string.Empty;
            return eurName == "Euro";
        }

        private static string SqlLiteral(string value)
        {
            return (value ?? string.Empty).Replace("'", "''");
        }

        /// <summary>
        /// Inserts missing CIS currencies directly (ProcessDump SQL file can fail silently on INSERT...SELECT).
        /// </summary>
        private static int InsertMissingCisCurrencies(Session xpoSession)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(typeof(DataLayer));
            int inserted = 0;

            string[][] rows =
            {
                new[] { "3f8e1a2b-4c5d-6e7f-8a9b-0c1d2e3f4a5b", "5", "5", "KZT", "520.0000", "Казахстанский тенге", "₸", "Казахстан" },
                new[] { "a1b2c3d4-e5f6-4789-a012-3456789abcde", "640", "640", "RUB", "100.0000", "Российский рубль", "₽", "Россия" },
                new[] { "b2c3d4e5-f6a7-4890-b123-456789abcdef", "650", "650", "UAH", "40.0000", "Украинская гривна", "₴", "Украина" },
                new[] { "c3d4e5f6-a7b8-4901-c234-56789abcdef0", "660", "660", "BYN", "3.2000", "Белорусский рубль", "Br", "Беларусь" },
                new[] { "d4e5f6a7-b8c9-4012-d345-6789abcdef01", "670", "670", "KGS", "90.0000", "Киргизский сом", "с", "Киргизия" },
                new[] { "e5f6a7b8-c9d0-4123-e456-789abcdef012", "680", "680", "TJS", "11.0000", "Таджикский сомони", "SM", "Таджикистан" },
                new[] { "f6a7b8c9-d0e1-4234-f567-89abcdef0123", "690", "690", "UZS", "12500.0000", "Узбекский сум", "сўм", "Узбекистан" },
                new[] { "a7b8c9d0-e1f2-4345-a678-9abcdef01234", "700", "700", "AMD", "400.0000", "Армянский драм", "֏", "Армения" },
                new[] { "b8c9d0e1-f2a3-4456-b789-abcdef012345", "710", "710", "AZN", "1.7000", "Азербайджанский манат", "₼", "Азербайджан" },
                new[] { "c9d0e1f2-a3b4-4567-c89a-bcdef0123456", "720", "720", "GEL", "2.7000", "Грузинский лари", "₾", "Грузия" },
                new[] { "d0e1f2a3-b4c5-4678-d9ab-cdef01234567", "730", "730", "MDL", "18.0000", "Молдавский лей", "L", "Молдова" },
                new[] { "e1f2a3b4-c5d6-4789-eabc-def012345678", "740", "740", "TMT", "3.5000", "Туркменский манат", "m", "Туркменистан" },
            };

            foreach (string[] row in rows)
            {
                string acronym = row[3];
                object count = xpoSession.ExecuteScalar(
                    string.Format("SELECT COUNT(*) FROM cfg_configurationcurrency WHERE Acronym = '{0}';", acronym));
                if (count != null && Convert.ToInt32(count) > 0)
                    continue;

                string sql = string.Format(
                    "INSERT INTO cfg_configurationcurrency (Oid, Ord, Code, Acronym, ExchangeRate, Designation, Symbol, Entity) " +
                    "VALUES ('{0}', {1}, {2}, '{3}', {4}, '{5}', '{6}', '{7}');",
                    row[0], row[1], row[2], row[3], row[4],
                    SqlLiteral(row[5]), SqlLiteral(row[6]), SqlLiteral(row[7]));

                try
                {
                    xpoSession.ExecuteNonQuery(sql);
                    inserted++;
                    log.Info("InsertMissingCisCurrencies: inserted " + acronym);
                }
                catch (Exception ex)
                {
                    log.Error("InsertMissingCisCurrencies: failed to insert " + acronym + ": " + ex.Message, ex);
                }
            }

            if (inserted > 0)
            {
                try
                {
                    xpoSession.ExecuteNonQuery(
                        "UPDATE cfg_configurationcurrency SET Disabled = NULL, DeletedAt = NULL " +
                        "WHERE Acronym IN ('KZT','RUB','UAH','BYN','KGS','TJS','UZS','AMD','AZN','GEL','MDL','TMT');");
                    xpoSession.ExecuteNonQuery(
                        "UPDATE cfg_configurationcurrency SET Ord = 5, Code = 5 WHERE Acronym = 'KZT';");
                }
                catch (Exception ex)
                {
                    log.Error("InsertMissingCisCurrencies: post-insert update failed: " + ex.Message, ex);
                }
            }

            return inserted;
        }

        /// <summary>
        /// Called on every startup after XPO session is ready — ensures CIS currencies exist in the live database.
        /// </summary>
        public static void ApplyCisCurrencyStartupPatch(Session xpoSession, DatabaseType databaseType)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(typeof(DataLayer));

            try
            {
                string culture = GeneralSettings.Settings["customCultureResourceDefinition"] ?? string.Empty;
                if (!culture.StartsWith("ru", StringComparison.OrdinalIgnoreCase))
                    return;

                int inserted = InsertMissingCisCurrencies(xpoSession);
                if (inserted > 0)
                    log.Info(string.Format("ApplyCisCurrencyStartupPatch: inserted {0} CIS currencies", inserted));

                if (!NeedsCisCurrencyPatch(xpoSession))
                    return;

                Dictionary<string, string> replace = GetReplaceables(databaseType);
                string sqlFile = ResolveDatabaseScriptPath(
                    Path.Combine(POSSettings.FileDatabaseOtherCommon, "Common", "configurationcurrency_ru.sql"));
                if (!File.Exists(sqlFile))
                {
                    log.Warn("ApplyCisCurrencyStartupPatch: file not found: " + sqlFile);
                    return;
                }

                log.Info("ApplyCisCurrencyStartupPatch: applying Russian currency labels from " + sqlFile);
                ProcessDump(xpoSession, sqlFile, ";", replace);
            }
            catch (Exception ex)
            {
                log.Error("ApplyCisCurrencyStartupPatch: " + ex.Message, ex);
            }
        }

        private static void ApplyRussianCurrencyNamesViaSql(Session xpoSession, DatabaseType databaseType, Dictionary<string, string> replace)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(typeof(DataLayer));

            InsertMissingCisCurrencies(xpoSession);

            if (!NeedsCisCurrencyPatch(xpoSession))
                return;

            string sqlFile = ResolveDatabaseScriptPath(
                Path.Combine(POSSettings.FileDatabaseOtherCommon, "Common", "configurationcurrency_ru.sql"));
            if (!File.Exists(sqlFile))
            {
                log.Warn("ApplyRussianCurrencyNamesIfNeeded: file not found: " + sqlFile);
                return;
            }

            log.Info("ApplyRussianCurrencyNamesIfNeeded: applying CIS currency patch from " + sqlFile);
            ProcessDump(xpoSession, sqlFile, ";", replace);
        }

        /// <summary>
        /// One-time patch for ru-RU installs created before Russian country seed data existed.
        /// </summary>
        private static void ApplyRussianCountryNamesIfNeeded(Session xpoSession, DatabaseType databaseType, Dictionary<string, string> replace)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(typeof(DataLayer));

            try
            {
                string culture = GeneralSettings.Settings["customCultureResourceDefinition"] ?? string.Empty;
                if (!culture.StartsWith("ru", StringComparison.OrdinalIgnoreCase))
                    return;

                string probeSql = databaseType == DatabaseType.MSSqlServer
                    ? "SELECT TOP 1 Designation FROM cfg_configurationcountry WHERE Code2 = 'DE';"
                    : "SELECT Designation FROM cfg_configurationcountry WHERE Code2 = 'DE' LIMIT 1;";

                object designation = xpoSession.ExecuteScalar(probeSql);
                string deName = designation?.ToString() ?? string.Empty;
                if (deName != "Germany" && deName != "Alemanha" && deName != "Германия")
                    return;

                string sqlFile = ResolveDatabaseScriptPath(
                    Path.Combine(POSSettings.FileDatabaseOtherCommon, "Common", "configurationcountry_ru.sql"));
                if (!File.Exists(sqlFile))
                {
                    log.Warn("ApplyRussianCountryNamesIfNeeded: file not found: " + sqlFile);
                    return;
                }

                log.Info("ApplyRussianCountryNamesIfNeeded: applying Russian country names");
                ProcessDump(xpoSession, sqlFile, ";", replace);
            }
            catch (Exception ex)
            {
                log.Error("ApplyRussianCountryNamesIfNeeded: " + ex.Message, ex);
            }
        }

        /// <summary>
        /// One-time patch for ru-RU installs with English/Portuguese currency names in reference data.
        /// </summary>
        private static void ApplyRussianCurrencyNamesIfNeeded(Session xpoSession, DatabaseType databaseType, Dictionary<string, string> replace)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(typeof(DataLayer));

            try
            {
                string culture = GeneralSettings.Settings["customCultureResourceDefinition"] ?? string.Empty;
                if (!culture.StartsWith("ru", StringComparison.OrdinalIgnoreCase))
                    return;

                ApplyRussianCurrencyNamesViaSql(xpoSession, databaseType, replace);
            }
            catch (Exception ex)
            {
                log.Error("ApplyRussianCurrencyNamesIfNeeded: " + ex.Message, ex);
            }
        }

        /// <summary>
        /// Process filepath/filename script
        /// </summary>
        /// <param name="Session"></param>
        /// <param name="Filename"></param>
        /// <param name="CommandSeparator"></param>
        /// <param name="Replace"></param>
        /// <returns></returns>
        public static bool ProcessDump(Session pXpoSession, string pFilename, string pCommandSeparator, Dictionary<string, string> pReplaceables)
        {
            //Log4Net
            log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

            log.Debug(string.Format("bool ProcessDump(Session pXpoSession, string pFilename, string pCommandSeparator, Dictionary<string, string> pReplaceables) :: ProcessDump Filename: [{0}]", pFilename));

            try
            {



                if (File.Exists(pFilename))
                {
                    //Get Script Content (UTF-8 for Russian seed/migration scripts)
                    string script = File.ReadAllText(pFilename, System.Text.Encoding.UTF8) + "\r\n";

                    //Replace Content before Process
                    if (pReplaceables.Count > 0)
                    {
                        foreach (KeyValuePair<string, string> item in pReplaceables)
                        {
                            script = script.Replace(item.Key, item.Value);
                        }
                    }

                    //if (pFilename.Equals("Resources/Database/databasedata.sql"))
                    //{
                    //    log.Debug("DEBUG");
                    //}

                    object result;
                    string executeCommand;
                    string[] commandSeparators = new string[] { pCommandSeparator };
                    string[] commands;
                    commands = script.Split(commandSeparators, StringSplitOptions.RemoveEmptyEntries);

                    for (int i = 0; i < commands.Length - 1; i++)
                    {
                        //CarriageReturn \r\n = 
                        executeCommand = string.Format("{0};", LogicPOS.Utility.StringUtils.RemoveCarriageReturnAndExtraWhiteSpaces(commands[i]));
                        //Replace \n (Multiline Text like SEND_MAIL_FINANCE_DOCUMENTS_BODY)
                        executeCommand = executeCommand.Replace("\\n", Environment.NewLine);

                        //TODO: Muga melhorar isto : Move it to Replacable in DataBase Type in a Dynamic Value Action
                        executeCommand = executeCommand.Replace("</NEWGUI>", Guid.NewGuid().ToString());

                        // Helper to debug pReplaceables
                        //if (executeCommand.Contains("DATE_FORMAT"))
                        //if (executeCommand.Contains("3f3c562c-850d-452c-af1a-41f9c9e9c89e"))
                        //{
                        //    executeCommand = executeCommand.Replace("\\n", Environment.NewLine);
                        //    log.Debug("DEBUG");
                        //}

                        if (executeCommand != string.Empty && executeCommand != "\r\n" && !executeCommand.StartsWith("--"))
                        {
                            log.Debug(string.Format("{0}/{1}> [{2}]", i + 1, commands.Length - 1, executeCommand));
                            try
                            {
                                //If alter Table Query get table and column affected
                                var output = System.Text.RegularExpressions.Regex.Replace(executeCommand.Split()[0], @"[^0-9a-zA-Z\ ]+", "");
                                if (output == "alter")
                                {
                                    try
                                    {
                                        string table = executeCommand.Split('[', ']')[1];
                                        string commandSql = executeCommand.Split('[', ']')[2];
                                        string column = executeCommand.Split('[', ']')[3];
                                        string columnType = executeCommand.Split('[', ']')[4];
                                        bool columExists = isColumnExists(table, column, pXpoSession);
                                        if (!columExists && commandSql == " ADD ")
                                        {
                                            string sqlCommandAfter = "alter table " + table + " ADD " + column + columnType;
                                            result = pXpoSession.ExecuteNonQuery(sqlCommandAfter);
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        log.Error(string.Format("Error trying to split command : {0}", ex.Message), ex);
                                    }

                                }
                                else
                                {
                                    result = pXpoSession.ExecuteNonQuery(executeCommand);
                                }
                            }
                            catch (Exception ex)
                            {


                                string errorMessage = string.Format("bool ProcessDump(Session pXpoSession, string pFilename, string pCommandSeparator, Dictionary<string, string> pReplaceables) :: Error executing Sql Command: [{0}]{1}Exception: [{2}]", executeCommand, Environment.NewLine, ex.Message);
                                log.Error(string.Format("{0} : {1}", errorMessage, ex.Message), ex);
                                //Utils.ShowMessageTouch(null, DialogFlags.Modal, new Size(800, 400), MessageType.Error, ButtonsType.Ok, CultureResources.GetCustomResources(LogicPOS.Settings.CultureSettings.CurrentCultureName, "global_error"), errorMessage);
                                /* IN009021 */
                                //pXpoSession.RollbackTransaction();
                                //return false;
                            };
                        };
                    }
                }

                return true;
            }
            catch (Exception Ex)
            {
                log.Error(Ex.Message);
                return false;
            }
        }

        /// <summary>
        /// Check if column exists when alter table
        /// </summary>
        /// <param name="table"></param>
        /// <param name="column"></param>
        /// <returns></returns>
        public static bool isColumnExists(string table, string column, Session pXpoSession)
        {
            try
            {
                string query = string.Format("Select " + column + " From " + table);
                var result = pXpoSession.ExecuteQuery(query);
                if (result != null)
                {
                    return true;
                }
                else
                {
                    return false;
                }

            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// Process all scripts in target directory
        /// </summary>
        /// <param name="Session"></param>
        /// <param name="DatabaseType"></param>
        /// <param name="CommandSeparator"></param>
        /// <param name="TargetDirectory"></param>
        /// <returns></returns>
        /// 
        public static bool ProcessDumpDirectory(Session pXpoSession, string pTargetDirectory, string pCommandSeparator, Dictionary<string, string> pReplaceables)
        {
            //Log4Net
            log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

            //Start True
            bool result = true;
            string[] filesArray = null;

            //Ignores files if 
            List<string> ignoreFilesForDeveloper = new List<string>();
            if (Debugger.IsAttached == true)
            {
                //IgnoreClean Preference Parameter
                ignoreFilesForDeveloper.Add(@"Resources/Database/Other/configurationpreferenceparameter.sql");
            }

            try
            {
                if (Directory.Exists(pTargetDirectory))
                {
                    filesArray = Directory.GetFiles(pTargetDirectory, "*.sql");
                }

                //Process Files
                if (filesArray != null && filesArray.Length > 0)
                {
                    for (int i = 0; i < filesArray.Length; i++)
                    {
                        if (result)
                        {
                            //Ignore File if is in ignoreFilesForDeveloper List
                            if (!ignoreFilesForDeveloper.Contains(filesArray[i]))
                            {
                                result = ProcessDump(pXpoSession,filesArray[i], pCommandSeparator, pReplaceables);
                            }
                        }
                    }
                };
            }
            catch (Exception ex)
            {
                log.Error(ex.Message, ex);
            }

            return result;
        }

        /// <summary>
        /// Creates the SQL query for when retrieving linked documents.
        /// The parameter defines financial documents or payment documents.
        /// </summary>
        /// <param name="isPaymentDoc"></param>
        /// <returns></returns>
        public static string GenerateRelatedDocumentsQuery(bool isPaymentDoc = false)
        {
            string relatedDocumentsQuery = string.Empty;

            switch (DatabaseSettings.DatabaseType)
            {
                case DatabaseType.MySql:
                case DatabaseType.SQLite:
                case DatabaseType.MonoLite:
                    if (isPaymentDoc)
                    {
                        relatedDocumentsQuery = @"
SELECT 
    GROUP_CONCAT(DISTINCT DocFinMaster.DocumentNumber) AS ResultConcat
FROM 
	fin_documentfinancemasterpayment AS DocFinMasterPay
LEFT JOIN 
	fin_documentfinancemaster AS DocFinMaster 
        ON (DocFinMasterPay.DocumentFinanceMaster = DocFinMaster.Oid)
WHERE
    DocFinMasterPay.DocumentFinancePayment = '{0}'
GROUP BY
    DocFinMasterPay.DocumentFinancePayment;
";
                    }
                    else
                    {
                        /*  
                         SELECT 
    GROUP_CONCAT(DISTINCT DocumentNumber) AS ResultConcat
FROM
    view_documentfinancerelateddocumentlist
WHERE 
    DocumentParent = '{0}'
    OR
        DocumentChild = '{0}'
GROUP BY
    DocumentParent, DocumentChild
ORDER BY
    Date ASC;
                         
                         */
                        /* IN009157 */
                        relatedDocumentsQuery = @"
SELECT 
    GROUP_CONCAT(DISTINCT RelatedDocument.DocumentNumber) AS ResultConcat
FROM(
	SELECT
		DocFinMaster.DocumentNumber AS DocumentNumber,
		DocFinMaster.Date AS Date,
		DocFinMaster.DocumentParent AS DocumentParent,
		DocFinMaster.DocumentChild AS DocumentChild
	FROM
		fin_documentfinancemaster AS DocFinMaster
	WHERE
		DocFinMaster.DocumentStatusStatus <> 'A'
		AND (
			DocFinMaster.DocumentParent = '{0}'
			OR
				DocFinMaster.DocumentChild = '{0}'
				OR 
					DocFinMaster.Oid IN (
						SELECT 
							(SELECT B.Oid FROM fin_documentfinancemaster B WHERE B.Oid =  A.DocumentParent) AS DocumentParent
						FROM 
							fin_documentfinancemaster AS A
						WHERE
							A.Oid = '{0}'
					)
		)
	UNION
	SELECT
		DocFinPay.PaymentRefNo AS DocumentNumber,
		DocFinPay.DocumentDate AS Date,
		DocFinMasterPay.DocumentFinanceMaster AS DocumentParent,
		NULL AS DocumentChild
	FROM
		fin_documentfinancepayment AS DocFinPay
	LEFT JOIN fin_documentfinancemasterpayment DocFinMasterPay ON (DocFinPay.Oid = DocFinMasterPay.DocumentFinancePayment)
	WHERE
		DocFinPay.PaymentStatus <> 'A'
		AND
			DocFinMasterPay.DocumentFinanceMaster = '{0}'
) AS RelatedDocument;
";
                    }
                    break;
                case DatabaseType.MSSqlServer:
                    if (isPaymentDoc)
                    {
                        relatedDocumentsQuery = @"
DECLARE @RelatedToPayDocuments VARCHAR(MAX);
SELECT
	@RelatedToPayDocuments = COALESCE(@RelatedToPayDocuments + ', ', '') + DocFinMaster.DocumentNumber
FROM 
	fin_documentfinancemasterpayment AS DocFinMasterPay
LEFT JOIN 
	fin_documentfinancemaster AS DocFinMaster 
        ON (DocFinMasterPay.DocumentFinanceMaster = DocFinMaster.Oid)
WHERE
    DocFinMasterPay.DocumentFinancePayment = '{0}'
ORDER BY
	DocFinMaster.Date ASC;
SELECT 
    @RelatedToPayDocuments;
";
                    }
                    else
                    {
                        /*
                                                relatedDocumentsQuery = @"
                        DECLARE @RelatedDocuments VARCHAR(MAX);
                        SELECT
                            @RelatedDocuments = COALESCE(@RelatedDocuments + ', ', '') + DocumentNumber
                        FROM
                            view_documentfinancerelateddocumentlist
                        WHERE
                            DocumentParent = '{0}'
                            OR
                                DocumentChild = '{0}'
                        ORDER BY 
                            Date ASC;
                        SELECT 
                            @RelatedDocuments;";
                        */
                        /* IN009157 - removing "view_documentfinancerelateddocumentlist" call and 
                         * implementing a new flow to retrieve all the children of a parent that has more than 1 child. 
                         * fin_documentfinancemaster.DocumentChild stores the last child only...
                         */
                        relatedDocumentsQuery = @"
DECLARE @RelatedDocuments VARCHAR(MAX);
SELECT
    @RelatedDocuments = COALESCE(@RelatedDocuments + ', ', '') + RelatedDocument.DocumentNumber
FROM(
	SELECT
		DocFinMaster.DocumentNumber AS DocumentNumber,
		DocFinMaster.Date AS Date,
		DocFinMaster.DocumentParent AS DocumentParent,
		DocFinMaster.DocumentChild AS DocumentChild
	FROM
		fin_documentfinancemaster AS DocFinMaster
	WHERE
		DocFinMaster.DocumentStatusStatus <> 'A'
		AND (
			DocFinMaster.DocumentParent = '{0}'
			OR
				DocFinMaster.DocumentChild = '{0}'
				OR 
					DocFinMaster.Oid IN (
						SELECT 
							(SELECT B.Oid FROM fin_documentfinancemaster B WHERE B.Oid =  A.DocumentParent) AS DocumentParent
						FROM 
							fin_documentfinancemaster AS A
						WHERE
							A.Oid = '{0}'
					)
		)
	UNION
	SELECT
		DocFinPay.PaymentRefNo AS DocumentNumber,
		DocFinPay.DocumentDate AS Date,
		DocFinMasterPay.DocumentFinanceMaster AS DocumentParent,
		NULL AS DocumentChild
	FROM
		fin_documentfinancepayment AS DocFinPay
	LEFT JOIN fin_documentfinancemasterpayment DocFinMasterPay ON (DocFinPay.Oid = DocFinMasterPay.DocumentFinancePayment)
	WHERE
		DocFinPay.PaymentStatus <> 'A'
		AND
			DocFinMasterPay.DocumentFinanceMaster = '{0}'
) AS RelatedDocument

ORDER BY 
    RelatedDocument.Date ASC;
SELECT 
    @RelatedDocuments;
";
                    }
                    break;
                default:
                    break;
            }
            return relatedDocumentsQuery;
        }
    }
}