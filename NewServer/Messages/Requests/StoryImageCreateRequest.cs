using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Requests
{
    public class StoryImageCreateRequest
    {
        [Required]
        public required Guid GroupId { get; init; }
        [Required]

        [MaxLength(128, ErrorMessage = $"{nameof(Title)} cannot be longer than 128 characters")]
        public required string Title { get; init; }
        [Required]
        public required string ImageUrl { get; init; }
        [Required]
        public bool IsUnlocked { get; init; }
        [Required]
        [Range(0, Int32.MaxValue)]
        public required int Order { get; init; }
    }
}
