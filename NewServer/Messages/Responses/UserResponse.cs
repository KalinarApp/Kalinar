using Kalinar.Core.Entities;

namespace Kalinar.Application.Messages.Responses
{
    public class UserResponse
    {
        public required string Id { get; init; }
        public required string Username { get; set; }

        public static implicit operator UserResponse(UserEntity user)
        {
            return new()
            {
                Id = user.Id,
                Username = user.Username,
            };
        }
    }
}
