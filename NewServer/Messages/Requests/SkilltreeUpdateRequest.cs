using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Requests
{
    public class SkilltreeUpdateRequest
    {
        [Required]
        [MaxLength(128, ErrorMessage = $"{nameof(Name)} cannot be longer than 128 characters")]
        public required string Name { get; set; }
        [Required]
        public required bool IsActive { get; set; }
        [Required]
        [Range(0, Int32.MaxValue)]
        public required int Points { get; set; }
        public Guid? CharacterId { get; set; }
    }
}
