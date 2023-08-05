namespace Kalinar.Core.Entities
{
    public class StoryImageEntity : BaseEntityWithGroup
    {
        public required string Title { get; set; }
        public required string ImageUrl { get; set; }
        public bool IsUnlocked { get; set; }
        public required int Order { get; set; }
    }
}
