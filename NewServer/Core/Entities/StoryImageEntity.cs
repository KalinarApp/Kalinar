namespace Kalinar.Core.Entities
{
    public class StoryImageEntity : StoryEntity
    {
        public required string Title { get; set; }
        public required string ImageUrl { get; set; }
        public required int Order { get; set; }
    }
}
