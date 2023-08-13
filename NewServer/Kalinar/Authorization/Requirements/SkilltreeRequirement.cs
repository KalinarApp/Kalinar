using Kalinar.Authorization.Actions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Requirements
{
    public class SkilltreeRequirement : IAuthorizationRequirement
    {
        public SkilltreeAction Action { get; }

        public SkilltreeRequirement(SkilltreeAction action)
        {
            this.Action = action;
        }
    }
}
