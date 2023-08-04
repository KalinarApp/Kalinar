using System.ComponentModel.DataAnnotations;
using System.Xml.Linq;

namespace Kalinar.Application.Messages.Requests
{
    public class UserUpdateRequest
    {
        [Required]
        [MaxLength(128, ErrorMessage = $"{nameof(Username)} cannot be longer than 128 characters")]
        public required string Username { get; init; }
    }
}
