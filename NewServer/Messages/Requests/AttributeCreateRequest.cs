using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Requests
{
    public class AttributeCreateRequest
    {
        [Required]
        public required Guid GroupId { get; init; }
        [Required]
        [MaxLength(128, ErrorMessage = $"{nameof(Name)} cannot be longer than 128 characters")]
        public required string Name { get; init; }
        [MaxLength(2048, ErrorMessage = $"{nameof(Description)} cannot be longer than 2048 characters")]
        public string? Description { get; init; }
        public string? Category { get; init; }
        public string? IconData { get; init; }
        [Required]
        public required double MinValue { get; init; }
        [Required]
        public required double MaxValue { get; init; }

        [Required, Range(0, Double.MaxValue)]
        public required double StepSize { get; init; }
    }
}
