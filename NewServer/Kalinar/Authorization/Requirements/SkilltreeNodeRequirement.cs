using Kalinar.Authorization.Actions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Requirements
{
    public class SkilltreeNodeRequirement : IAuthorizationRequirement
    {
        public SkilltreeNodeAction Action { get; }

        public SkilltreeNodeRequirement(SkilltreeNodeAction action)
        {
            this.Action = action;
        }
    }
}
