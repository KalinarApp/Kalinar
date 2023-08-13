using Kalinar.Application.Contracts;
using Kalinar.Authorization.Actions;
using Kalinar.Authorization.Requirements;
using Kalinar.Core.Entities;
using Kalinar.Core.Extensions;
using Kalinar.Extensions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Handlers
{
    public class CharacterHandler : AuthorizationHandler<CharacterRequirement, CharacterEntity>
    {
        private readonly IServiceProvider serviceProvider;

        public CharacterHandler(IServiceProvider serviceProvider)
        {
            this.serviceProvider = serviceProvider;
        }

        protected override async Task HandleRequirementAsync(AuthorizationHandlerContext context, CharacterRequirement requirement, CharacterEntity resource)
        {
            string userId = context.User.GetId();

            await using AsyncServiceScope scope = this.serviceProvider.CreateAsyncScope();
            IGroupService groupService = scope.ServiceProvider.GetRequiredService<IGroupService>();
            GroupEntity group = await groupService.GetByIdAsync(resource.GroupId, true);

            switch (requirement.Action)
            {
                case CharacterAction.Read:
                {
                    if (group.HasMember(userId))
                    {
                        context.Succeed(requirement);
                        return;
                    }

                    context.Fail(new AuthorizationFailureReason(this, $"User is not allowed to execute '{requirement.Action}' action"));
                    return;
                }
                case CharacterAction.Update:
                case CharacterAction.Delete:
                {
                    if (resource.UserId == userId)
                    {
                        context.Succeed(requirement);
                        return;
                    }

                    context.Fail(new AuthorizationFailureReason(this, $"User is not allowed to execute '{requirement.Action}' action"));
                    return;
                }
                default:
                {
                    context.Fail(new AuthorizationFailureReason(this, $"User is not allowed to execute '{requirement.Action}' action"));
                    return;
                }
            }
        }
    }
}
