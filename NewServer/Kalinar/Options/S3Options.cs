namespace Kalinar.Options
{
    public class S3Options
    {
        public required string AccessKey { get; init; }
        public required string SecretKey { get; init; }
        public required string TenantId { get; init; }
        public required string Bucket { get; init; }
    }
}
