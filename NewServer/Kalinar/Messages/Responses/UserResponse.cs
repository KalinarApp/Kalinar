using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class UserResponse
    {
        public required string Id { get; init; }
        public required string Email { get; set; }
        public required string Username { get; set; }

        public static implicit operator UserResponse(UserEntity user)
        {
            return new()
            {
                Id = user.Id,
                Email = user.Email,
                Username = user.Username,
            };
        }
    }
}
