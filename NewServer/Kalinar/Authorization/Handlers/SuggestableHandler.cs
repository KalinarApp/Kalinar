using Kalinar.Application.Contracts;
using Kalinar.Authorization.Requirements;
using Kalinar.Core.Entities;
using Kalinar.Core.Extensions;
using Kalinar.Extensions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Handlers
{
    public class SuggestableHandler : AuthorizationHandler<SuggestableRequirement, SuggestableEntity>
    {
        private readonly IServiceProvider serviceProvider;

        public SuggestableHandler(IServiceProvider serviceProvider)
        {
            this.serviceProvider = serviceProvider;
        }

        protected override async Task HandleRequirementAsync(AuthorizationHandlerContext context, SuggestableRequirement requirement, SuggestableEntity resource)
        {
            string userId = context.User.GetId();

            using AsyncServiceScope scope = this.serviceProvider.CreateAsyncScope();
            IGroupService groupService = scope.ServiceProvider.GetRequiredService<IGroupService>();
            GroupEntity group = await groupService.GetByIdAsync(resource.GroupId, true);

            switch (requirement.Action) 
            {
                case Actions.SuggestableAction.Read:
                {
                    if (!group.HasMember(userId))
                    {
                        context.Fail(new AuthorizationFailureReason(this, $"User is not allowed to execute '{requirement.Action}' action"));
                        return;
                    }

                    context.Succeed(requirement);
                    return;
                }
                case Actions.SuggestableAction.Approve:
                {
                    if (group.HasMemberWithAnyRole(userId, new[] { Role.Owner, Role.Administrator }))
                    {
                        context.Succeed(requirement);
                        return;
                    }

                    context.Fail(new AuthorizationFailureReason(this, $"User is not allowed to execute '{requirement.Action}' action"));
                    return;
                }
                case Actions.SuggestableAction.Update:
                case Actions.SuggestableAction.Delete:
                {
                    if (group.HasMemberWithAnyRole(userId, new[] { Role.Owner, Role.Administrator }))
                    {
                        context.Succeed(requirement);
                        return;
                    }
                    else if (resource.CreatorId == userId && resource.State == SuggestionState.Pending)
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
