using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class StoryBookResponse
    {
        public required Guid Id { get; init; }
        public required string Title { get; init; }
        public string? ImageUrl { get; init; }
        public required int Order { get; init; }
        public required bool IsUnlocked { get; init; }

        public static implicit operator StoryBookResponse(StoryBookEntity storyBook)
        {
            return new()
            {
                Id = storyBook.Id,
                Title = storyBook.Title,
                ImageUrl = storyBook.ImageUrl,
                Order = storyBook.Order,
                IsUnlocked = storyBook.IsUnlocked,
            };
        }
    }
}
