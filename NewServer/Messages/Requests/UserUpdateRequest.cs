using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Requests
{
    public class UserUpdateRequest
    {
        [Required]
        [MaxLength(128, ErrorMessage = $"{nameof(Username)} cannot be longer than 128 characters")]
        public required string Username { get; init; }
        public string? ImageUrl { get; init; }
        
    }
}
