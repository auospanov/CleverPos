using LogicPOS.Data.XPO.Utility;
using LogicPOS.Domain.Entities;
using LogicPOS.Settings;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using System.Threading;
using System.Web.Script.Serialization;

namespace logicpos.Classes.Logic.License
{
    /// <summary>
    /// Background flush of local cloud outbox to License API POST /api/cloud/sync.
    /// </summary>
    public static class CloudSyncFlusher
    {
        private static readonly log4net.ILog _logger = log4net.LogManager.GetLogger(typeof(CloudSyncFlusher));
        private static Thread _thread;
        private static volatile bool _running;
        private static readonly object _gate = new object();

        public static void Start()
        {
            string enabled = OnlineLicenseGuard.ReadAppSetting("cloudSyncEnabled");
            if (!string.Equals(enabled, "true", StringComparison.OrdinalIgnoreCase)
                && !string.Equals(OnlineLicenseGuard.ReadAppSetting("licenseApiEnabled"), "true", StringComparison.OrdinalIgnoreCase))
            {
                _logger.Info("CloudSyncFlusher not started (cloudSyncEnabled/licenseApiEnabled off).");
                return;
            }

            if (!string.Equals(enabled, "true", StringComparison.OrdinalIgnoreCase)
                && string.IsNullOrWhiteSpace(OnlineLicenseGuard.ReadAppSetting("cloudSyncEnabled")))
            {
                // Default on when license API is on
                enabled = "true";
            }

            if (!string.Equals(enabled, "true", StringComparison.OrdinalIgnoreCase))
            {
                return;
            }

            lock (_gate)
            {
                if (_running)
                {
                    return;
                }

                _running = true;
                _thread = new Thread(RunLoop)
                {
                    IsBackground = true,
                    Name = "CloudSyncFlusher"
                };
                _thread.Start();
                _logger.Info("CloudSyncFlusher started.");
            }
        }

        public static void Stop()
        {
            _running = false;
        }

        private static void RunLoop()
        {
            int intervalSec = 30;
            int parsed;
            if (int.TryParse(OnlineLicenseGuard.ReadAppSetting("cloudSyncIntervalSeconds"), out parsed) && parsed >= 5)
            {
                intervalSec = Math.Min(parsed, 300);
            }

            // First pass after short delay so session is ready
            Thread.Sleep(8000);

            while (_running)
            {
                try
                {
                    FlushOnce();
                }
                catch (Exception ex)
                {
                    _logger.Warn("CloudSyncFlusher tick: " + ex.Message);
                }

                for (int i = 0; i < intervalSec && _running; i++)
                {
                    Thread.Sleep(1000);
                }
            }
        }

        public static void FlushOnce()
        {
            string baseUrl = OnlineLicenseGuard.GetLicenseApiBaseUrl();
            string licenseKey = OnlineLicenseGuard.GetCachedLicenseKey();
            string computerId = OnlineLicenseGuard.GetCachedComputerId();
            string storeId = CloudSyncOutbox.ResolveStoreId();

            if (string.IsNullOrWhiteSpace(baseUrl)
                || string.IsNullOrWhiteSpace(licenseKey)
                || string.IsNullOrWhiteSpace(computerId))
            {
                return;
            }

            List<sys_cloudsyncoutbox> pending = CloudSyncOutbox.PeekPending(null, 40);
            if (pending == null || pending.Count == 0)
            {
                CloudSyncOutbox.ResetFailedToPending(null, 10);
                pending = CloudSyncOutbox.PeekPending(null, 40);
                if (pending == null || pending.Count == 0)
                {
                    return;
                }
            }

            var events = new List<object>();
            foreach (sys_cloudsyncoutbox row in pending)
            {
                events.Add(new
                {
                    eventType = row.EventType,
                    idempotencyKey = row.IdempotencyKey,
                    payloadJson = row.PayloadJson ?? "{}"
                });
            }

            var bodyObj = new
            {
                licenseKey = licenseKey,
                computerId = computerId,
                machineName = Environment.MachineName,
                storeId = storeId,
                events = events
            };

            string json = new JavaScriptSerializer().Serialize(bodyObj);
            byte[] body = Encoding.UTF8.GetBytes(json);

            int timeoutMs = 15000;
            int timeoutSeconds;
            if (int.TryParse(OnlineLicenseGuard.ReadAppSetting("licenseApiTimeoutSeconds"), out timeoutSeconds) && timeoutSeconds > 0)
            {
                timeoutMs = timeoutSeconds * 1000;
            }

            try
            {
                ServicePointManager.SecurityProtocol |= SecurityProtocolType.Tls12;
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(baseUrl + "/api/cloud/sync");
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
                    SyncResponseDto dto = null;
                    try
                    {
                        dto = new JavaScriptSerializer().Deserialize<SyncResponseDto>(responseBody);
                    }
                    catch
                    {
                    }

                    HashSet<string> accepted = new HashSet<string>(StringComparer.Ordinal);
                    if (dto != null && dto.acceptedKeys != null)
                    {
                        foreach (string key in dto.acceptedKeys)
                        {
                            if (!string.IsNullOrWhiteSpace(key))
                            {
                                accepted.Add(key);
                            }
                        }
                    }

                    foreach (sys_cloudsyncoutbox row in pending)
                    {
                        if (accepted.Contains(row.IdempotencyKey))
                        {
                            CloudSyncOutbox.MarkSent(row);
                        }
                    }

                    _logger.Info(string.Format(
                        "CloudSyncFlusher sent {0} events, accepted={1}",
                        pending.Count,
                        accepted.Count));
                }
            }
            catch (WebException wex)
            {
                string detail = wex.Message;
                try
                {
                    if (wex.Response != null)
                    {
                        using (StreamReader reader = new StreamReader(wex.Response.GetResponseStream(), Encoding.UTF8))
                        {
                            detail = reader.ReadToEnd();
                        }
                    }
                }
                catch
                {
                }

                _logger.Warn("CloudSyncFlusher HTTP failed: " + detail);
                foreach (sys_cloudsyncoutbox row in pending)
                {
                    // keep Pending for retry — do not mark Failed on transport errors
                }
            }
        }

        private class SyncResponseDto
        {
            public string message { get; set; }
            public int accepted { get; set; }
            public string[] acceptedKeys { get; set; }
        }
    }
}
