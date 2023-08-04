using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Requests
{
    public class RaceUpdateRequest
    {
        [Required]
        [MaxLength(128, ErrorMessage = $"{nameof(Name)} cannot be longer than 128 characters")]
        public required string Name { get; init; }
        [MaxLength(2048, ErrorMessage = $"{nameof(Description)} cannot be longer than 2048 characters")]
        public string? Description { get; init; }
    }
}
