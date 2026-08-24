using Gtk;
using logicpos.App;
using CleverPos.License.Core;
using LogicPOS.Globalization;
using LogicPOS.Settings;
using LogicPOS.Utility;
using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web.Script.Serialization;

namespace logicpos.Classes.Logic.License
{
    /// <summary>
    /// Offline-first: verify signed licence.lic locally; renew via API only when expired/unsigned.
    /// Signing format comes from CleverPos.License.Core (same module as LicenseGenerator / License.Api).
    /// </summary>
    public static class OnlineLicenseGuard
    {
        private static readonly log4net.ILog _logger = log4net.LogManager.GetLogger(typeof(OnlineLicenseGuard));

        public static bool EnsureAllowed()
        {
            string enabledRaw = ReadSetting("licenseApiEnabled");
            if (!string.Equals(enabledRaw, "true", StringComparison.OrdinalIgnoreCase))
            {
                return true;
            }

            string licencePath = ResolveLicenceFilePath();
            if (!File.Exists(licencePath))
            {
                _logger.Error("licence.lic not found: " + licencePath);
                ShowDenied(GetResource("dialog_message_license_online_denied",
                    "License file is missing. The application will close."));
                return false;
            }

            string fileContent;
            try
            {
                fileContent = File.ReadAllText(licencePath, Encoding.UTF8);
            }
            catch (Exception ex)
            {
                _logger.Error("Cannot read licence.lic: " + ex.Message, ex);
                ShowDenied(GetResource("dialog_message_license_online_denied",
                    "License file is missing. The application will close."));
                return false;
            }

            string publicKey = ReadSetting("licensePublicKeyXml");
            if (string.IsNullOrWhiteSpace(publicKey))
            {
                publicKey = LicenseSigningKeys.DefaultPublicKeyXml;
            }

            LicenseReadResult local = LicenseIssueService.VerifyLocal(fileContent, publicKey);
            ApplyPayloadToSettings(local.Payload);

            string computerId = ResolveComputerId(local.Payload);
            if (local.Success && local.SignatureValid && !local.IsExpired)
            {
                bool unbound = LicensePayload.IsUnboundHardwareId(local.Payload != null ? local.Payload.HardwareId : null);
                if (unbound)
                {
                    _logger.Info("Unbound licence.lic — binding this computer via renew.");
                    bool bound = RenewFromServer(licencePath, local.Payload, computerId);
                    if (bound)
                    {
                        TryRefreshAppUpdateInfo();
                        return true;
                    }

                    // Offline bootstrap: allow start until renew can bind HardwareId.
                    _logger.Warn("Unbound license accepted offline; renew when online to lock PC.");
                    ApplyPayloadToSettings(local.Payload);
                    TryRefreshAppUpdateInfo();
                    return true;
                }

                if (!HardwareMatches(local.Payload, computerId))
                {
                    _logger.Error("licence.lic HardwareId does not match this computer.");
                    ShowDenied(GetResource("dialog_message_license_online_denied",
                        "License is bound to another computer."));
                    return false;
                }

                _logger.Info("Offline license OK until " + local.Payload.ValidUntilUtc.ToString("o"));
                TryRefreshAppUpdateInfo();
                return true;
            }

            if (local.HasSignature && !local.SignatureValid)
            {
                ShowDenied(local.Message);
                return false;
            }

            _logger.Info("License renew required: " + local.Message);
            bool renewed = RenewFromServer(licencePath, local.Payload, computerId);
            if (renewed)
            {
                TryRefreshAppUpdateInfo();
            }

            return renewed;
        }

        /// <summary>
        /// Fetches latest CleverPos version from License API and sets GeneralSettings.ServerVersion
        /// so BackOffice can show the update button.
        /// </summary>
        public static void TryRefreshAppUpdateInfo()
        {
            try
            {
                string baseUrl = ResolveLicenseApiBaseUrl();
                if (string.IsNullOrWhiteSpace(baseUrl))
                {
                    return;
                }

                int timeoutMs = 8000;
                int timeoutSeconds;
                if (int.TryParse(ReadSetting("licenseApiTimeoutSeconds"), out timeoutSeconds) && timeoutSeconds > 0)
                {
                    timeoutMs = Math.Min(timeoutSeconds * 1000, 15000);
                }

                ServicePointManager.SecurityProtocol |= SecurityProtocolType.Tls12;

                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(baseUrl + "/api/updates/latest");
                request.Method = "GET";
                request.Timeout = timeoutMs;
                request.ReadWriteTimeout = timeoutMs;

                using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                using (StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
                {
                    string body = reader.ReadToEnd();
                    AppUpdateDto dto = null;
                    try
                    {
                        dto = new JavaScriptSerializer().Deserialize<AppUpdateDto>(body);
                    }
                    catch (Exception ex)
                    {
                        _logger.Warn("App update JSON parse failed: " + ex.Message);
                    }

                    if (dto == null || string.IsNullOrWhiteSpace(dto.version))
                    {
                        return;
                    }

                    GeneralSettings.ServerVersion = dto.version.Trim().TrimStart('v', 'V');
                    GeneralSettings.UpdateDownloadUrl = string.IsNullOrWhiteSpace(dto.downloadUrl)
                        ? null
                        : dto.downloadUrl.Trim();
                    GeneralSettings.UpdateSha256 = string.IsNullOrWhiteSpace(dto.sha256)
                        ? null
                        : dto.sha256.Trim();

                    _logger.Info(string.Format(
                        "App update info: server={0}, local={1}, url={2}",
                        GeneralSettings.ServerVersion,
                        GeneralSettings.ProductVersion,
                        GeneralSettings.UpdateDownloadUrl ?? "(none)"));
                }
            }
            catch (Exception ex)
            {
                _logger.Warn("App update check skipped: " + ex.Message);
            }
        }

        private static bool RenewFromServer(string licencePath, LicensePayload payload, string computerId)
        {
            string baseUrl = ResolveLicenseApiBaseUrl();
            string licenseKey = payload != null && !string.IsNullOrWhiteSpace(payload.LicenseKey)
                ? payload.LicenseKey.Trim()
                : string.Empty;

            if (string.IsNullOrWhiteSpace(licenseKey) && payload != null)
            {
                licenseKey = (payload.HardwareId ?? string.Empty).Trim();
            }

            if (string.IsNullOrWhiteSpace(baseUrl) || string.IsNullOrWhiteSpace(licenseKey) || string.IsNullOrWhiteSpace(computerId))
            {
                ShowDenied(GetResource("dialog_message_license_online_denied",
                    "License expired and cannot renew (missing key or API URL)."));
                return false;
            }

            int timeoutMs = 15000;
            int timeoutSeconds;
            if (int.TryParse(ReadSetting("licenseApiTimeoutSeconds"), out timeoutSeconds) && timeoutSeconds > 0)
            {
                timeoutMs = timeoutSeconds * 1000;
            }

            try
            {
                ServicePointManager.SecurityProtocol |= SecurityProtocolType.Tls12;

                var requestDto = new RenewRequestDto
                {
                    licenseKey = licenseKey,
                    computerId = computerId,
                    machineName = Environment.MachineName,
                    companyName = payload != null ? payload.Company : LicenseSettings.LicenseCompany
                };

                string json = new JavaScriptSerializer().Serialize(requestDto);
                byte[] body = Encoding.UTF8.GetBytes(json);

                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(baseUrl + "/api/licenses/renew");
                request.Method = "POST";
                request.ContentType = "application/json; charset=utf-8";
                request.Timeout = timeoutMs;
                request.ReadWriteTimeout = timeoutMs;
                request.ContentLength = body.Length;

                using (Stream requestStream = request.GetRequestStream())
                {
                    requestStream.Write(body, 0, body.Length);
                }

                using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                using (StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
                {
                    string responseBody = reader.ReadToEnd();
                    RenewResponseDto dto = null;
                    try
                    {
                        dto = new JavaScriptSerializer().Deserialize<RenewResponseDto>(responseBody);
                    }
                    catch
                    {
                    }

                    if (dto == null || !dto.allowed || string.IsNullOrWhiteSpace(dto.licenceFileContent))
                    {
                        ShowDenied(dto != null && !string.IsNullOrWhiteSpace(dto.message)
                            ? dto.message
                            : GetResource("dialog_message_license_online_denied",
                                "License renew was denied."));
                        return false;
                    }

                    string publicKey = ReadSetting("licensePublicKeyXml");
                    if (string.IsNullOrWhiteSpace(publicKey))
                    {
                        publicKey = LicenseSigningKeys.DefaultPublicKeyXml;
                    }

                    LicenseReadResult verify = LicenseIssueService.VerifyLocal(dto.licenceFileContent, publicKey);
                    if (!verify.Success || !verify.SignatureValid)
                    {
                        _logger.Error("Server returned invalid licence file: " + verify.Message);
                        ShowDenied("Сервер вернул недействительный файл лицензии.");
                        return false;
                    }

                    if (!HardwareMatches(verify.Payload, computerId))
                    {
                        ShowDenied("Лицензия привязана к другому компьютеру.");
                        return false;
                    }

                    File.WriteAllText(licencePath, dto.licenceFileContent, Encoding.UTF8);
                    ApplyPayloadToSettings(verify.Payload);
                    try
                    {
                        logicpos.Utils.AssignLicence(licencePath, false);
                    }
                    catch (Exception ex)
                    {
                        _logger.Warn("AssignLicence after renew: " + ex.Message);
                    }

                    _logger.Info("License renewed until " + verify.Payload.ValidUntilUtc.ToString("o"));
                    return true;
                }
            }
            catch (WebException ex)
            {
                HttpWebResponse errorResponse = ex.Response as HttpWebResponse;
                if (errorResponse != null)
                {
                    string responseBody = string.Empty;
                    try
                    {
                        using (StreamReader reader = new StreamReader(errorResponse.GetResponseStream(), Encoding.UTF8))
                        {
                            responseBody = reader.ReadToEnd();
                        }
                    }
                    catch
                    {
                    }

                    string apiMessage = TryReadApiMessage(responseBody);
                    ShowDenied(string.IsNullOrWhiteSpace(apiMessage)
                        ? GetResource("dialog_message_license_online_denied",
                            "License renew was denied.")
                        : apiMessage);
                    return false;
                }

                _logger.Error("License renew unavailable: " + ex.Message, ex);
                ShowDenied(GetResource("dialog_message_license_online_unavailable",
                    "License server is unavailable. Check the network and try again."));
                return false;
            }
            catch (Exception ex)
            {
                _logger.Error("License renew failed: " + ex.Message, ex);
                ShowDenied(GetResource("dialog_message_license_online_unavailable",
                    "License server is unavailable. Check the network and try again."));
                return false;
            }
        }

        private static void ApplyPayloadToSettings(LicensePayload payload)
        {
            if (payload == null)
            {
                return;
            }

            if (!string.IsNullOrWhiteSpace(payload.HardwareId))
            {
                LicenseSettings.LicenseHardwareId = payload.HardwareId;
            }

            if (!string.IsNullOrWhiteSpace(payload.LicenseKey))
            {
                LicenseSettings.LicenseKey = payload.LicenseKey.Trim();
            }

            if (!string.IsNullOrWhiteSpace(payload.Company))
            {
                LicenseSettings.LicenseCompany = payload.Company;
            }
        }

        /// <summary>Public for CloudSyncFlusher / shared clients.</summary>
        public static string GetLicenseApiBaseUrl() => ResolveLicenseApiBaseUrl();

        public static string ReadAppSetting(string key) => ReadSetting(key);

        public static string GetCachedLicenseKey()
        {
            if (!string.IsNullOrWhiteSpace(LicenseSettings.LicenseKey))
            {
                return LicenseSettings.LicenseKey.Trim();
            }

            try
            {
                string licencePath = ResolveLicenceFilePath();
                if (!File.Exists(licencePath))
                {
                    return string.Empty;
                }

                string fileContent = File.ReadAllText(licencePath, Encoding.UTF8);
                string publicKey = ReadSetting("licensePublicKeyXml");
                if (string.IsNullOrWhiteSpace(publicKey))
                {
                    publicKey = LicenseSigningKeys.DefaultPublicKeyXml;
                }

                LicenseReadResult local = LicenseIssueService.VerifyLocal(fileContent, publicKey);
                if (local.Payload != null && !string.IsNullOrWhiteSpace(local.Payload.LicenseKey))
                {
                    LicenseSettings.LicenseKey = local.Payload.LicenseKey.Trim();
                    return LicenseSettings.LicenseKey;
                }
            }
            catch (Exception ex)
            {
                _logger.Warn("GetCachedLicenseKey: " + ex.Message);
            }

            return string.Empty;
        }

        public static string GetCachedComputerId()
        {
            if (!string.IsNullOrWhiteSpace(LicenseSettings.LicenseHardwareId))
            {
                return LicenseSettings.LicenseHardwareId.Trim();
            }

            return ResolveComputerId(null);
        }

        private static bool HardwareMatches(LicensePayload payload, string computerId)
        {
            if (payload == null || string.IsNullOrWhiteSpace(computerId))
            {
                return false;
            }

            if (LicensePayload.IsUnboundHardwareId(payload.HardwareId))
            {
                return true;
            }

            return string.Equals(payload.HardwareId.Trim(), computerId.Trim(), StringComparison.OrdinalIgnoreCase);
        }

        private static string TryReadApiMessage(string responseBody)
        {
            if (string.IsNullOrWhiteSpace(responseBody))
            {
                return string.Empty;
            }

            try
            {
                RenewResponseDto dto = new JavaScriptSerializer().Deserialize<RenewResponseDto>(responseBody);
                if (dto != null && !string.IsNullOrWhiteSpace(dto.message))
                {
                    return dto.message.Trim();
                }
            }
            catch
            {
            }

            return string.Empty;
        }

        private static string ResolveComputerId(LicensePayload payload)
        {
            string fromConfig = ReadSetting("appHardwareId");
            if (!string.IsNullOrWhiteSpace(fromConfig))
            {
                return fromConfig.Trim();
            }

            try
            {
                if (PluginSettings.LicenceManager != null)
                {
                    string hardwareId = PluginSettings.LicenceManager.GetHardwareID();
                    if (!string.IsNullOrWhiteSpace(hardwareId))
                    {
                        return hardwareId.Trim();
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.Warn("GetHardwareID failed: " + ex.Message);
            }

            if (payload != null && !string.IsNullOrWhiteSpace(payload.HardwareId))
            {
                return payload.HardwareId.Trim();
            }

            if (!string.IsNullOrWhiteSpace(LicenseSettings.LicenseHardwareId))
            {
                return LicenseSettings.LicenseHardwareId.Trim();
            }

            return Environment.MachineName;
        }

        private static string ResolveLicenceFilePath()
        {
            string fileName = POSSettings.LicenceFileName;
            var candidates = new System.Collections.Generic.List<string>();
            if (!string.IsNullOrWhiteSpace(fileName))
            {
                candidates.Add(fileName);
            }

            string baseDir = AppDomain.CurrentDomain.BaseDirectory;
            if (!string.IsNullOrWhiteSpace(baseDir))
            {
                DirectoryInfo dir = new DirectoryInfo(baseDir);
                for (int i = 0; i < 5 && dir != null; i++)
                {
                    candidates.Add(Path.Combine(dir.FullName, fileName));
                    dir = dir.Parent;
                }
            }

            foreach (string candidate in candidates)
            {
                try
                {
                    if (File.Exists(candidate))
                    {
                        return Path.GetFullPath(candidate);
                    }
                }
                catch
                {
                }
            }

            return fileName;
        }

        private static string ResolveLicenseApiBaseUrl()
        {
            string environment = (ReadSetting("licenseApiEnvironment") ?? string.Empty).Trim();
            if (string.IsNullOrWhiteSpace(environment))
            {
                environment = "local";
            }

            string configuredUrl;
            if (string.Equals(environment, "production", StringComparison.OrdinalIgnoreCase)
                || string.Equals(environment, "global", StringComparison.OrdinalIgnoreCase)
                || string.Equals(environment, "prod", StringComparison.OrdinalIgnoreCase))
            {
                configuredUrl = ReadSetting("licenseApiProductionUrl");
            }
            else
            {
                configuredUrl = ReadSetting("licenseApiLocalUrl");
            }

            if (string.IsNullOrWhiteSpace(configuredUrl))
            {
                configuredUrl = ReadSetting("licenseApiBaseUrl");
            }

            return (configuredUrl ?? string.Empty).Trim().TrimEnd('/');
        }

        private static string ReadSetting(string key)
        {
            if (GeneralSettings.Settings != null && !string.IsNullOrEmpty(GeneralSettings.Settings[key]))
            {
                return GeneralSettings.Settings[key];
            }

            return System.Configuration.ConfigurationManager.AppSettings[key];
        }

        private static string GetResource(string token, string fallback)
        {
            try
            {
                string value = GeneralUtils.GetResourceByName(token);
                if (!string.IsNullOrWhiteSpace(value) && value != token)
                {
                    return value;
                }
            }
            catch
            {
            }

            try
            {
                string value = CultureResources.GetResourceByLanguage(CultureSettings.CurrentCultureName, token);
                if (!string.IsNullOrWhiteSpace(value) && value != token)
                {
                    return value;
                }
            }
            catch
            {
            }

            return fallback;
        }

        private static void ShowDenied(string message)
        {
            try
            {
                logicpos.Utils.ShowMessageNonTouch(
                    null,
                    DialogFlags.Modal,
                    MessageType.Error,
                    ButtonsType.Ok,
                    message,
                    GeneralUtils.GetResourceByName("global_error"));
            }
            catch (Exception ex)
            {
                _logger.Error("Could not show license dialog: " + ex.Message, ex);
            }
        }

        private class RenewRequestDto
        {
            public string licenseKey { get; set; }
            public string computerId { get; set; }
            public string machineName { get; set; }
            public string companyName { get; set; }
        }

        private class RenewResponseDto
        {
            public bool allowed { get; set; }
            public string message { get; set; }
            public string licenceFileContent { get; set; }
        }

        private class AppUpdateDto
        {
            public string version { get; set; }
            public string downloadUrl { get; set; }
            public string sha256 { get; set; }
            public string releaseNotes { get; set; }
            public bool mandatory { get; set; }
        }
    }
}
