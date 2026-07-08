using LogicPOS.Domain.Entities;
using LogicPOS.NationalCatalog.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace LogicPOS.NationalCatalog
{
    public static class NationalCatalogMapper
    {
        public static string NormalizeGtin(string barCode)
        {
            if (string.IsNullOrWhiteSpace(barCode))
            {
                return null;
            }

            string digits = barCode.Trim();
            if (digits.Length == 12)
            {
                digits = "0" + digits;
            }

            return digits;
        }

        public static NktProductRequestPayload BuildMvpPayload(
            fin_article article,
            fin_articlenationalcatalog link,
            bool autoPublication,
            IReadOnlyList<NktAttributeDefinition> attributeDefinitions = null)
        {
            string gtin = NormalizeGtin(link?.Gtin ?? article?.BarCode);
            string nameRu = article?.Designation?.Trim();
            string nameKk = !string.IsNullOrWhiteSpace(link?.NameKk)
                ? link.NameKk.Trim()
                : nameRu;
            string shortRu = Truncate(nameRu, 50);
            string shortKk = Truncate(nameKk, 50);
            string oktru = link?.Oktru?.Trim();
            string quantity = !string.IsNullOrWhiteSpace(link?.Quantity) ? link.Quantity.Trim() : "1";
            string manufacturer = !string.IsNullOrWhiteSpace(link?.ManufacturerName)
                ? link.ManufacturerName.Trim()
                : "Не указан";
            string tnved = link?.Tnved?.Trim();

            Dictionary<string, NktAttributeValue> attributes = new Dictionary<string, NktAttributeValue>(StringComparer.OrdinalIgnoreCase);
            SetAttribute(attributes, "gtin", gtin);
            SetAttribute(attributes, "name_ru", nameRu);
            SetAttribute(attributes, "name_kk", nameKk);
            SetAttribute(attributes, "short_name_ru", shortRu);
            SetAttribute(attributes, "short_name_kk", shortKk);
            SetAttribute(attributes, "article", article?.Code?.Trim());
            SetAttribute(attributes, "country", "KZ");
            SetAttribute(attributes, "measure_unit", ResolveMeasureUnitCode(article));
            SetAttribute(attributes, "quantity", quantity);

            if (!string.IsNullOrWhiteSpace(tnved))
            {
                SetAttribute(attributes, "tnved", tnved);
            }

            if (attributeDefinitions != null)
            {
                foreach (NktAttributeDefinition definition in attributeDefinitions.Where(a => a != null && a.IsRequired && !string.IsNullOrWhiteSpace(a.Code)))
                {
                    if (attributes.ContainsKey(definition.Code))
                    {
                        continue;
                    }

                    string value = ResolveRequiredAttributeValue(definition, article, link, quantity, manufacturer, tnved, nameRu, nameKk, shortRu, shortKk, gtin);
                    if (!string.IsNullOrWhiteSpace(value))
                    {
                        SetAttribute(attributes, definition.Code, Truncate(value, definition.MaxLength ?? 2000));
                    }
                }
            }
            else if (!string.IsNullOrWhiteSpace(manufacturer))
            {
                // Fallback when attribute schema is unavailable: common clothing manufacturer field.
                SetAttribute(attributes, "a4282e5d", manufacturer);
            }

            return new NktProductRequestPayload
            {
                Oktru = oktru,
                AutoPublication = autoPublication,
                Attributes = attributes.Values.ToList()
            };
        }

        public static string ValidateRequiredAttributes(
            NktProductRequestPayload payload,
            IReadOnlyList<NktAttributeDefinition> attributeDefinitions)
        {
            if (attributeDefinitions == null || attributeDefinitions.Count == 0 || payload?.Attributes == null)
            {
                return null;
            }

            HashSet<string> present = new HashSet<string>(
                payload.Attributes
                    .Where(a => a != null && !string.IsNullOrWhiteSpace(a.Code) && !string.IsNullOrWhiteSpace(a.Value))
                    .Select(a => a.Code),
                StringComparer.OrdinalIgnoreCase);

            List<string> missing = new List<string>();
            foreach (NktAttributeDefinition definition in attributeDefinitions.Where(a => a != null && a.IsRequired))
            {
                if (!present.Contains(definition.Code))
                {
                    missing.Add(string.Format("{0} ({1})", definition.NameRu ?? definition.Code, definition.Code));
                }
            }

            if (missing.Count == 0)
            {
                return null;
            }

            return "Не заполнены обязательные атрибуты НКТ: " + string.Join("; ", missing);
        }

        public static string ExtractGtinFromDetails(NktRequestDetailsResponse details)
        {
            if (details?.Attributes == null)
            {
                return null;
            }

            foreach (NktRequestDetailAttribute attribute in details.Attributes)
            {
                if (string.Equals(attribute.Code, "gtin", StringComparison.OrdinalIgnoreCase))
                {
                    return NormalizeGtin(attribute.Value);
                }
            }

            return null;
        }

        public static string ExtractOktruFromDetails(NktRequestDetailsResponse details)
        {
            if (details?.CategoryAncestors == null || details.CategoryAncestors.Count == 0)
            {
                return null;
            }

            NktCategoryAncestor last = details.CategoryAncestors[details.CategoryAncestors.Count - 1];
            return last?.Code;
        }

        /// <summary>
        /// Maps CleverPos unit measure to NKT dictionary code (measure_unit).
        /// Default is 796 (Штука) — typical for retail piece goods.
        /// </summary>
        public static string ResolveMeasureUnitCode(fin_article article)
        {
            string acronym = article?.UnitMeasure?.Acronym?.Trim() ?? string.Empty;
            string designation = article?.UnitMeasure?.Designation?.Trim() ?? string.Empty;
            string text = (acronym + " " + designation).ToLowerInvariant();

            if (text.IndexOf("кг", StringComparison.Ordinal) >= 0
                || text.IndexOf("kg", StringComparison.Ordinal) >= 0
                || text.IndexOf("килограмм", StringComparison.Ordinal) >= 0)
            {
                return "166";
            }

            if (text.IndexOf("грамм", StringComparison.Ordinal) >= 0
                || string.Equals(acronym, "g", StringComparison.OrdinalIgnoreCase)
                || string.Equals(acronym, "гр", StringComparison.OrdinalIgnoreCase))
            {
                return "163";
            }

            if (text.IndexOf("литр", StringComparison.Ordinal) >= 0
                || string.Equals(acronym, "l", StringComparison.OrdinalIgnoreCase)
                || string.Equals(acronym, "л", StringComparison.OrdinalIgnoreCase))
            {
                return "112";
            }

            return "796";
        }

        private static string ResolveRequiredAttributeValue(
            NktAttributeDefinition definition,
            fin_article article,
            fin_articlenationalcatalog link,
            string quantity,
            string manufacturer,
            string tnved,
            string nameRu,
            string nameKk,
            string shortRu,
            string shortKk,
            string gtin)
        {
            string code = definition.Code ?? string.Empty;
            string dataType = definition.DataType ?? string.Empty;
            string dictionaryCode = definition.DictionaryCode ?? string.Empty;
            string nameRuAttr = definition.NameRu ?? string.Empty;

            if (string.Equals(code, "quantity", StringComparison.OrdinalIgnoreCase))
            {
                return quantity;
            }

            if (string.Equals(code, "measure_unit", StringComparison.OrdinalIgnoreCase)
                || string.Equals(dictionaryCode, "MEASURE_UNIT", StringComparison.OrdinalIgnoreCase))
            {
                return ResolveMeasureUnitCode(article);
            }

            if (string.Equals(code, "country", StringComparison.OrdinalIgnoreCase)
                || string.Equals(dictionaryCode, "COUNTRY", StringComparison.OrdinalIgnoreCase))
            {
                return "KZ";
            }

            if (string.Equals(code, "tnved", StringComparison.OrdinalIgnoreCase)
                || string.Equals(dictionaryCode, "TNVED", StringComparison.OrdinalIgnoreCase))
            {
                return tnved;
            }

            if (string.Equals(code, "gtin", StringComparison.OrdinalIgnoreCase))
            {
                return gtin;
            }

            if (string.Equals(code, "name_ru", StringComparison.OrdinalIgnoreCase))
            {
                return nameRu;
            }

            if (string.Equals(code, "name_kk", StringComparison.OrdinalIgnoreCase))
            {
                return nameKk;
            }

            if (string.Equals(code, "short_name_ru", StringComparison.OrdinalIgnoreCase))
            {
                return shortRu;
            }

            if (string.Equals(code, "short_name_kk", StringComparison.OrdinalIgnoreCase))
            {
                return shortKk;
            }

            if (string.Equals(code, "article", StringComparison.OrdinalIgnoreCase))
            {
                return article?.Code?.Trim();
            }

            if (nameRuAttr.IndexOf("производител", StringComparison.OrdinalIgnoreCase) >= 0
                || nameRuAttr.IndexOf("изготовител", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                return manufacturer;
            }

            // Category-specific advanced string fields (e.g. a4282e5d) — use manufacturer as best effort.
            if (string.Equals(definition.AttributeType, "advanced", StringComparison.OrdinalIgnoreCase)
                && string.Equals(dataType, "string", StringComparison.OrdinalIgnoreCase))
            {
                return manufacturer;
            }

            return null;
        }

        private static void SetAttribute(Dictionary<string, NktAttributeValue> attributes, string code, string value)
        {
            if (string.IsNullOrWhiteSpace(code) || string.IsNullOrWhiteSpace(value))
            {
                return;
            }

            attributes[code] = new NktAttributeValue { Code = code, Value = value };
        }

        private static string Truncate(string value, int maxLength)
        {
            if (string.IsNullOrEmpty(value) || value.Length <= maxLength)
            {
                return value;
            }

            return value.Substring(0, maxLength);
        }
    }
}
