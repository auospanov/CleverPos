using System;
using DevExpress.Xpo;
using LogicPOS.Data.XPO.Utility;

namespace LogicPOS.Domain.Entities
{
    [DeferredDeletion(false)]
    public class sys_configurationpaymentterminal : Entity
    {
        public sys_configurationpaymentterminal() : base() { }
        public sys_configurationpaymentterminal(Session session) : base(session) { }

        protected override void OnAfterConstruction()
        {
            Ord = XPOUtility.GetNextTableFieldID(nameof(sys_configurationpaymentterminal), "Ord");
            Code = XPOUtility.GetNextTableFieldID(nameof(sys_configurationpaymentterminal), "Code");
            Port = 8080;
            UseHttps = false;
            Brand = "KASPI";
        }

        private uint fOrd;
        public uint Ord
        {
            get { return fOrd; }
            set { SetPropertyValue("Ord", ref fOrd, value); }
        }

        private uint fCode;
        [Indexed(Unique = true)]
        public uint Code
        {
            get { return fCode; }
            set { SetPropertyValue("Code", ref fCode, value); }
        }

        private string fDesignation;
        public string Designation
        {
            get { return fDesignation; }
            set { SetPropertyValue<string>("Designation", ref fDesignation, value); }
        }

        /// <summary>KASPI, HALYK, JUSAN</summary>
        private string fBrand;
        [Size(20)]
        public string Brand
        {
            get { return fBrand; }
            set { SetPropertyValue<string>("Brand", ref fBrand, value); }
        }

        private string fHost;
        [Size(100)]
        public string Host
        {
            get { return fHost; }
            set { SetPropertyValue<string>("Host", ref fHost, value); }
        }

        private int fPort;
        public int Port
        {
            get { return fPort; }
            set { SetPropertyValue<int>("Port", ref fPort, value); }
        }

        private string fPosClientName;
        [Size(100)]
        public string PosClientName
        {
            get { return fPosClientName; }
            set { SetPropertyValue<string>("PosClientName", ref fPosClientName, value); }
        }

        private bool fUseHttps;
        public bool UseHttps
        {
            get { return fUseHttps; }
            set { SetPropertyValue<bool>("UseHttps", ref fUseHttps, value); }
        }

        private string fAccessToken;
        [Size(255)]
        public string AccessToken
        {
            get { return fAccessToken; }
            set { SetPropertyValue<string>("AccessToken", ref fAccessToken, value); }
        }

        private string fRefreshToken;
        [Size(255)]
        public string RefreshToken
        {
            get { return fRefreshToken; }
            set { SetPropertyValue<string>("RefreshToken", ref fRefreshToken, value); }
        }

        private DateTime? fTokenExpiration;
        public DateTime? TokenExpiration
        {
            get { return fTokenExpiration; }
            set { SetPropertyValue<DateTime?>("TokenExpiration", ref fTokenExpiration, value); }
        }

        [Association(@"PaymentTerminalReferencesConfigurationPaymentMethod", typeof(fin_configurationpaymentmethod))]
        public XPCollection<fin_configurationpaymentmethod> PaymentMethods
        {
            get { return GetCollection<fin_configurationpaymentmethod>("PaymentMethods"); }
        }
    }
}
