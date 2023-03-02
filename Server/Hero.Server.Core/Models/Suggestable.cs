namespace Hero.Server.Core.Models
{
    public class Suggestable
    {
        public Guid Id { get; set; }
        public string CreatorId { get; set; }
        public Guid GroupId { get; set; }

        public SuggestionState State { get; set; }
        public string? RejectionReason { get; set; }

        public DateTimeOffset CreatedAt { get; set; }
        public DateTimeOffset? LastUpdatedAt { get; set; }
        public DateTimeOffset? ApprovedAt { get; set; }
        public DateTimeOffset? RejectedAt { get; set; }

        public User Creator { get; set; }
        public Group Group { get; set; }

        public bool IsOwnerOrAdmin(string userId)
        {
            return (this.CreatorId == userId && this.State == SuggestionState.Pending) ||
                this.Group.OwnerId == userId;
        }
    }
}
