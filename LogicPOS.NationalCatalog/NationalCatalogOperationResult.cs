namespace LogicPOS.NationalCatalog
{
    public enum NationalCatalogResultCode
    {
        Success,
        AlreadyRegistered,
        LinkedExisting,
        ValidationError,
        ApiError,
        NotConfigured,
        NotFound
    }

    public class NationalCatalogOperationResult
    {
        public NationalCatalogResultCode Code { get; set; }
        public string Message { get; set; }
        public string Status { get; set; }
        public long? RequestId { get; set; }

        public static NationalCatalogOperationResult Ok(string message, string status = null, long? requestId = null)
        {
            return new NationalCatalogOperationResult
            {
                Code = NationalCatalogResultCode.Success,
                Message = message,
                Status = status,
                RequestId = requestId
            };
        }

        public static NationalCatalogOperationResult Fail(NationalCatalogResultCode code, string message)
        {
            return new NationalCatalogOperationResult
            {
                Code = code,
                Message = message
            };
        }
    }
}
