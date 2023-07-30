namespace Kalinar.Messages.Responses
{
    public class ErrorResponse
    {
        public required string Type { get; init; }
        public required List<string> Errors { get; init; }
    }
}
