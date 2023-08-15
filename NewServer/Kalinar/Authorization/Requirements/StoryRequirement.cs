using Kalinar.Authorization.Actions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Requirements
{
    public class StoryRequirement : IAuthorizationRequirement
    {
        public StoryAction Action { get; }

        public StoryRequirement(StoryAction action)
        {
            this.Action = action;
        }
    }
}
