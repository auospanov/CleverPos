using DevExpress.Data.Filtering;
using DevExpress.Xpo;
using LogicPOS.Data.XPO.Settings;
using LogicPOS.Data.XPO.Utility;
using LogicPOS.Domain.Entities;
using LogicPOS.Domain.Enums;
using LogicPOS.Globalization;
using LogicPOS.Settings;
using LogicPOS.Utility;
using System;

namespace LogicPOS.Modules.StockManagement
{
    /// <summary>
    /// Stock movements without IStockManagementModule.
    /// Updates fin_articlestock + Accounting + fin_articlewarehouse (default warehouse).
    /// Serial numbers are intentionally not handled in MVP — see docs/STOCK-MVP-WITHOUT-PLUGIN.md.
    /// </summary>
    public class ProcessArticleStock
    {
        private static readonly Guid DefaultWarehouseOid = Guid.Parse("4f5f33a7-7717-49cd-8687-5dc302a0c3cb");
        private static readonly Guid DefaultLocationOid = Guid.Parse("a12a472b-5f32-4c7a-a648-03072560ffc8");

        public static bool Add(ProcessArticleStockMode pMode, ProcessArticleStockParameter pParameter)
        {
            return Add(
                XPOSettings.Session,
                pMode,
                null,
                pParameter.Customer,
                10,
                pParameter.DocumentDate,
                pParameter.DocumentNumber,
                pParameter.Article,
                pParameter.Quantity,
                pParameter.Notes,
                pParameter.WarehouseLocation);
        }

        public static bool Add(ProcessArticleStockMode pMode, erp_customer pCustomer, int pOrd, DateTime pDocumentDate, string pDocumentNumber, fin_article pArticle, decimal pQuantity, string pNotes)
        {
            return Add(XPOSettings.Session, pMode, null, pCustomer, pOrd, pDocumentDate, pDocumentNumber, pArticle, pQuantity, pNotes, null);
        }

        public static bool Add(Session pSession, ProcessArticleStockMode pMode, erp_customer pCustomer, int pOrd, DateTime pDocumentDate, string pDocumentNumber, fin_article pArticle, decimal pQuantity, string pNotes)
        {
            return Add(pSession, pMode, null, pCustomer, pOrd, pDocumentDate, pDocumentNumber, pArticle, pQuantity, pNotes, null);
        }

        public static bool Add(
            Session pSession,
            ProcessArticleStockMode pMode,
            fin_documentfinancedetail pDocumentDetail,
            erp_customer pCustomer,
            int pOrd,
            DateTime pDocumentDate,
            string pDocumentNumber,
            fin_article pArticle,
            decimal pQuantity,
            string pNotes)
        {
            return Add(pSession, pMode, pDocumentDetail, pCustomer, pOrd, pDocumentDate, pDocumentNumber, pArticle, pQuantity, pNotes, null);
        }

        public static bool Add(
            Session pSession,
            ProcessArticleStockMode pMode,
            fin_documentfinancedetail pDocumentDetail,
            erp_customer pCustomer,
            int pOrd,
            DateTime pDocumentDate,
            string pDocumentNumber,
            fin_article pArticle,
            decimal pQuantity,
            string pNotes,
            fin_warehouselocation pWarehouseLocation)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

            bool result = false;
            decimal quantity = 0.0m;

            try
            {
                switch (pMode)
                {
                    case ProcessArticleStockMode.Out:
                        quantity = -(pQuantity);
                        break;
                    case ProcessArticleStockMode.In:
                        quantity = pQuantity;
                        break;
                    default:
                        return false;
                }

                erp_customer customer = (erp_customer)pSession.GetObjectByKey(typeof(erp_customer), XPOSettings.XpoOidUserRecord);
                if (pCustomer != null)
                {
                    customer = (erp_customer)pSession.GetObjectByKey(typeof(erp_customer), pCustomer.Oid);
                }
                fin_article article = (fin_article)pSession.GetObjectByKey(typeof(fin_article), pArticle.Oid);
                pos_configurationplaceterminal terminal = (pos_configurationplaceterminal)pSession.GetObjectByKey(typeof(pos_configurationplaceterminal), TerminalSettings.LoggedTerminal.Oid);
                sys_userdetail userDetail = (sys_userdetail)pSession.GetObjectByKey(typeof(sys_userdetail), XPOSettings.LoggedUser.Oid);

                fin_articlestock articleStock = new fin_articlestock(pSession)
                {
                    Customer = customer,
                    Date = pDocumentDate,
                    Article = article,
                    Quantity = quantity,
                    Notes = pNotes,
                    CreatedWhere = terminal,
                    CreatedBy = userDetail
                };
                if (!string.IsNullOrEmpty(pDocumentNumber))
                {
                    articleStock.DocumentNumber = pDocumentNumber;
                }
                if (pDocumentDetail != null)
                {
                    articleStock.DocumentNumber = pDocumentDetail.DocumentMaster.DocumentNumber;
                    articleStock.DocumentMaster = pDocumentDetail.DocumentMaster;
                    articleStock.DocumentDetail = pDocumentDetail;
                }

                article.Accounting += quantity;
                // Warehouse row is optional: never fail the movement if warehouse is unused/missing.
                try
                {
                    ApplyWarehouseDelta(pSession, article, quantity, pWarehouseLocation);
                }
                catch (Exception whEx)
                {
                    log.Warn("ApplyWarehouseDelta skipped: " + whEx.Message);
                }

                if (!(pSession is UnitOfWork))
                {
                    article.Save();
                    articleStock.Save();
                }

                switch (pMode)
                {
                    case ProcessArticleStockMode.Out:
                        XPOUtility.Audit("STOCK_MOVEMENT_OUT", string.Format(CultureResources.GetResourceByLanguage(Settings.CultureSettings.CurrentCultureName, "audit_message_stock_movement_out"), article.Designation, Utility.DataConversionUtils.DecimalToString(quantity, Settings.CultureSettings.DecimalFormatStockQuantity)));
                        break;
                    case ProcessArticleStockMode.In:
                        XPOUtility.Audit("STOCK_MOVEMENT_IN", string.Format(CultureResources.GetResourceByLanguage(Settings.CultureSettings.CurrentCultureName, "audit_message_stock_movement_in"), article.Designation, Utility.DataConversionUtils.DecimalToString(quantity, Settings.CultureSettings.DecimalFormatStockQuantity)));
                        break;
                }

                result = true;

                if (!(pSession is UnitOfWork))
                {
                    try
                    {
                        CloudSyncOutbox.EnqueueStockBalance(pSession, article, quantity, pMode.ToString());
                    }
                    catch (Exception syncEx)
                    {
                        log.Warn("CloudSyncOutbox stock: " + syncEx.Message);
                    }
                }
            }
            catch (Exception ex)
            {
                log.Error(ex.Message, ex);
            }

            return result;
        }

        /// <summary>
        /// Process finance document stock (sale / cancel reverse).
        /// </summary>
        public static bool Add(
            fin_documentfinancemaster pDocumentFinanceMaster,
            bool pReverseStockMode = false)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

            bool result = false;
            int ord = 0;

            ProcessArticleStockMode mode = (pDocumentFinanceMaster.DocumentType.StockMode > 0)
                ? (ProcessArticleStockMode)pDocumentFinanceMaster.DocumentType.StockMode
                : ProcessArticleStockMode.None;

            try
            {
                if (mode != ProcessArticleStockMode.None)
                {
                    if (pReverseStockMode && mode.Equals(ProcessArticleStockMode.Out))
                    {
                        mode = ProcessArticleStockMode.In;
                    }
                    else if (pReverseStockMode && mode.Equals(ProcessArticleStockMode.In))
                    {
                        mode = ProcessArticleStockMode.Out;
                    }

                    using (UnitOfWork uowSession = new UnitOfWork())
                    {
                        try
                        {
                            fin_documentfinancemaster documentFinanceMaster = (fin_documentfinancemaster)uowSession.GetObjectByKey(typeof(fin_documentfinancemaster), pDocumentFinanceMaster.Oid);
                            erp_customer customer = (erp_customer)uowSession.GetObjectByKey(typeof(erp_customer), pDocumentFinanceMaster.EntityOid);

                            foreach (fin_documentfinancedetail item in documentFinanceMaster.DocumentDetail)
                            {
                                if (item.Article.Class.WorkInStock)
                                {
                                    ord += 10;
                                    Add(
                                        uowSession,
                                        mode, item,
                                        customer, ord, documentFinanceMaster.Date, documentFinanceMaster.DocumentNumber,
                                        item.Article,
                                        item.Quantity,
                                        item.Notes,
                                        null);

                                    if (item.Article.IsComposed)
                                    {
                                        foreach (fin_articlecomposition compositeArticle in item.Article.ArticleComposition)
                                        {
                                            fin_article articleChild = compositeArticle.ArticleChild;
                                            Add(
                                                uowSession,
                                                mode, item,
                                                customer, ord, documentFinanceMaster.Date, documentFinanceMaster.DocumentNumber,
                                                articleChild,
                                                compositeArticle.Quantity * item.Quantity,
                                                item.Notes,
                                                null);
                                        }
                                    }
                                }
                            }
                            uowSession.CommitChanges();

                            try
                            {
                                foreach (fin_documentfinancedetail item in documentFinanceMaster.DocumentDetail)
                                {
                                    if (item.Article != null && item.Article.Class != null && item.Article.Class.WorkInStock)
                                    {
                                        fin_article fresh = XPOSettings.Session.GetObjectByKey<fin_article>(item.Article.Oid);
                                        if (fresh != null)
                                        {
                                            CloudSyncOutbox.EnqueueStockBalance(
                                                XPOSettings.Session,
                                                fresh,
                                                mode == ProcessArticleStockMode.Out ? -item.Quantity : item.Quantity,
                                                mode.ToString());
                                        }
                                    }
                                }
                            }
                            catch (Exception syncEx)
                            {
                                log.Warn("CloudSyncOutbox stock after document: " + syncEx.Message);
                            }
                        }
                        catch (Exception ex)
                        {
                            uowSession.RollbackTransaction();
                            log.Error(ex.Message, ex);
                        }
                    }
                    result = true;
                }
            }
            catch (Exception ex)
            {
                log.Debug(ex.Message);
            }

            return result;
        }

        /// <summary>
        /// Upsert qty on existing default (or preferred) warehouse. Does NOT create warehouse —
        /// if no warehouse is configured, silently skips (POS without warehouse stays intact).
        /// </summary>
        public static void ApplyWarehouseDelta(
            Session session,
            fin_article article,
            decimal qtyDelta,
            fin_warehouselocation preferredLocation = null)
        {
            if (session == null || article == null || qtyDelta == 0m)
            {
                return;
            }

            try
            {
                fin_warehouselocation location = null;
                if (preferredLocation != null)
                {
                    location = session.GetObjectByKey<fin_warehouselocation>(preferredLocation.Oid)
                        ?? preferredLocation;
                }
                if (location == null)
                {
                    location = TryGetDefaultWarehouseLocation(session);
                }
                if (location == null || location.Warehouse == null)
                {
                    return;
                }

                fin_warehouse warehouse = location.Warehouse;
                fin_articlewarehouse row = session.FindObject<fin_articlewarehouse>(
                    CriteriaOperator.Parse(
                        "Article = ? AND Warehouse = ? AND Location = ? AND ArticleSerialNumber IS NULL",
                        article,
                        warehouse,
                        location));

                if (row == null)
                {
                    row = new fin_articlewarehouse(session)
                    {
                        Article = article,
                        Warehouse = warehouse,
                        Location = location,
                        Quantity = 0m
                    };
                }

                row.Quantity += qtyDelta;

                if (!(session is UnitOfWork))
                {
                    row.Save();
                }
            }
            catch (Exception ex)
            {
                log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
                log.Warn("ApplyWarehouseDelta: " + ex.Message);
            }
        }

        /// <summary>Find default warehouse location only — never creates.</summary>
        public static fin_warehouselocation TryGetDefaultWarehouseLocation(Session session)
        {
            if (session == null)
            {
                return null;
            }

            try
            {
                fin_warehouse warehouse = session.FindObject<fin_warehouse>(
                    CriteriaOperator.Parse("IsDefault = true AND (Disabled IS NULL OR Disabled = false)"));
                if (warehouse == null)
                {
                    warehouse = session.GetObjectByKey<fin_warehouse>(DefaultWarehouseOid);
                }
                if (warehouse == null)
                {
                    return null;
                }

                fin_warehouselocation location = session.FindObject<fin_warehouselocation>(
                    CriteriaOperator.Parse("Warehouse = ? AND (Disabled IS NULL OR Disabled = false)", warehouse));
                if (location == null)
                {
                    location = session.GetObjectByKey<fin_warehouselocation>(DefaultLocationOid);
                }

                return location;
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        /// Inventory adjust: set counted qty. Creates default warehouse only when inventoring.
        /// Returns false if delta is zero.
        /// </summary>
        public static bool AdjustToCountedQuantity(fin_article article, decimal countedQty, string notes)
        {
            if (article == null)
            {
                return false;
            }

            Session session = XPOSettings.Session;
            decimal bookQty = article.Accounting;
            try
            {
                // Prefer movement sum when available
                object sum = session.ExecuteScalar(string.Format(
                    "SELECT SUM(Quantity) FROM fin_articlestock WHERE Article = '{0}' AND (Disabled = 0 OR Disabled IS NULL)",
                    article.Oid));
                if (sum != null && sum != DBNull.Value)
                {
                    bookQty = Convert.ToDecimal(sum);
                }
            }
            catch
            {
            }

            decimal delta = countedQty - bookQty;
            if (delta == 0m)
            {
                return false;
            }

            // Explicit inventory: ensure warehouse exists so balance lands on it.
            EnsureDefaultWarehouseLocation(session);

            string note = string.IsNullOrWhiteSpace(notes)
                ? string.Format("Инвентаризация: учёт={0}, факт={1}", bookQty, countedQty)
                : notes.Trim();

            ProcessArticleStockMode mode = delta > 0m ? ProcessArticleStockMode.In : ProcessArticleStockMode.Out;
            return Add(
                session,
                mode,
                null,
                null,
                10,
                DateTime.Now,
                "INV",
                article,
                Math.Abs(delta),
                note,
                null);
        }

        /// <summary>
        /// Find or create default warehouse + location. Call only from inventory / explicit stock setup.
        /// </summary>
        public static fin_warehouselocation EnsureDefaultWarehouseLocation(Session session)
        {
            if (session == null)
            {
                return null;
            }

            try
            {
                fin_warehouselocation existing = TryGetDefaultWarehouseLocation(session);
                if (existing != null)
                {
                    return existing;
                }

                fin_warehouse warehouse = session.FindObject<fin_warehouse>(
                    CriteriaOperator.Parse("IsDefault = true AND (Disabled IS NULL OR Disabled = false)"));
                if (warehouse == null)
                {
                    warehouse = session.GetObjectByKey<fin_warehouse>(DefaultWarehouseOid);
                }
                if (warehouse == null)
                {
                    warehouse = new fin_warehouse(session)
                    {
                        Ord = "10",
                        Code = "10",
                        Designation = "Основной склад",
                        IsDefault = true,
                        Disabled = false
                    };
                    if (!(session is UnitOfWork))
                    {
                        warehouse.Save();
                    }
                }
                else if (!warehouse.IsDefault)
                {
                    warehouse.IsDefault = true;
                    if (!(session is UnitOfWork))
                    {
                        warehouse.Save();
                    }
                }

                fin_warehouselocation location = session.FindObject<fin_warehouselocation>(
                    CriteriaOperator.Parse("Warehouse = ? AND (Disabled IS NULL OR Disabled = false)", warehouse));
                if (location == null)
                {
                    location = session.GetObjectByKey<fin_warehouselocation>(DefaultLocationOid);
                }
                if (location == null)
                {
                    location = new fin_warehouselocation(session)
                    {
                        Ord = "10",
                        Code = "10",
                        Designation = "Общая",
                        Warehouse = warehouse,
                        Disabled = false
                    };
                    if (!(session is UnitOfWork))
                    {
                        location.Save();
                    }
                }

                return location;
            }
            catch (Exception ex)
            {
                log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
                log.Warn("EnsureDefaultWarehouseLocation: " + ex.Message);
                return null;
            }
        }
    }
}
