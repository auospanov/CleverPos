using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Diagnostics;
using System.IO;
using System.Reflection;

namespace LogicPOS.Settings
{
    public static class GeneralSettings
    {
        public static string AppTheme = "Default";

        public static NameValueCollection Settings { get; set; }

        public static Dictionary<string, string> PreferenceParameters { get; set; }
        public static string ServerVersion { get; set; }
        /// <summary>Download URL for latest CleverPos package (from License API /api/updates/latest).</summary>
        public static string UpdateDownloadUrl { get; set; }
        public static string UpdateSha256 { get; set; }
        public static string ProductVersion
        {
            get
            {
                Assembly assembly = Assembly.GetEntryAssembly() ?? Assembly.GetExecutingAssembly();
                FileVersionInfo fileVersionInfo = FileVersionInfo.GetVersionInfo(assembly.Location);
                string version = fileVersionInfo.ProductVersion ?? fileVersionInfo.FileVersion ?? "0.0.0";
                if (!version.StartsWith("v", StringComparison.OrdinalIgnoreCase))
                {
                    version = "v" + version;
                }

                return version;
            }
        }
        public static Assembly ProductAssembly
        {
            get
            {
                return Assembly.GetExecutingAssembly();
            }
        }

        /// <summary>
        /// Session file name. Unbound HardwareId ("*") is not a valid Windows filename char —
        /// use LicenseKey (or "unbound") instead.
        /// </summary>
        public static string POSSessionJsonFileName
        {
            get
            {
                string id = SanitizeFileToken(LicenseSettings.LicenseHardwareId);
                if (string.IsNullOrWhiteSpace(id)
                    || id == "*"
                    || string.Equals(id, "UNBOUND", StringComparison.OrdinalIgnoreCase)
                    || id.IndexOfAny(Path.GetInvalidFileNameChars()) >= 0)
                {
                    id = SanitizeFileToken(LicenseSettings.LicenseKey);
                }

                if (string.IsNullOrWhiteSpace(id))
                {
                    id = "unbound";
                }

                return "appsession_" + id + ".json";
            }
        }

        private static string SanitizeFileToken(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                return string.Empty;
            }

            string id = value.Trim();
            char[] invalid = Path.GetInvalidFileNameChars();
            foreach (char c in invalid)
            {
                id = id.Replace(c, '_');
            }

            return id;
        }

        public static System.Drawing.Size ScreenSize { get; set; }
        public static int GetRequiredCustomerDetailsAboveValue(Guid countryId)
        {
            if (CultureSettings.CountryIdIsPortugal(countryId))
            {
                return PluginSettings.HasSoftwareVendorPlugin
                    ? PluginSettings.SoftwareVendor.GetFinanceRuleRequiredCustomerDetailsAboveValue()
                    : 1000;

            }

            return 999999999;
        }
        public static Dictionary<string, bool> LoggedUserPermissions { get; set; }
        public static bool AppUseParkingTicketModule { get; set; } = false;
        public static bool CheckStocks { get; set; } = true;
        public static bool CheckStockMessage { get; set; } = true;
        public static bool AppUseBackOfficeMode { get; set; } = false;
        public static Dictionary<string, Guid> PendentPaidParkingTickets { get; set; } = new Dictionary<string, Guid>();
        public static Dictionary<string, Guid> PendentPaidParkingCards { get; set; } = new Dictionary<string, Guid>();
        public static bool UsePosPDFViewer => Convert.ToBoolean(PreferenceParameters["USE_POS_PDF_VIEWER"]);
        public static bool LoggedUserHasPermissionTo(string permissionToken)
        {
            if (LoggedUserPermissions != null && LoggedUserPermissions.ContainsKey(permissionToken))
            {
                return LoggedUserPermissions[permissionToken];
            }

            return false;
        }

    }
}
