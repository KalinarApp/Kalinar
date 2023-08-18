using Hero.Server.Core.Models;

namespace Hero.Server.Messages.Responses
{
    public class UserResponse
    {
        public required string Id { get; set; }
        public required string Email { get; set; }
        public required string Username { get; set; }

        public GroupResponse? Group { get; set; }
        public GroupResponse? OwnedGroup { get; set; }


        public static implicit operator UserResponse(User user)
        {
            return new()
            {
                Id = user.Id,
                Email = user.Email,
                Username = user.Username,
                Group   = user.Group is null ? null : (GroupResponse)user.Group,
                OwnedGroup = user.Group is null ? null : (GroupResponse)user.Group
            };
        }
    }
}
