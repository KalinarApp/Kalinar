namespace Kalinar.Core.Entities
{
    public class StoryBookPageEntity
    {
        public required Guid Id{ get; init; }
        public required Guid BookId { get; init; }
        public required int PageNumber { get; set; }
        public required string Title { get; set; }
        public required string Content { get; set; }
        public required bool IsUnlocked { get; set; }
    }
}
