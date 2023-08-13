using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Requests
{
    public class CharacterUpdateRequest
    {
        [Required]
        [MaxLength(128, ErrorMessage = $"{nameof(Name)} cannot be longer than 128 characters")]
        public required string Name { get; set; }
        [MaxLength(2048, ErrorMessage = $"{nameof(Description)} cannot be longer than 2048 characters")]
        public string? Description { get; set; }
        public string? IconUrl { get; set; }
        public int? Age { get; set; }

        [MaxLength(2048, ErrorMessage = $"{nameof(Inventory)} cannot be longer than 2048 characters")]
        public string? Inventory { get; set; }
        [MaxLength(128, ErrorMessage = $"{nameof(Religion)} cannot be longer than 128 characters")]
        public string? Religion { get; set; }
        [MaxLength(128, ErrorMessage = $"{nameof(Relationship)} cannot be longer than 128 characters")]
        public string? Relationship { get; set; }

        [MaxLength(2048, ErrorMessage = $"{nameof(Notes)} cannot be longer than 2048 characters")]
        public string? Notes { get; set; }

        [MaxLength(128, ErrorMessage = $"{nameof(Profession)} cannot be longer than 128 characters")]
        public string? Profession { get; set; }
    }
}
