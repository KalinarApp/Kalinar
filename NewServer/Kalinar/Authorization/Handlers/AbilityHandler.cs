using Kalinar.Application.Contracts;
using Kalinar.Authorization.Actions;
using Kalinar.Authorization.Requirements;
using Kalinar.Core.Entities;
using Kalinar.Core.Extensions;
using Kalinar.Extensions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Handlers
{
    public class AbilityHandler : AuthorizationHandler<AbilityRequirement, AbilityEntity>
    {
        private readonly IServiceProvider serviceProvider;

        public AbilityHandler(IServiceProvider serviceProvider)
        {
            this.serviceProvider = serviceProvider;
        }

        protected override async Task HandleRequirementAsync(AuthorizationHandlerContext context, AbilityRequirement requirement, AbilityEntity resource)
        {
            string userId = context.User.GetId();

            using AsyncServiceScope scope = this.serviceProvider.CreateAsyncScope();
            IGroupService groupService = scope.ServiceProvider.GetRequiredService<IGroupService>();
            GroupEntity group = await groupService.GetByIdAsync(resource.GroupId, true);

            switch (requirement.Action) 
            {
                case AbilityAction.SetTags:
                {
                    if (group.HasMember(userId))
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
