﻿using Kalinar.Core.Entities;

namespace Kalinar.Extensions
{
    public static class GroupEntityExtensions
    {
        public static bool IsMember(this GroupEntity group, string userId)
        {
            return group.Members.Any(m => m.UserId == userId);
        }

        public static bool IsMemberWithRole(this GroupEntity group, string userId, RoleEntity role)
        {
            return group.Members.Any(member => userId == member.UserId && member.Role == role);
        }

        public static bool IsMemberWithAnyRole(this GroupEntity group, string userId, RoleEntity[] roles)
        {
            return roles.Any(role => group.IsMemberWithRole(userId, role));
        }
    }
}
