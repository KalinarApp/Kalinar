using Kalinar.Authorization.Actions;
using Kalinar.Authorization.Requirements;
using Kalinar.Core.Entities;
using Kalinar.Core.Extensions;
using Kalinar.Extensions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Handlers
{
    public class ReadStoryHandler : AuthorizationHandler<ReadStoryRequirement, IEnumerable<StoryEntity>>
    {
        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, ReadStoryRequirement requirement, IEnumerable<StoryEntity> resource)
        {
            string userId = context.User.GetId();
            switch (requirement.Action)
            {
                case StoryAction.List:
                case StoryAction.Read:
                {
                    if (resource.FirstOrDefault()?.Group.HasMemberWithAnyRole(userId, new[] {Role.Owner, Role.Administrator }) ?? false)
                    {
                        context.Succeed(requirement);
                        return Task.CompletedTask;
                    }
                    else if (resource.All(item =>  item.IsUnlocked))
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
