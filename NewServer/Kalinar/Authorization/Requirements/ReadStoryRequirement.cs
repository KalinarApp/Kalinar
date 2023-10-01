using Kalinar.Authorization.Actions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Requirements
{
    public class ReadStoryRequirement : IAuthorizationRequirement
    {
        public StoryAction Action { get; }

        public ReadStoryRequirement(StoryAction action)
        {
            this.Action = action;
        }
    }
}
