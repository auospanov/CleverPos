using logicpos.shared.Enums;
using LogicPOS.Reporting.Reports.CustomerBalanceSummary;
using LogicPOS.Settings;
using LogicPOS.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using LogicPOS.Reporting.Reports.Data;
using LogicPOS.Reporting.Data.Common;

namespace LogicPOS.Reporting.Reports
{
    public class CustomerBalanceDetailsReport
    {
        private const string REPORT_FILENAME = "ReportDocumentFinanceCustomerBalanceDetails.frx";
        protected readonly Common.FastReport _report;
        private readonly string _readableFilter;
        private readonly string _groupTitle;
        private readonly string _groupCondition;
        private readonly string _reportToken;
        private readonly string _filter;
        protected readonly CustomReportDisplayMode _viewMode;

        public CustomerBalanceDetailsReport(
            string filter,
            string readableFilter,
            CustomReportDisplayMode viewMode
            )
        {
            _report = new Common.FastReport(
                reportFileName: REPORT_FILENAME,
                templateBase: Common.FastReport.FILENAME_TEMPLATE_BASE_SIMPLE,
                numberOfCopies: 1);

            _filter = filter;
            _readableFilter = readableFilter;
            _reportToken = "REPORT_CUSTOMER_BALANCE_DETAILS";
            _viewMode = viewMode;

            Initialize();
        }

        public void Initialize()
        {
            SetParametersValues();
            PrepareDataSources();
        }

        private void SetParametersValues()
        {
            var reportTitle = GeneralUtils.GetResourceByName(_reportToken.ToLower());
            _report.SetParameterValue("Report Title", reportTitle);
            _report.SetParameterValue("Report_FileName_loggero", GeneralSettings.PreferenceParameters["REPORT_FILENAME_loggerO"]);
            _report.SetParameterValue("Report_FileName_loggero_Small", GeneralSettings.PreferenceParameters["REPORT_FILENAME_loggerO_SMALL"]);

            if (!string.IsNullOrEmpty(_readableFilter))
            {
                _report.SetParameterValue("Report Filter", _readableFilter);
            }
        }

        private void PrepareDataSources()
        {
            ReportDataList<CustomerBalanceDetailsReportData> customerBalanceDetailsReportDataList = new ReportDataList<CustomerBalanceDetailsReportData>(_filter);
            ReportDataList<CustomerBalanceSummaryReportData> customerBalanceSummaryReportDataList = new ReportDataList<CustomerBalanceSummaryReportData>(_filter);

            var entityOids = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

            foreach (var item in customerBalanceDetailsReportDataList)
            {
                if (PluginSettings.HasSoftwareVendorPlugin)
                {
                    if (item.EntityName != null)
                    {
                        item.EntityName = PluginSettings.SoftwareVendor.Decrypt(item.EntityName);
                    }

                    if (item.EntityFiscalNumber != null)
                    {
                        item.EntityFiscalNumber = PluginSettings.SoftwareVendor.Decrypt(item.EntityFiscalNumber);
                    }
                }

                if (!string.IsNullOrEmpty(item.EntityOid))
                {
                    entityOids.Add(item.EntityOid);
                }

                foreach (var summary in customerBalanceSummaryReportDataList)
                {
                    if (summary.Oid != null && summary.Oid.Equals(item.EntityOid))
                    {
                        item.Balance = summary.Balance;
                        item.CustomerSinceDate = summary.CustomerSinceDate;
                        break;
                    }
                }
            }

            bool printTotalBalance = entityOids.Count == 1;
            decimal totalCredit = 0;
            decimal totalDebit = 0;
            decimal totalBalance = 0;

            if (printTotalBalance)
            {
                string entityOid = entityOids.First();
                CustomerBalanceSummaryReportData summaryTotal = customerBalanceSummaryReportDataList.List
                    .FirstOrDefault(summary => summary.Oid == entityOid || summary.EntityOid == entityOid);

                if (summaryTotal == null)
                {
                    ReportDataList<CustomerBalanceSummaryReportData> gcCustomerBalanceSummaryTotal =
                        new ReportDataList<CustomerBalanceSummaryReportData>(string.Format("(EntityOid = '{0}')", entityOid));

                    if (gcCustomerBalanceSummaryTotal.List.Count > 0)
                    {
                        summaryTotal = gcCustomerBalanceSummaryTotal.List[0];
                    }
                }

                if (summaryTotal != null)
                {
                    totalCredit = summaryTotal.TotalCredit;
                    totalDebit = summaryTotal.TotalDebit;
                    totalBalance = summaryTotal.Balance;
                }
            }

            _report.SetParameterValue("PrintTotalBalance", printTotalBalance);
            _report.SetParameterValue("TotalCreditFinal", totalCredit);
            _report.SetParameterValue("TotalDebitFinal", totalDebit);
            _report.SetParameterValue("TotalBalanceFinal", totalBalance);

            _report.RegisterData(customerBalanceDetailsReportDataList, "CustomerBalanceDetails");

            if (_report.GetDataSource("CustomerBalanceDetails") != null)
            {
                _report.GetDataSource("CustomerBalanceDetails").Enabled = true;
            }
        }

        public void Present()
        {
            _report.Process(_viewMode);
            _report.Dispose();
        }

    }
}
