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
                        ApplyStockDocumentModesIfNeeded(xpoSession);
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
                        ApplyStockDocumentModesIfNeeded(xpoSession);

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

            try
            {
                // SQLite seed historically created iLocation_fin_articlewarehouse on Warehouse;
                // XPO expects it on Location. Drop the mismatched name so SchemaOnly can recreate it.
                EnsureSqliteArticleWarehouseLocationIndex(pConnectionString, log);

                IDataLayer dl = XpoDefault.GetDataLayer(pConnectionString, AutoCreateOption.None);
                using (Session session = new Session(dl))
                {
                    session.UpdateSchema();
                    return true;
                }
            }
            catch (DevExpress.Xpo.DB.Exceptions.SchemaCorrectionNeededException ex)
            {
                log.Warn(string.Format("IsSchemaValid(): schema correction needed, applying: [{0}]", ex.Message), ex);

                try
                {
                    EnsureSqliteArticleWarehouseLocationIndex(pConnectionString, log);

                    IDataLayer dlUpdate = XpoDefault.GetDataLayer(pConnectionString, AutoCreateOption.SchemaOnly);
                    using (Session session = new Session(dlUpdate))
                    {
                        session.UpdateSchema();
                    }

                    IDataLayer dlVerify = XpoDefault.GetDataLayer(pConnectionString, AutoCreateOption.None);
                    using (Session session = new Session(dlVerify))
                    {
                        session.UpdateSchema();
                    }

                    log.Info("IsSchemaValid(): schema correction applied successfully");
                    return true;
                }
                catch (Exception applyEx)
                {
                    log.Error(string.Format("IsSchemaValid(): failed to apply schema correction: [{0}]", applyEx.Message), applyEx);
                    return false;
                }
            }
            catch (Exception ex)
            {
                log.Error(string.Format("IsSchemaValid(): [{0}]", ex.Message), ex);
                return false;
            }
        }

        /// <summary>
        /// Fixes legacy SQLite index name clash that blocks XPO UpdateSchema when adding new tables.
        /// </summary>
        private static void EnsureSqliteArticleWarehouseLocationIndex(string pConnectionString, log4net.ILog log)
        {
            if (string.IsNullOrEmpty(pConnectionString) ||
                pConnectionString.IndexOf("SQLite", StringComparison.OrdinalIgnoreCase) < 0)
            {
                return;
            }

            try
            {
                IDataLayer dl = XpoDefault.GetDataLayer(pConnectionString, AutoCreateOption.None);
                using (Session session = new Session(dl))
                {
                    object sql = session.ExecuteScalar(
                        "SELECT sql FROM sqlite_master WHERE type='index' AND name='iLocation_fin_articlewarehouse'");
                    string indexSql = sql as string;
                    if (string.IsNullOrEmpty(indexSql))
                    {
                        return;
                    }

                    // Wrong seed: ... on [fin_articlewarehouse]([Warehouse])
                    // Correct XPO: ... on [fin_articlewarehouse]([Location])
                    if (indexSql.IndexOf("([Location])", StringComparison.OrdinalIgnoreCase) >= 0 ||
                        indexSql.IndexOf("(Location)", StringComparison.OrdinalIgnoreCase) >= 0)
                    {
                        return;
                    }

                    log.Warn(string.Format(
                        "EnsureSqliteArticleWarehouseLocationIndex(): dropping mismatched index definition: [{0}]",
                        indexSql));
                    session.ExecuteNonQuery("DROP INDEX IF EXISTS [iLocation_fin_articlewarehouse]");
                }
            }
            catch (Exception ex)
            {
                log.Warn(string.Format("EnsureSqliteArticleWarehouseLocationIndex(): skipped: [{0}]", ex.Message), ex);
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

        private const string PaymentTerminalPermissionGroupOid = "4c047b35-8fe5-4a4b-ac6e-59c87e0f760a";
        private const string PaymentTerminalMenuToken = "BACKOFFICE_MAN_CONFIGURATIONPAYMENTTERMINAL_MENU";
        private const string PaymentTerminalGrantSourceToken = "BACKOFFICE_MAN_CONFIGURATIONWEIGHINGMACHINE_MENU";
        private const string PaymentTerminalGrantSourceTokenAlt = "BACKOFFICE_MAN_CONFIGURATIONPRINTERS_MENU";

        /// <summary>
        /// Ensures BackOffice permissions exist for payment terminals (menu + CRUD).
        /// Grants them to profiles that already have device/scales menu access.
        /// </summary>
        public static void EnsurePaymentTerminalPermissions(Session xpoSession)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(typeof(DataLayer));

            try
            {
                string[][] permissionRows =
                {
                    new[] { "f1a2b3c4-d5e6-4f78-9012-3456789abcde", "1320", "1320", "BACKOFFICE_MAN_CONFIGURATIONPAYMENTTERMINAL_CREATE", "BackOffice :: Payment Terminals :: New" },
                    new[] { "f2b3c4d5-e6f7-4089-0123-456789abcdef", "1330", "1330", "BACKOFFICE_MAN_CONFIGURATIONPAYMENTTERMINAL_DELETE", "BackOffice :: Payment Terminals :: Delete" },
                    new[] { "f3c4d5e6-f7a8-4190-1234-56789abcdef0", "1340", "1340", "BACKOFFICE_MAN_CONFIGURATIONPAYMENTTERMINAL_EDIT", "BackOffice :: Payment Terminals :: Edit" },
                    new[] { "f4d5e6f7-a8b9-4201-2345-6789abcdef01", "1350", "1350", PaymentTerminalMenuToken, "BackOffice :: Payment Terminals :: Menu" },
                    new[] { "f5e6f7a8-b9c0-4312-3456-789abcdef012", "1360", "1360", "BACKOFFICE_MAN_CONFIGURATIONPAYMENTTERMINAL_VIEW", "BackOffice :: Payment Terminals :: View" },
                };

                bool createdItems = false;
                foreach (string[] row in permissionRows)
                {
                    object existing = xpoSession.ExecuteScalar(
                        string.Format("SELECT COUNT(*) FROM sys_userpermissionitem WHERE Token = '{0}';", row[3]));
                    if (existing != null && Convert.ToInt32(existing) > 0)
                        continue;

                    string sql = string.Format(
                        "INSERT INTO sys_userpermissionitem (Oid, Ord, Code, Token, Designation, PermissionGroup, Disabled) " +
                        "VALUES ('{0}', {1}, {2}, '{3}', '{4}', '{5}', NULL);",
                        row[0], row[1], row[2], row[3], SqlLiteral(row[4]), PaymentTerminalPermissionGroupOid);
                    xpoSession.ExecuteNonQuery(sql);
                    createdItems = true;
                }

                bool grantedAny = GrantPaymentTerminalPermissionsToDeviceProfiles(xpoSession, permissionRows);

                if (createdItems || grantedAny)
                    log.Info("EnsurePaymentTerminalPermissions: payment terminal permissions updated");
            }
            catch (Exception ex)
            {
                log.Error("EnsurePaymentTerminalPermissions: " + ex.Message, ex);
            }
        }

        private const string KaspiTerminalOid = "7f8e9d0c-1b2a-4c3d-8e7f-6a5b4c3d2e1f";
        private const string KaspiTerminalHost = "192.168.1.249";
        private const string KaspiCardMethodOid = "a8b7c6d5-e4f3-4a2b-9c8d-7e6f5a4b3c2d";
        private const string KaspiQrMethodOid = "b9c8d7e6-f5a4-4b3c-8d9e-0f1a2b3c4d5e";

        /// <summary>
        /// Ensures Kaspi Smart POS terminal exists with shop IP and is enabled,
        /// and that Kaspi payment methods are linked to it (for existing DBs too).
        /// </summary>
        public static void EnsureKaspiPaymentTerminalConfig(Session xpoSession)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(typeof(DataLayer));

            try
            {
                object terminalCount = xpoSession.ExecuteScalar(
                    string.Format("SELECT COUNT(*) FROM sys_configurationpaymentterminal WHERE Oid = '{0}';", KaspiTerminalOid));
                // UseHttps=0 by default: Kaspi HTTP API works unless «Защита интеграции» is enabled on the device.
                if (terminalCount == null || Convert.ToInt32(terminalCount) == 0)
                {
                    xpoSession.ExecuteNonQuery(string.Format(
                        "INSERT INTO sys_configurationpaymentterminal " +
                        "(Oid, Ord, Code, Designation, Brand, Host, Port, PosClientName, UseHttps, Disabled) " +
                        "VALUES ('{0}', 10, 10, 'Kaspi Smart POS', 'KASPI', '{1}', 8080, 'CleverPos-1', 0, 0);",
                        KaspiTerminalOid, KaspiTerminalHost));
                    log.Info("EnsureKaspiPaymentTerminalConfig: inserted Kaspi terminal " + KaspiTerminalHost);
                }
                else
                {
                    xpoSession.ExecuteNonQuery(string.Format(
                        "UPDATE sys_configurationpaymentterminal SET Host = '{0}', Port = 8080, Brand = 'KASPI', Disabled = 0, " +
                        "Designation = 'Kaspi Smart POS', PosClientName = COALESCE(NULLIF(PosClientName, ''), 'CleverPos-1') " +
                        "WHERE Oid = '{1}';",
                        KaspiTerminalHost, KaspiTerminalOid));

                    // Prefer HTTP until first successful token (HTTPS only if «Защита интеграции» is on).
                    xpoSession.ExecuteNonQuery(string.Format(
                        "UPDATE sys_configurationpaymentterminal SET UseHttps = 0 " +
                        "WHERE Oid = '{0}' AND (AccessToken IS NULL OR AccessToken = '');",
                        KaspiTerminalOid));

                    log.Info("EnsureKaspiPaymentTerminalConfig: activated Kaspi terminal " + KaspiTerminalHost);
                }

                EnsureKaspiPaymentMethod(
                    xpoSession,
                    KaspiCardMethodOid,
                    15,
                    "KASPI_CARD",
                    "Kaspi карта",
                    "KC",
                    "pos_button_label_payment_type_kaspi_card",
                    "Icons/icon_pos_payment_type_credit_card.png");

                EnsureKaspiPaymentMethod(
                    xpoSession,
                    KaspiQrMethodOid,
                    25,
                    "KASPI_QR",
                    "Kaspi QR",
                    "KQ",
                    "pos_button_label_payment_type_kaspi_qr",
                    "Icons/icon_pos_payment_type_debit_card.png");

                xpoSession.ExecuteNonQuery(
                    "UPDATE fin_configurationpaymentmethod SET Disabled = 1 WHERE Token IN ('CREDIT_CARD','DEBIT_CARD');");

                EnsureExtraTerminal(
                    xpoSession,
                    "8a9b0c1d-2e3f-4a5b-6c7d-8e9f0a1b2c3d",
                    20,
                    "Halyk POS",
                    "HALYK",
                    "192.168.1.250");

                EnsureExtraTerminal(
                    xpoSession,
                    "9b0c1d2e-3f4a-5b6c-7d8e-9f0a1b2c3d4e",
                    30,
                    "Jusan POS",
                    "JUSAN",
                    "192.168.1.251");

                EnsurePaymentMethodLinked(
                    xpoSession,
                    "c1d2e3f4-a5b6-4c7d-8e9f-0a1b2c3d4e5f",
                    16,
                    "HALYK_CARD",
                    "Halyk карта",
                    "HC",
                    "pos_button_label_payment_type_halyk_card",
                    "Icons/icon_pos_payment_type_credit_card.png",
                    "8a9b0c1d-2e3f-4a5b-6c7d-8e9f0a1b2c3d",
                    disabled: true);

                EnsurePaymentMethodLinked(
                    xpoSession,
                    "d2e3f4a5-b6c7-4d8e-9f0a-1b2c3d4e5f60",
                    26,
                    "HALYK_QR",
                    "Halyk QR",
                    "HQ",
                    "pos_button_label_payment_type_halyk_qr",
                    "Icons/icon_pos_payment_type_debit_card.png",
                    "8a9b0c1d-2e3f-4a5b-6c7d-8e9f0a1b2c3d",
                    disabled: true);

                EnsurePaymentMethodLinked(
                    xpoSession,
                    "e3f4a5b6-c7d8-4e9f-0a1b-2c3d4e5f6071",
                    17,
                    "JUSAN_CARD",
                    "Jusan карта",
                    "JC",
                    "pos_button_label_payment_type_jusan_card",
                    "Icons/icon_pos_payment_type_credit_card.png",
                    "9b0c1d2e-3f4a-5b6c-7d8e-9f0a1b2c3d4e",
                    disabled: true);

                EnsurePaymentMethodLinked(
                    xpoSession,
                    "f4a5b6c7-d8e9-4f0a-1b2c-3d4e5f607182",
                    27,
                    "JUSAN_QR",
                    "Jusan QR",
                    "JQ",
                    "pos_button_label_payment_type_jusan_qr",
                    "Icons/icon_pos_payment_type_debit_card.png",
                    "9b0c1d2e-3f4a-5b6c-7d8e-9f0a1b2c3d4e",
                    disabled: true);
            }
            catch (Exception ex)
            {
                log.Error("EnsureKaspiPaymentTerminalConfig: " + ex.Message, ex);
            }
        }

        private static void EnsureExtraTerminal(
            Session xpoSession,
            string oid,
            int ordCode,
            string designation,
            string brand,
            string host)
        {
            object count = xpoSession.ExecuteScalar(
                string.Format("SELECT COUNT(*) FROM sys_configurationpaymentterminal WHERE Oid = '{0}';", oid));
            if (count != null && Convert.ToInt32(count) > 0)
            {
                return;
            }

            xpoSession.ExecuteNonQuery(string.Format(
                "INSERT INTO sys_configurationpaymentterminal " +
                "(Oid, Ord, Code, Designation, Brand, Host, Port, PosClientName, UseHttps, Disabled) " +
                "VALUES ('{0}', {1}, {1}, '{2}', '{3}', '{4}', 8080, 'CleverPos-1', 0, 1);",
                oid, ordCode, SqlLiteral(designation), brand, host));
        }

        private static void EnsurePaymentMethodLinked(
            Session xpoSession,
            string oid,
            int ordCode,
            string token,
            string designation,
            string acronym,
            string resourceString,
            string buttonIcon,
            string terminalOid,
            bool disabled)
        {
            object count = xpoSession.ExecuteScalar(
                string.Format("SELECT COUNT(*) FROM fin_configurationpaymentmethod WHERE Oid = '{0}' OR Token = '{1}';", oid, token));
            if (count != null && Convert.ToInt32(count) > 0)
            {
                return;
            }

            xpoSession.ExecuteNonQuery(string.Format(
                "INSERT INTO fin_configurationpaymentmethod " +
                "(Oid, Ord, Code, Token, Designation, Acronym, ResourceString, ButtonIcon, RequiresPaymentTerminal, PaymentTerminal, Disabled) " +
                "VALUES ('{0}', {1}, {1}, '{2}', '{3}', '{4}', '{5}', '{6}', 1, '{7}', {8});",
                oid, ordCode, token, SqlLiteral(designation), SqlLiteral(acronym), resourceString, buttonIcon, terminalOid, disabled ? 1 : 0));
        }

        private static void EnsureKaspiPaymentMethod(
            Session xpoSession,
            string oid,
            int ordCode,
            string token,
            string designation,
            string acronym,
            string resourceString,
            string buttonIcon)
        {
            object count = xpoSession.ExecuteScalar(
                string.Format("SELECT COUNT(*) FROM fin_configurationpaymentmethod WHERE Oid = '{0}' OR Token = '{1}';", oid, token));
            if (count != null && Convert.ToInt32(count) > 0)
            {
                xpoSession.ExecuteNonQuery(string.Format(
                    "UPDATE fin_configurationpaymentmethod SET RequiresPaymentTerminal = 1, PaymentTerminal = '{0}', Disabled = 0, " +
                    "Designation = '{1}', Acronym = '{2}' WHERE Oid = '{3}' OR Token = '{4}';",
                    KaspiTerminalOid, SqlLiteral(designation), SqlLiteral(acronym), oid, token));
                return;
            }

            xpoSession.ExecuteNonQuery(string.Format(
                "INSERT INTO fin_configurationpaymentmethod " +
                "(Oid, Ord, Code, Token, Designation, Acronym, ResourceString, ButtonIcon, RequiresPaymentTerminal, PaymentTerminal, Disabled) " +
                "VALUES ('{0}', {1}, {1}, '{2}', '{3}', '{4}', '{5}', '{6}', 1, '{7}', 0);",
                oid, ordCode, token, SqlLiteral(designation), SqlLiteral(acronym), resourceString, buttonIcon, KaspiTerminalOid));
        }

        private static bool GrantPaymentTerminalPermissionsToDeviceProfiles(Session xpoSession, string[][] permissionRows)
        {
            bool grantedAny = false;
            object profileRows = xpoSession.ExecuteQuery(
                string.Format(
                    "SELECT DISTINCT pp.userprofile FROM sys_userpermissionprofile pp " +
                    "INNER JOIN sys_userpermissionitem pi ON pp.PermissionItem = pi.Oid " +
                    "WHERE pi.Token IN ('{0}', '{1}');",
                    PaymentTerminalGrantSourceToken, PaymentTerminalGrantSourceTokenAlt));

            List<string> profileOids = new List<string>();
            if (profileRows is SelectedData selectedData && selectedData.ResultSet != null && selectedData.ResultSet.Length > 0)
            {
                foreach (var row in selectedData.ResultSet[0].Rows)
                {
                    string userProfileOid = Convert.ToString(row.Values[0]);
                    if (!string.IsNullOrWhiteSpace(userProfileOid))
                        profileOids.Add(userProfileOid);
                }
            }

            if (profileOids.Count == 0)
                profileOids.Add("1626e21f-75e6-429e-b0ac-edb755e733c2");

            foreach (string userProfileOid in profileOids)
            {
                foreach (string[] perm in permissionRows)
                {
                    if (GrantPaymentTerminalPermissionIfMissing(xpoSession, userProfileOid, perm[0]))
                        grantedAny = true;
                }
            }

            return grantedAny;
        }

        private static bool GrantPaymentTerminalPermissionIfMissing(Session xpoSession, string userProfileOid, string permissionItemOid)
        {
            object count = xpoSession.ExecuteScalar(string.Format(
                "SELECT COUNT(*) FROM sys_userpermissionprofile WHERE userprofile = '{0}' AND PermissionItem = '{1}';",
                userProfileOid, permissionItemOid));
            if (count != null && Convert.ToInt32(count) > 0)
                return false;

            string grantOid = Guid.NewGuid().ToString();
            xpoSession.ExecuteNonQuery(string.Format(
                "INSERT INTO sys_userpermissionprofile (Oid, Granted, userprofile, PermissionItem) VALUES ('{0}', 1, '{1}', '{2}');",
                grantOid, userProfileOid, permissionItemOid));
            return true;
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
        /// Ensure credit note (NC) and return slip (GD) put stock back (StockMode = In).
        /// Safe to run on every startup for existing databases.
        /// </summary>
        private static void ApplyStockDocumentModesIfNeeded(Session xpoSession)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
            try
            {
                // ProcessArticleStockMode: None=0, Out=1, In=2
                const string ncOid = "fa924162-beed-4f2f-938d-919deafb7d47";
                const string gdOid = "f03d2788-bed6-41ab-8d44-100039103e83";
                string sql = string.Format(
                    "UPDATE fin_documentfinancetype SET StockMode = 2 WHERE Oid IN ('{0}','{1}') AND (StockMode IS NULL OR StockMode = 0)",
                    ncOid,
                    gdOid);
                object affected = xpoSession.ExecuteNonQuery(sql);
                log.Info("ApplyStockDocumentModesIfNeeded: NC/GD StockMode=In, result=" + affected);
            }
            catch (Exception ex)
            {
                log.Warn("ApplyStockDocumentModesIfNeeded: " + ex.Message);
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