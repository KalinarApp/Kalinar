using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class StoryImageResponse
    {
        public required Guid Id { get; init; }
        public required string Title { get; init; }
        public required string ImageUrl { get; init; }
        public required int Order { get; init; }
        public required bool IsUnlocked { get; init; }

        public static implicit operator StoryImageResponse(StoryImageEntity storyImage)
        {
            return new StoryImageResponse
            {
                Id = storyImage.Id,
                Title = storyImage.Title,
                ImageUrl = storyImage.ImageUrl,
                Order = storyImage.Order,
                IsUnlocked = storyImage.IsUnlocked,
            };
        }
    }
}
