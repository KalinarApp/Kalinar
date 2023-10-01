using Kalinar.Authorization.Actions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Requirements
{
    public class GroupRequirement : IAuthorizationRequirement 
    {
        public GroupAction Action { get; }

        public GroupRequirement(GroupAction action)
        {
            this.Action = action;
        }
    }
}
