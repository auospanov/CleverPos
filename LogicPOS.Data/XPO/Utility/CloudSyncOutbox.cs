using DevExpress.Xpo;
using LogicPOS.Data.XPO.Settings;
using LogicPOS.Domain.Entities;
using LogicPOS.Settings;
using System;
using System.Globalization;
using System.Text;

namespace LogicPOS.Data.XPO.Utility
{
    /// <summary>
    /// First step toward cloud model B: enqueue local events (no HTTP upload yet).
    /// </summary>
    public static class CloudSyncOutbox
    {
        private static readonly log4net.ILog _logger = log4net.LogManager.GetLogger(typeof(CloudSyncOutbox));

        public const string StatusPending = "Pending";
        public const string StatusSent = "Sent";
        public const string StatusFailed = "Failed";

        public const string EventStockBalance = "stock_balance";
        public const string EventSaleCommitted = "sale_committed";

        public static string ResolveStoreId()
        {
            try
            {
                if (GeneralSettings.Settings != null)
                {
                    string fromSettings = GeneralSettings.Settings["cloudStoreId"];
                    if (!string.IsNullOrWhiteSpace(fromSettings))
                    {
                        return fromSettings.Trim();
                    }
                }
            }
            catch
            {
            }

            return Environment.MachineName ?? "default";
        }

        public static void EnqueueStockBalance(Session session, fin_article article, decimal qtyDelta, string mode)
        {
            if (article == null)
            {
                return;
            }

            Session useSession = session ?? XPOSettings.Session;
            if (useSession == null)
            {
                return;
            }

            string storeId = ResolveStoreId();
            string at = DateTime.UtcNow.ToString("o", CultureInfo.InvariantCulture);
            string idempotency = string.Format(
                CultureInfo.InvariantCulture,
                "stock:{0}:{1}:{2:N}:{3}",
                storeId,
                article.Oid,
                Guid.NewGuid(),
                at);

            var payload = new StringBuilder(256);
            payload.Append('{');
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"storeId\":\"{0}\",", Escape(storeId));
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"articleOid\":\"{0}\",", article.Oid);
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"barcode\":\"{0}\",", Escape(article.BarCode ?? string.Empty));
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"code\":\"{0}\",", Escape(article.Code ?? string.Empty));
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"designation\":\"{0}\",", Escape(article.Designation ?? string.Empty));
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"qtyDelta\":{0},", qtyDelta.ToString(CultureInfo.InvariantCulture));
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"accounting\":{0},", article.Accounting.ToString(CultureInfo.InvariantCulture));
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"mode\":\"{0}\",", Escape(mode ?? string.Empty));
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"at\":\"{0}\"", Escape(at));
            payload.Append('}');

            Enqueue(useSession, EventStockBalance, storeId, payload.ToString(), idempotency);
        }

        public static void EnqueueSaleCommitted(fin_documentfinancemaster document)
        {
            if (document == null)
            {
                return;
            }

            Session session = XPOSettings.Session;
            if (session == null)
            {
                return;
            }

            string storeId = ResolveStoreId();
            string day = document.Date.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
            string paymentToken = document.PaymentMethod != null
                ? (document.PaymentMethod.Token ?? document.PaymentMethod.Acronym ?? string.Empty)
                : string.Empty;

            string idempotency = string.Format(
                CultureInfo.InvariantCulture,
                "sale:{0}:{1}",
                storeId,
                document.Oid);

            var payload = new StringBuilder(256);
            payload.Append('{');
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"storeId\":\"{0}\",", Escape(storeId));
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"documentOid\":\"{0}\",", document.Oid);
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"documentNumber\":\"{0}\",", Escape(document.DocumentNumber ?? string.Empty));
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"total\":{0},", document.TotalFinal.ToString(CultureInfo.InvariantCulture));
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"day\":\"{0}\",", Escape(day));
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"paymentToken\":\"{0}\",", Escape(paymentToken));
            payload.AppendFormat(CultureInfo.InvariantCulture, "\"at\":\"{0}\"", Escape(DateTime.UtcNow.ToString("o", CultureInfo.InvariantCulture)));
            payload.Append('}');

            Enqueue(session, EventSaleCommitted, storeId, payload.ToString(), idempotency);
        }

        public static int CountPending(Session session = null)
        {
            Session useSession = session ?? XPOSettings.Session;
            if (useSession == null)
            {
                return 0;
            }

            try
            {
                return (int)useSession.Evaluate<sys_cloudsyncoutbox>(
                    DevExpress.Data.Filtering.CriteriaOperator.Parse("Count()"),
                    DevExpress.Data.Filtering.CriteriaOperator.Parse("Status = ?", StatusPending));
            }
            catch (Exception ex)
            {
                _logger.Warn("CountPending: " + ex.Message);
                return 0;
            }
        }

        public static System.Collections.Generic.List<sys_cloudsyncoutbox> PeekPending(Session session = null, int limit = 50)
        {
            Session useSession = session ?? XPOSettings.Session;
            var list = new System.Collections.Generic.List<sys_cloudsyncoutbox>();
            if (useSession == null || limit <= 0)
            {
                return list;
            }

            try
            {
                var collection = new XPCollection<sys_cloudsyncoutbox>(
                    useSession,
                    DevExpress.Data.Filtering.CriteriaOperator.Parse("Status = ?", StatusPending));
                collection.Sorting.Add(new SortProperty("CreatedAt", DevExpress.Xpo.DB.SortingDirection.Ascending));
                collection.TopReturnedObjects = limit;
                foreach (sys_cloudsyncoutbox row in collection)
                {
                    list.Add(row);
                }
            }
            catch (Exception ex)
            {
                _logger.Warn("PeekPending: " + ex.Message);
            }

            return list;
        }

        public static void MarkSent(sys_cloudsyncoutbox row)
        {
            if (row == null)
            {
                return;
            }

            try
            {
                row.Status = StatusSent;
                row.SentAt = DateTime.UtcNow;
                row.LastError = null;
                row.Save();
            }
            catch (Exception ex)
            {
                _logger.Warn("MarkSent: " + ex.Message);
            }
        }

        public static void MarkFailed(sys_cloudsyncoutbox row, string error)
        {
            if (row == null)
            {
                return;
            }

            try
            {
                row.Status = StatusFailed;
                row.LastError = error != null && error.Length > 2000 ? error.Substring(0, 2000) : error;
                row.Save();
            }
            catch (Exception ex)
            {
                _logger.Warn("MarkFailed: " + ex.Message);
            }
        }

        public static void ResetFailedToPending(Session session = null, int limit = 20)
        {
            Session useSession = session ?? XPOSettings.Session;
            if (useSession == null)
            {
                return;
            }

            try
            {
                var collection = new XPCollection<sys_cloudsyncoutbox>(
                    useSession,
                    DevExpress.Data.Filtering.CriteriaOperator.Parse("Status = ?", StatusFailed));
                collection.TopReturnedObjects = limit;
                foreach (sys_cloudsyncoutbox row in collection)
                {
                    row.Status = StatusPending;
                    row.LastError = null;
                    row.Save();
                }
            }
            catch (Exception ex)
            {
                _logger.Warn("ResetFailedToPending: " + ex.Message);
            }
        }

        private static void Enqueue(Session session, string eventType, string storeId, string payloadJson, string idempotencyKey)
        {
            try
            {
                sys_cloudsyncoutbox existing = session.FindObject<sys_cloudsyncoutbox>(
                    DevExpress.Data.Filtering.CriteriaOperator.Parse("IdempotencyKey = ?", idempotencyKey));
                if (existing != null)
                {
                    return;
                }

                var row = new sys_cloudsyncoutbox(session)
                {
                    EventType = eventType,
                    StoreId = storeId,
                    PayloadJson = payloadJson,
                    IdempotencyKey = idempotencyKey,
                    Status = StatusPending
                };
                row.Save();

                _logger.Info(string.Format(
                    "CloudSyncOutbox queued {0} store={1} key={2} (pending={3})",
                    eventType,
                    storeId,
                    idempotencyKey,
                    CountPending(session)));
            }
            catch (Exception ex)
            {
                _logger.Warn("CloudSyncOutbox.Enqueue failed: " + ex.Message);
            }
        }

        private static string Escape(string value)
        {
            if (string.IsNullOrEmpty(value))
            {
                return string.Empty;
            }

            return value
                .Replace("\\", "\\\\")
                .Replace("\"", "\\\"")
                .Replace("\r", "\\r")
                .Replace("\n", "\\n");
        }
    }
}
