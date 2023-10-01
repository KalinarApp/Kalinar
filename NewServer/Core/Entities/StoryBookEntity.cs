namespace Kalinar.Core.Entities
{
    public class StoryBookEntity : StoryEntity
    {
        public required string Title { get; set; }
        public string? Description { get; set; }
        public string? ImageUrl { get; set; }
        public required IEnumerable<StoryBookPageEntity> Pages { get; set; }
    }
}
