using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class GroupMemberResponse
    {
        public required UserResponse User { get; init; }
        public required GroupResponse Group { get; init; }
        public required string Role { get; init; }

        public static implicit operator GroupMemberResponse(GroupMemberEntity member)
        {
            return new()
            {
                User = member.User,
                Group = member.Group,
                Role = member.Role.ToString(),
            };
        }
    }
}
