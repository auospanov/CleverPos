using Gtk;
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

            string baseUrl = (ReadSetting("licenseApiBaseUrl") ?? string.Empty).Trim().TrimEnd('/');
            string licenseKey = (ReadSetting("licenseKey") ?? string.Empty).Trim();
            if (string.IsNullOrWhiteSpace(baseUrl) || string.IsNullOrWhiteSpace(licenseKey))
            {
                _logger.Error("Online license check is enabled but licenseApiBaseUrl or licenseKey is empty.");
                ShowDenied(GetResource("dialog_message_license_online_denied",
                    "License is invalid or this computer is not registered. The application will close."));
                return false;
            }

            string computerId = ResolveComputerId();
            if (string.IsNullOrWhiteSpace(computerId))
            {
                _logger.Error("Online license check could not resolve computer id.");
                ShowDenied(GetResource("dialog_message_license_online_denied",
                    "License is invalid or this computer is not registered. The application will close."));
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

                var payload = new ValidateRequestDto
                {
                    licenseKey = licenseKey,
                    computerId = computerId,
                    machineName = Environment.MachineName
                };

                string json = new JavaScriptSerializer().Serialize(payload);
                byte[] body = Encoding.UTF8.GetBytes(json);

                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(baseUrl + "/api/licenses/validate");
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
                    if (IsAllowed(responseBody))
                    {
                        _logger.Info("Online license check passed for computer " + computerId);
                        return true;
                    }

                    _logger.Warn("Online license check denied: " + responseBody);
                    ShowDenied(GetResource("dialog_message_license_online_denied",
                        "License is invalid or this computer is not registered. The application will close."));
                    return false;
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

                    _logger.Warn("Online license check HTTP " + (int)errorResponse.StatusCode + ": " + responseBody);
                    ShowDenied(GetResource("dialog_message_license_online_denied",
                        "License is invalid or this computer is not registered. The application will close."));
                    return false;
                }

                _logger.Error("Online license server unavailable: " + ex.Message, ex);
                ShowDenied(GetResource("dialog_message_license_online_unavailable",
                    "License server is unavailable. Check the network and try again."));
                return false;
            }
            catch (Exception ex)
            {
                _logger.Error("Online license check failed: " + ex.Message, ex);
                ShowDenied(GetResource("dialog_message_license_online_unavailable",
                    "License server is unavailable. Check the network and try again."));
                return false;
            }
        }

        private static bool IsAllowed(string responseBody)
        {
            if (string.IsNullOrWhiteSpace(responseBody))
            {
                return false;
            }

            try
            {
                ValidateResponseDto dto = new JavaScriptSerializer().Deserialize<ValidateResponseDto>(responseBody);
                if (dto != null)
                {
                    return dto.allowed;
                }
            }
            catch
            {
            }

            return responseBody.Replace(" ", string.Empty).IndexOf("\"allowed\":true", StringComparison.OrdinalIgnoreCase) >= 0;
        }

        private static string ResolveComputerId()
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

            if (!string.IsNullOrWhiteSpace(LicenseSettings.LicenseHardwareId))
            {
                return LicenseSettings.LicenseHardwareId.Trim();
            }

            return Environment.MachineName;
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

        private class ValidateRequestDto
        {
            public string licenseKey { get; set; }
            public string computerId { get; set; }
            public string machineName { get; set; }
        }

        private class ValidateResponseDto
        {
            public bool allowed { get; set; }
            public string message { get; set; }
        }
    }
}
