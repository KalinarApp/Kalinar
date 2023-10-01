using Kalinar.Authorization.Actions;
using Kalinar.Authorization.Requirements;
using Kalinar.Core.Entities;
using Kalinar.Core.Extensions;
using Kalinar.Extensions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Handlers
{
    public class StoryHandler : AuthorizationHandler<StoryRequirement, GroupEntity>
    {
        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, StoryRequirement requirement, GroupEntity resource)
        {
            string userId = context.User.GetId();

            switch (requirement.Action)
            {
                case StoryAction.Create:
                case StoryAction.Update:
                case StoryAction.Delete:
                {
                    if (resource.HasMemberWithAnyRole(userId, new[] { Role.Owner, Role.Administrator }))
                    {
                        context.Succeed(requirement);
                        return Task.CompletedTask;
                    }

                    context.Fail(new AuthorizationFailureReason(this, $"User is not allowed to execute '{requirement.Action}' action"));
                    return Task.CompletedTask;
                }
                default:
                {
                    context.Fail(new AuthorizationFailureReason(this, $"User is not allowed to execute '{requirement.Action}' action"));
                    return Task.CompletedTask;
                }
            }
        }
    }
}
