using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Requests
{
    public class UserDeviceIdRequest
    {
        [Required]
        public required string DeviceId { get; init; }
    }
}
