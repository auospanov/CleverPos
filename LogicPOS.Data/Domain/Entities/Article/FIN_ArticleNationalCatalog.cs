using DevExpress.Xpo;
using System;

namespace LogicPOS.Domain.Entities
{
    [DeferredDeletion(false)]
    public class fin_articlenationalcatalog : Entity
    {
        public fin_articlenationalcatalog() : base() { }
        public fin_articlenationalcatalog(Session session) : base(session) { }

        private fin_article fArticle;
        [Association(@"ArticleReferencesArticleNationalCatalog")]
        public fin_article Article
        {
            get { return fArticle; }
            set { SetPropertyValue("Article", ref fArticle, value); }
        }

        private long? fRequestId;
        public long? RequestId
        {
            get { return fRequestId; }
            set { SetPropertyValue("RequestId", ref fRequestId, value); }
        }

        private string fStatus;
        [Size(50)]
        public string Status
        {
            get { return fStatus; }
            set { SetPropertyValue<string>("Status", ref fStatus, value); }
        }

        private string fOktru;
        [Size(50)]
        public string Oktru
        {
            get { return fOktru; }
            set { SetPropertyValue<string>("Oktru", ref fOktru, value); }
        }

        private string fGtin;
        [Size(20)]
        [Indexed(Unique = true)]
        public string Gtin
        {
            get { return fGtin; }
            set { SetPropertyValue<string>("Gtin", ref fGtin, value); }
        }

        private string fNameKk;
        [Size(255)]
        public string NameKk
        {
            get { return fNameKk; }
            set { SetPropertyValue<string>("NameKk", ref fNameKk, value); }
        }

        private string fTnved;
        [Size(20)]
        public string Tnved
        {
            get { return fTnved; }
            set { SetPropertyValue<string>("Tnved", ref fTnved, value); }
        }

        private string fManufacturerName;
        [Size(200)]
        public string ManufacturerName
        {
            get { return fManufacturerName; }
            set { SetPropertyValue<string>("ManufacturerName", ref fManufacturerName, value); }
        }

        private string fQuantity;
        [Size(20)]
        public string Quantity
        {
            get { return fQuantity; }
            set { SetPropertyValue<string>("Quantity", ref fQuantity, value); }
        }

        private string fLastError;
        [Size(SizeAttribute.Unlimited)]
        public string LastError
        {
            get { return fLastError; }
            set { SetPropertyValue<string>("LastError", ref fLastError, value); }
        }

        private DateTime? fLastSyncedAt;
        public DateTime? LastSyncedAt
        {
            get { return fLastSyncedAt; }
            set { SetPropertyValue("LastSyncedAt", ref fLastSyncedAt, value); }
        }

        private DateTime? fPublishedAt;
        public DateTime? PublishedAt
        {
            get { return fPublishedAt; }
            set { SetPropertyValue("PublishedAt", ref fPublishedAt, value); }
        }
    }
}
