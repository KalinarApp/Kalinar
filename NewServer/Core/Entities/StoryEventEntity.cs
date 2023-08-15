namespace Kalinar.Core.Entities
{
    public class StoryEventEntity : StoryEntity
    {
        public required string Title { get; set; }
        public string? Description { get; set; }
        public required int Order { get; set; }
        public string? Date { get; set; }
    }
}
