using Kalinar.Authorization.Actions;
using Kalinar.Core.Entities;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Requirements
{
    public class IsInGroupRequirement : IAuthorizationRequirement
    {
        public RoleEntity[] NeededRoles { get; }

        public IsInGroupRequirement(RoleEntity[] neededRoles)
        {
            this.NeededRoles = neededRoles;
        }
    }
}
