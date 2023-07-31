using Kalinar.Authorization.Actions;
using Kalinar.Authorization.Requirements;
using Kalinar.Core.Entities;
using Kalinar.Extensions;

using Microsoft.AspNetCore.Authorization;

using System.Security.Claims;

namespace Kalinar.Authorization.Handlers
{
    public class IsInGroupHandler : AuthorizationHandler<IsInGroupRequirement, GroupEntity>
    {
        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, IsInGroupRequirement requirement, GroupEntity group)
        {
            string? userId = context.User.FindFirstValue(ClaimTypes.Sid);

            if (userId is null)
            {
                context.Fail(new AuthorizationFailureReason(this, "Invalid access token - user id not found"));
            }
            else if (group.IsMemberWithAnyRole(userId, requirement.NeededRoles))
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
