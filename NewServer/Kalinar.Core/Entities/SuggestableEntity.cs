namespace Kalinar.Core.Entities
{
    public class SuggestableEntity
    {
        public required Guid Id { get; init; }
        public required string CreatorId { get; init; }
        public required Guid GroupId { get; init; }
        public required SuggestionState State { get; init; }
        public string? RejectionReason { get; set; }
        public required DateTimeOffset CreatedAt { get; init; }
        public DateTimeOffset? ModifiedAt { get; set; }
        public DateTimeOffset? ApprovedAt { get; set; }
        public DateTimeOffset? RejectedAt { get; set; }
        public required UserEntity Creator { get; init; }
        public required GroupEntity Group { get; init; }
    }
}
