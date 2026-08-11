using DevExpress.Xpo;
using System;

namespace LogicPOS.Domain.Entities
{
    /// <summary>
    /// Local outbox for cloud sync model B (stock balances / sales aggregates).
    /// Flusher to remote hub is a later step — rows stay Pending until then.
    /// </summary>
    [DeferredDeletion(false)]
    public class sys_cloudsyncoutbox : Entity
    {
        public sys_cloudsyncoutbox() : base() { }
        public sys_cloudsyncoutbox(Session session) : base(session) { }

        private string fEventType;
        [Size(64)]
        [Indexed]
        public string EventType
        {
            get { return fEventType; }
            set { SetPropertyValue<string>("EventType", ref fEventType, value); }
        }

        private string fStoreId;
        [Size(64)]
        [Indexed]
        public string StoreId
        {
            get { return fStoreId; }
            set { SetPropertyValue<string>("StoreId", ref fStoreId, value); }
        }

        private string fPayloadJson;
        [Size(SizeAttribute.Unlimited)]
        public string PayloadJson
        {
            get { return fPayloadJson; }
            set { SetPropertyValue<string>("PayloadJson", ref fPayloadJson, value); }
        }

        private string fIdempotencyKey;
        [Size(128)]
        [Indexed(Unique = true)]
        public string IdempotencyKey
        {
            get { return fIdempotencyKey; }
            set { SetPropertyValue<string>("IdempotencyKey", ref fIdempotencyKey, value); }
        }

        private string fStatus;
        [Size(32)]
        [Indexed]
        public string Status
        {
            get { return fStatus; }
            set { SetPropertyValue<string>("Status", ref fStatus, value); }
        }

        private DateTime? fSentAt;
        public DateTime? SentAt
        {
            get { return fSentAt; }
            set { SetPropertyValue<DateTime?>("SentAt", ref fSentAt, value); }
        }

        private string fLastError;
        [Size(SizeAttribute.Unlimited)]
        public string LastError
        {
            get { return fLastError; }
            set { SetPropertyValue<string>("LastError", ref fLastError, value); }
        }
    }
}
