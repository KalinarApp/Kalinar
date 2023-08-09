using Kalinar.Authorization.Actions;
using Kalinar.Authorization.Requirements;
using Kalinar.Core.Entities;
using Kalinar.Extensions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Handlers
{
    public class UserHandler : AuthorizationHandler<UserRequirement, UserEntity>
    {
        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, UserRequirement requirement, UserEntity user)
        {
            string userId = context.User.GetId();

            switch (requirement.Action)
            {
                case UserAction.Create:
                {
                    context.Succeed(requirement);
                    return Task.CompletedTask;
                }
                case UserAction.List:
                case UserAction.Read:
                case UserAction.Update:
                case UserAction.Delete:
                {
                    if (user.Id != userId)
                    {
                        context.Fail(new AuthorizationFailureReason(this, $"User is not allowed to execute '{requirement.Action}' action for user '{user.Username}'"));
                        return Task.CompletedTask;
                    }

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
