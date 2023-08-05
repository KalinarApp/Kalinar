namespace Kalinar.Core.Entities
{
    public class StoryEventEntity : BaseEntityWithGroup
    {
        public required string Title { get; set; }
        public string? Description { get; set; }
        public bool IsUnlocked { get; set; }
        public required int Order { get; set; }
        public string? Date { get; set; }
    }
}
