using System;
using System.Collections;
using System.IO;

namespace LogicPOS.Settings
{
    public static class PathsSettings
    {
        public static Hashtable Paths { get; set; }

        public static string TempFolderLocation => Paths["temp"].ToString();
        public static string ImagesFolderLocation => Paths["images"].ToString();
        public static string BackupsFolderLocation => Paths["backups"].ToString();
        public static string ResourcesFolderLocation => Paths["resources"].ToString();

        public static void InitializePaths()
        {
            Paths = new Hashtable
            {
                { "assets", GeneralSettings.Settings["pathAssets"] },
                { "images", GeneralSettings.Settings["pathImages"] },
                { "keyboards", GeneralSettings.Settings["pathKeyboards"] },
                { "themes", GeneralSettings.Settings["pathThemes"] },
                { "sounds", GeneralSettings.Settings["pathSounds"] },
                { "resources", GeneralSettings.Settings["pathResources"] },
                { "reports", GeneralSettings.Settings["pathReports"] },
                { "temp", GeneralSettings.Settings["pathTemp"] },
                { "cache", GeneralSettings.Settings["pathCache"] },
                { "plugins", GeneralSettings.Settings["pathPlugins"] },
                { "documents", GeneralSettings.Settings["pathDocuments"] },
                { "certificates", GeneralSettings.Settings["pathCertificates"] }
            };

            Directory.CreateDirectory(Convert.ToString(Paths["temp"]));
            Directory.CreateDirectory(Convert.ToString(Paths["cache"]));
            Directory.CreateDirectory(Convert.ToString(Paths["documents"]));
            Directory.CreateDirectory($@"{ResourcesFolderLocation}Database\Other");
            Directory.CreateDirectory(string.Format(@"{0}Database\{1}\Other", ResourcesFolderLocation, GeneralSettings.Settings["databaseType"], @"Database\MSSqlServer"));
            Directory.CreateDirectory(string.Format(@"{0}Database\{1}\Other", ResourcesFolderLocation, GeneralSettings.Settings["databaseType"], @"Database\SQLite"));
            Directory.CreateDirectory(string.Format(@"{0}Database\{1}\Other", ResourcesFolderLocation, GeneralSettings.Settings["databaseType"], @"Database\MySql"));
        }

        public static void InitializePreferencesPaths()
        {
            // Defaults match databasedata seed; missing keys happen on incomplete/corrupt DB after failed migrations
            string backups = GetPreferencePathOrDefault("PATH_BACKUPS", "Backups");
            string saftpt = GetPreferencePathOrDefault("PATH_SAFTPT", "Temp");

            Paths.Add("backups", backups.TrimEnd('/', '\\') + "/");
            Paths.Add("saftpt", saftpt.TrimEnd('/', '\\') + "/");

            Directory.CreateDirectory(Convert.ToString(BackupsFolderLocation));
            Directory.CreateDirectory(Convert.ToString(Paths["saftpt"]));
        }

        private static string GetPreferencePathOrDefault(string key, string defaultValue)
        {
            if (GeneralSettings.PreferenceParameters != null
                && GeneralSettings.PreferenceParameters.TryGetValue(key, out string value)
                && !string.IsNullOrWhiteSpace(value))
            {
                return value;
            }

            return defaultValue;
        }
    }
}
