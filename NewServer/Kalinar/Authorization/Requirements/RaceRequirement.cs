using Kalinar.Authorization.Actions;
using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Requirements
{
    public class RaceRequirement : IAuthorizationRequirement
    {
        public RaceAction Action { get; }

        public RaceRequirement(RaceAction action)
        {
            this.Action = action;
        }
    }
}
