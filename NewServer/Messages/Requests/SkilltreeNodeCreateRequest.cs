using Kalinar.Messages.Attributes;

using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Requests
{
    public class SkilltreeNodeCreateRequest
    {
        [Required]
        public required Guid SkilltreeId { get; init; }
        [Required]
        [Range(1, 10)]
        public required int Importance { get; init; }
        [Required]
        [Range(0, Int32.MaxValue)]
        public required int Cost { get; init; }
        [Required]
        [Range(0, Double.MaxValue)]
        public required double XPos { get; init; }
        [Required]
        [Range(0, Double.MaxValue)]
        public required double YPos { get; init; }
        [Required]
        [IsHexColor]
        public required string Color { get; init; }
        [Required]
        public required bool IsEasyReachable { get; init; }
        [Required]
        public required Guid SkillId { get; init; }

    }
}
