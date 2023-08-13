using Kalinar.Core.Entities;

namespace Kalinar.Core.Extensions
{
    public static class GroupEntityExtensions
    {
        public static bool HasMember(this GroupEntity group, string userId)
        {
            return group.Members.Any(m => m.UserId == userId);
        }

        public static bool HasMemberWithRole(this GroupEntity group, string userId, Role role)
        {
            return group.Members.Any(member => userId == member.UserId && member.Role == role);
        }

        public static bool HasMemberWithAnyRole(this GroupEntity group, string userId, Role[] roles)
        {
            return roles.Any(role => group.HasMemberWithRole(userId, role));
        }
    }
}
