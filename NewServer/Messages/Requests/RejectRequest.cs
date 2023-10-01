using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Requests
{
    public class RejectRequest
    {
        [Required]
        [MaxLength(2048, ErrorMessage = $"{nameof(Reason)} cannot be longer than 2048 characters")]
        public required string Reason { get; init; }
    }
}
