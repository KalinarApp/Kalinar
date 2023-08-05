using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Requests
{
    public class StoryBookPageCreateRequest
    {
        [Required]
        public required Guid BookId { get; init; }
        [Required]

        [MaxLength(128, ErrorMessage = $"{nameof(Title)} cannot be longer than 128 characters")]
        public required string Title { get; init; }

        [Required]
        public required string Content { get; init; }
        public string? ImageUrl { get; init; }
        [Required]
        public bool IsUnlocked { get; init; }
        [Required]
        [Range(0, Int32.MaxValue)]
        public required int PageNumber { get; init; }
    }
}
