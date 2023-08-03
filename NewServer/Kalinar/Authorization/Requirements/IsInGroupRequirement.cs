using Kalinar.Authorization.Actions;
using Kalinar.Core.Entities;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Requirements
{
    public class IsInGroupRequirement : IAuthorizationRequirement
    {
        public Role[] NeededRoles { get; }

        public IsInGroupRequirement(Role[] neededRoles)
        {
            this.NeededRoles = neededRoles;
        }
    }
}
