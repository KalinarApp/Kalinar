using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class StoryBookPageResponse
    {
        public required Guid Id { get; init; }
        public required Guid BookId { get; init; }
        public required int PageNumber { get; init; }
        public required string Title { get; init; }
        public required string Content { get; init; }
        public required bool IsUnlocked { get; init; }

        public static implicit operator StoryBookPageResponse(StoryBookPageEntity page)
        {
            return new StoryBookPageResponse
            {
                Id = page.Id,
                BookId = page.BookId,
                PageNumber = page.PageNumber,
                Title = page.Title,
                Content = page.Content,
                IsUnlocked = page.IsUnlocked
            };
        }
    }
}
