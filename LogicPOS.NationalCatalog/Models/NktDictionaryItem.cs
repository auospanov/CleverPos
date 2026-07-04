using Newtonsoft.Json;
using System.Collections.Generic;

namespace LogicPOS.NationalCatalog.Models
{
    public class NktDictionaryItem
    {
        [JsonProperty("id")]
        public long? Id { get; set; }

        [JsonProperty("code")]
        public string Code { get; set; }

        [JsonProperty("nameRu")]
        public string NameRu { get; set; }

        [JsonProperty("nameKk")]
        public string NameKk { get; set; }

        [JsonProperty("hasChildren")]
        public bool? HasChildren { get; set; }

        [JsonProperty("hasChild")]
        public bool? HasChild { get; set; }

        [JsonProperty("leaf")]
        public bool? Leaf { get; set; }

        [JsonProperty("level")]
        public int? Level { get; set; }

        [JsonProperty("properties")]
        public NktDictionaryItemProperties Properties { get; set; }

        public string ResolvedCode
        {
            get
            {
                if (!string.IsNullOrWhiteSpace(Code))
                {
                    return Code.Trim();
                }

                return Properties?.Code?.Trim();
            }
        }

        public bool IsExpandable()
        {
            if (Leaf == true)
            {
                return false;
            }

            if (HasChildren == true || HasChild == true)
            {
                return true;
            }

            return false;
        }

        public string GetDisplayName()
        {
            string nameRu = FirstNonEmpty(NameRu, Properties?.NameRu);
            if (!string.IsNullOrWhiteSpace(nameRu))
            {
                return nameRu.Trim();
            }

            string nameKk = FirstNonEmpty(NameKk, Properties?.NameKk);
            if (!string.IsNullOrWhiteSpace(nameKk))
            {
                return nameKk.Trim();
            }

            return ResolvedCode ?? string.Empty;
        }

        private static string FirstNonEmpty(string first, string second)
        {
            if (!string.IsNullOrWhiteSpace(first))
            {
                return first;
            }

            return second;
        }
    }

    public class NktDictionaryItemProperties
    {
        [JsonProperty("code")]
        public string Code { get; set; }

        [JsonProperty("nameRu")]
        public string NameRu { get; set; }

        [JsonProperty("nameKk")]
        public string NameKk { get; set; }
    }

    public class NktDictionaryItemsPage
    {
        [JsonProperty("content")]
        public List<NktDictionaryItem> Content { get; set; }

        [JsonProperty("totalElements")]
        public int TotalElements { get; set; }

        [JsonProperty("totalPages")]
        public int TotalPages { get; set; }
    }
}
