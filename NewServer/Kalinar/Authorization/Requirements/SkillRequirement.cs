using Kalinar.Authorization.Actions;
using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Requirements
{
    public class SkillRequirement : IAuthorizationRequirement
    {
        public SkillAction Action { get; }

        public SkillRequirement(SkillAction action)
        {
            this.Action = action;
        }
    }
}
