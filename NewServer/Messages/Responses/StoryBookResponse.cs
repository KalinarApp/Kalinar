using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class StoryBookResponse
    {
        public required Guid Id { get; init; }
        public required string Title { get; init; }
        public string? ImageUrl { get; init; }
        public required bool IsUnlocked { get; init; }
        public required DateTimeOffset CreatedAt { get; init; }
        public DateTimeOffset? ModifiedAt { get; init; }

        public static implicit operator StoryBookResponse(StoryBookEntity storyBook)
        {
            return new()
            {
                Id = storyBook.Id,
                Title = storyBook.Title,
                ImageUrl = storyBook.ImageUrl,
                IsUnlocked = storyBook.IsUnlocked,
                CreatedAt = storyBook.CreatedAt,
                ModifiedAt = storyBook.ModifiedAt
            };
        }
    }
}
