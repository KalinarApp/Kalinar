using Kalinar.Authorization.Requirements;
using Kalinar.Core.Entities;
using Kalinar.Core.Extensions;
using Kalinar.Extensions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Handlers
{
    public class IsInGroupHandler : AuthorizationHandler<IsInGroupRequirement, GroupEntity>
    {
        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, IsInGroupRequirement requirement, GroupEntity group)
        {
            string userId = context.User.GetId();

            if (group.IsMember(userId))
            {
                context.Succeed(requirement);
            }
            else
            {
                context.Fail(new AuthorizationFailureReason(this, $"User has none of the required roles to access the resource"));
            }

            return Task.CompletedTask;
        }
    }
}
