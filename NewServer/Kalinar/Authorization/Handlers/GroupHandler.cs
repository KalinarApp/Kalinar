using Kalinar.Authorization.Actions;
using Kalinar.Authorization.Requirements;
using Kalinar.Core.Entities;
using Kalinar.Core.Extensions;
using Kalinar.Extensions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Handlers
{
    public class GroupHandler : AuthorizationHandlerThatSupportsNullableResourceBase<GroupRequirement, GroupEntity>
    {
        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, GroupRequirement requirement, GroupEntity? group)
        {
            string userId = context.User.GetId();

            switch (requirement.Action)
            {
                case GroupAction.Create:
                {
                    context.Succeed(requirement);
                    return Task.CompletedTask;
                }
                case GroupAction.Update when group is not null && group.IsMemberWithAnyRole(userId, new[] { Role.Owner, Role.Administrator }):
                case GroupAction.Delete when group is not null && group.IsMemberWithAnyRole(userId, new[] { Role.Owner, Role.Administrator }):
                {
                    context.Succeed(requirement);
                    return Task.CompletedTask;
                }
                case GroupAction.List when group is not null && group.IsMember(userId):
                case GroupAction.Read when group is not null && group.IsMember(userId):
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
