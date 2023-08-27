namespace Kalinar.Messages.Responses
{
    public class SuggestableResponse
    {
        public required Guid Id { get; init; }
        public required Guid GroupId { get; init; }
        public required string CreatorId { get; init; }
        public required string State { get; init; }
        public string? RejectionReason { get; init; }
        public DateTimeOffset CreatedAt { get; init; }
        public DateTimeOffset? ModifiedAt { get; init; }
        public DateTimeOffset? ApprovedAt { get; init; }
        public DateTimeOffset? RejectedAt { get; init; }
    }
}