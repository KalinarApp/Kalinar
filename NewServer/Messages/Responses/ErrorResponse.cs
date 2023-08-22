using System.Text.Json.Serialization;

namespace Kalinar.Application.Messages.Responses
{
    public class ErrorResponse
    {
        [JsonPropertyName("type")]
        public required string Type { get; init; }
        [JsonPropertyName("errors")]
        public required List<string> Errors { get; init; }
    }
}
