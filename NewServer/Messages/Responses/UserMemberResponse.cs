using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class UserMemberResponse
    {
        public required GroupResponse Group { get; init; }
        public required string Role { get; init; }

        public static implicit operator UserMemberResponse(GroupMemberEntity member)
        {
            return new()
            {
                Group = member.Group,
                Role = member.Role.ToString(),
            };
        }
    }
}
