using DevExpress.Data.Filtering;
using DevExpress.Xpo;
using Gtk;
using logicpos.Classes.Enums.GenericTreeView;
using logicpos.Classes.Gui.Gtk.WidgetsGeneric;
using LogicPOS.Data.XPO.Settings;
using LogicPOS.Domain.Entities;
using LogicPOS.Globalization;
using System;
using System.Collections.Generic;

namespace logicpos.Classes.Gui.Gtk.BackOffice
{
    internal class TreeViewArticleClass : GenericTreeViewXPO
    {
        public TreeViewArticleClass() { }

        [Obsolete]
        public TreeViewArticleClass(Window pSourceWindow)
            : this(pSourceWindow, null, null, null) { }

        [Obsolete]
        public TreeViewArticleClass(Window pSourceWindow, Entity pDefaultValue, CriteriaOperator pXpoCriteria, Type pDialogType, GenericTreeViewMode pGenericTreeViewMode = GenericTreeViewMode.Default, GenericTreeViewNavigatorMode pGenericTreeViewNavigatorMode = GenericTreeViewNavigatorMode.Default)
        {
            Type xpoGuidObjectType = typeof(fin_articleclass);
            fin_articleclass defaultValue = (pDefaultValue != null) ? pDefaultValue as fin_articleclass : null;
            Type typeDialogClass = (pDialogType != null) ? pDialogType : typeof(DialogArticleClass);

            List<GenericTreeViewColumnProperty> columnProperties = new List<GenericTreeViewColumnProperty>
            {
                new GenericTreeViewColumnProperty("Code") { Title = CultureResources.GetResourceByLanguage(LogicPOS.Settings.CultureSettings.CurrentCultureName, "global_record_code"), MinWidth = 100 },
                new GenericTreeViewColumnProperty("Designation") { Title = CultureResources.GetResourceByLanguage(LogicPOS.Settings.CultureSettings.CurrentCultureName, "global_designation"), Expand = true },
                new GenericTreeViewColumnProperty("Acronym") { Title = CultureResources.GetResourceByLanguage(LogicPOS.Settings.CultureSettings.CurrentCultureName, "global_acronym"), MinWidth = 80 },
                new GenericTreeViewColumnProperty("WorkInStock") { Title = CultureResources.GetResourceByLanguage(LogicPOS.Settings.CultureSettings.CurrentCultureName, "global_work_in_stock"), MinWidth = 120 },
                new GenericTreeViewColumnProperty("UpdatedAt") { Title = CultureResources.GetResourceByLanguage(LogicPOS.Settings.CultureSettings.CurrentCultureName, "global_record_date_updated"), MinWidth = 150, MaxWidth = 150 }
            };

            CriteriaOperator criteria;
            if (pXpoCriteria != null)
            {
                criteria = CriteriaOperator.Parse($"({pXpoCriteria}) AND (DeletedAt IS NULL)");
            }
            else
            {
                criteria = CriteriaOperator.Parse("(DeletedAt IS NULL)");
            }

            XPCollection xpoCollection = new XPCollection(XPOSettings.Session, xpoGuidObjectType, criteria);

            base.InitObject(
                pSourceWindow,
                defaultValue,
                pGenericTreeViewMode,
                pGenericTreeViewNavigatorMode,
                columnProperties,
                xpoCollection,
                typeDialogClass
            );
        }
    }
}
