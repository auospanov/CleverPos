using Newtonsoft.Json.Linq;
using System;

namespace LogicPOS.PaymentTerminals.Kaspi
{
    internal class KaspiApiResponse
    {
        public int StatusCode { get; set; }
        public string ErrorText { get; set; }
        public JObject Data { get; set; }

        public static KaspiApiResponse FromJson(string json)
        {
            if (string.IsNullOrWhiteSpace(json))
            {
                return new KaspiApiResponse { StatusCode = -1, ErrorText = "Empty response" };
            }

            JObject root = JObject.Parse(json);
            KaspiApiResponse response = new KaspiApiResponse
            {
                StatusCode = root.Value<int?>("statusCode") ?? -1,
                ErrorText = root.Value<string>("errorText"),
                Data = root["data"] as JObject
            };
            return response;
        }

        public bool IsSuccess => StatusCode == 0;
    }

    public class KaspiRegisterResult
    {
        public bool Success { get; set; }
        public string AccessToken { get; set; }
        public string RefreshToken { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public string Message { get; set; }
    }

    public class KaspiPaymentStatusResult
    {
        public bool Success { get; set; }
        public string ProcessId { get; set; }
        public string Status { get; set; }
        public string SubStatus { get; set; }
        public string TransactionId { get; set; }
        public string Rrn { get; set; }
        public string AuthorizationCode { get; set; }
        /// <summary>Payment channel from chequeInfo.method (Card / Qr).</summary>
        public string Method { get; set; }
        public string Message { get; set; }
    }
}
