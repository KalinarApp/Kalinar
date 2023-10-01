using Kalinar.Authorization.Actions;
using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Requirements
{
    public class AbilityRequirement : IAuthorizationRequirement
    {
        public AbilityAction Action { get; }

        public AbilityRequirement(AbilityAction action)
        {
            this.Action = action;
        }
    }
}
