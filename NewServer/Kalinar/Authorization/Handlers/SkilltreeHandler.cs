using Kalinar.Authorization.Actions;
using Kalinar.Authorization.Requirements;
using Kalinar.Core.Entities;
using Kalinar.Core.Extensions;
using Kalinar.Extensions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Handlers
{
    public class SkilltreeHandler : AuthorizationHandler<SkilltreeRequirement, GroupEntity>
    {
        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, SkilltreeRequirement requirement, GroupEntity resource)
        {
            string userId = context.User.GetId();

            switch (requirement.Action)
            {
                case SkilltreeAction.List:
                case SkilltreeAction.Read:
                {
                    if (resource.HasMember(userId))
                    {
                        context.Succeed(requirement);
                        return Task.CompletedTask;
                    }

                    context.Fail(new AuthorizationFailureReason(this, $"User is not allowed to execute '{requirement.Action}' action"));
                    return Task.CompletedTask;
                }
                case SkilltreeAction.Create:
                case SkilltreeAction.Update:
                case SkilltreeAction.Delete:
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
