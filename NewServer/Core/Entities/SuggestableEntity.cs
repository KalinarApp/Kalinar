namespace Kalinar.Core.Entities
{
    public class SuggestableEntity : BaseEntityWithGroup
    {
        public required string CreatorId { get; init; }
        public required UserEntity Creator { get; init; }
        public required SuggestionState State { get; set; }
        public string? RejectionReason { get; set; }
        public DateTimeOffset? ModifiedAt { get; set; }
        public DateTimeOffset? ApprovedAt { get; set; }
        public DateTimeOffset? RejectedAt { get; set; }
    }
}
