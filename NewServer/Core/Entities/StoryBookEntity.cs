namespace Kalinar.Core.Entities
{
    public class StoryBookEntity : StoryEntity
    {
        public required string Title { get; set; }
        public string? Description { get; set; }
        public string? ImageUrl { get; set; }
        public required int Order { get; set; }
        public required List<StoryBookPageEntity> Pages { get; set; }
    }
}
