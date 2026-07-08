using Newtonsoft.Json;
using System.Collections.Generic;

namespace LogicPOS.NationalCatalog.Models
{
    public class NktAttributeValue
    {
        [JsonProperty("code")]
        public string Code { get; set; }

        [JsonProperty("value")]
        public string Value { get; set; }

        [JsonProperty("index", NullValueHandling = NullValueHandling.Ignore)]
        public int? Index { get; set; }

        [JsonProperty("parent_code", NullValueHandling = NullValueHandling.Ignore)]
        public string ParentCode { get; set; }
    }

    public class NktProductRequestPayload
    {
        [JsonProperty("oktru")]
        public string Oktru { get; set; }

        [JsonProperty("autoPublication")]
        public bool AutoPublication { get; set; }

        [JsonProperty("attributes")]
        public List<NktAttributeValue> Attributes { get; set; }
    }

    public class NktCreateRequestResponse
    {
        [JsonProperty("id")]
        public long Id { get; set; }
    }

    public class NktStatusResponse
    {
        [JsonProperty("code")]
        public string Code { get; set; }

        [JsonProperty("value")]
        public string Value { get; set; }
    }

    public class NktRequestListResponse
    {
        [JsonProperty("content")]
        public List<NktRequestShortItem> Content { get; set; }

        [JsonProperty("totalElements")]
        public int TotalElements { get; set; }

        [JsonProperty("totalPages")]
        public int TotalPages { get; set; }
    }

    public class NktRequestShortItem
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("status")]
        public NktStatusResponse Status { get; set; }

        [JsonProperty("categoryAncestors")]
        public List<NktCategoryAncestor> CategoryAncestors { get; set; }

        [JsonProperty("productData")]
        public NktProductPreviewData ProductData { get; set; }
    }

    public class NktCategoryAncestor
    {
        [JsonProperty("code")]
        public string Code { get; set; }

        [JsonProperty("nameRu")]
        public string NameRu { get; set; }
    }

    public class NktProductPreviewData
    {
        [JsonProperty("nameRu")]
        public string NameRu { get; set; }

        [JsonProperty("nameKk")]
        public string NameKk { get; set; }
    }

    public class NktRequestDetailsResponse
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("status")]
        public NktStatusResponse Status { get; set; }

        [JsonProperty("attributes")]
        public List<NktRequestDetailAttribute> Attributes { get; set; }

        [JsonProperty("categoryAncestors")]
        public List<NktCategoryAncestor> CategoryAncestors { get; set; }
    }

    public class NktRequestDetailAttribute
    {
        [JsonProperty("code")]
        public string Code { get; set; }

        [JsonProperty("value")]
        public string Value { get; set; }
    }

    public class NktAttributeDefinition
    {
        [JsonProperty("code")]
        public string Code { get; set; }

        [JsonProperty("nameRu")]
        public string NameRu { get; set; }

        [JsonProperty("dataType")]
        public string DataType { get; set; }

        [JsonProperty("attributeType")]
        public string AttributeType { get; set; }

        [JsonProperty("isRequired")]
        public bool IsRequired { get; set; }

        [JsonProperty("dictionaryCode")]
        public string DictionaryCode { get; set; }

        [JsonProperty("maxLength")]
        public int? MaxLength { get; set; }
    }
}
