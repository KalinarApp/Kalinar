using Kalinar.Authorization.Actions;
using Kalinar.Authorization.Requirements;
using Kalinar.Core.Entities;
using Kalinar.Core.Extensions;
using Kalinar.Extensions;

using Microsoft.AspNetCore.Authorization;

using System.Security.Claims;

namespace Kalinar.Authorization.Handlers
{
    public class GroupHandler : AuthorizationHandler<GroupRequirement, GroupEntity>
    {
        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, GroupRequirement requirement, GroupEntity group)
        {
            string? userId = context.User.FindFirstValue(ClaimTypes.Sid);

            if (userId is null)
            {
                context.Fail(new AuthorizationFailureReason(this, "Invalid access token - user id not found"));
                return Task.CompletedTask;
            }

            switch (requirement.Action)
            {
                case GroupAction.Create:
                {
                    context.Succeed(requirement);
                    return Task.CompletedTask;
                }
                case GroupAction.List when context.User.IsInRole(RoleNames.Administrator):
                case GroupAction.Read when context.User.IsInRole(RoleNames.Administrator):
                case GroupAction.Update when context.User.IsInRole(RoleNames.Administrator):
                case GroupAction.Delete when context.User.IsInRole(RoleNames.Administrator):
                {
                    context.Succeed(requirement);
                    return Task.CompletedTask;
                }
                case GroupAction.Update when group.IsMemberWithAnyRole(userId, new[] { Role.Owner, Role.Administrator }):
                case GroupAction.Delete when group.IsMemberWithAnyRole(userId, new[] { Role.Owner, Role.Administrator }):
                {
                    context.Succeed(requirement);
                    return Task.CompletedTask;
                }
                case GroupAction.List when group.IsMember(userId):
                case GroupAction.Read when group.IsMember(userId):
                {
                    context.Succeed(requirement);
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
