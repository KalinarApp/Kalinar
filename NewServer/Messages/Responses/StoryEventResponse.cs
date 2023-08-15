namespace Kalinar.Messages.Responses
{
    public class StoryEventResponse
    {
        public required Guid Id { get; init; }
        public required string Title { get; init; }
        public string? Description { get; init; }
        public bool IsUnlocked { get; init; }
        public required int Order { get; init; }
        public string? Date { get; init; }
    }
}
