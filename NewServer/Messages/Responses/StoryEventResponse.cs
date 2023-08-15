using Kalinar.Core.Entities;

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

        public static implicit operator StoryEventResponse(StoryEventEntity storyEvent)
        {
            return new StoryEventResponse
            {
                Id = storyEvent.Id,
                Title = storyEvent.Title,
                Description = storyEvent.Description,
                IsUnlocked = storyEvent.IsUnlocked,
                Order = storyEvent.Order,
                Date = storyEvent.Date,
            };
        }
    }
}
