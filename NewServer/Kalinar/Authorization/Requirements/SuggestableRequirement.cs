using Kalinar.Authorization.Actions;
using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Requirements
{
    public class SuggestableRequirement : IAuthorizationRequirement
    {
        public SuggestableAction Action { get; }

        public SuggestableRequirement(SuggestableAction action)
        {
            this.Action = action;
        }
    }
}
