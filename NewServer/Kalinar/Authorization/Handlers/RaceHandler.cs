﻿using Kalinar.Application.Contracts;
using Kalinar.Authorization.Actions;
using Kalinar.Authorization.Requirements;
using Kalinar.Core.Entities;
using Kalinar.Core.Extensions;
using Kalinar.Extensions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Handlers
{
    public class RaceHandler : AuthorizationHandler<RaceRequirement, RaceEntity>
    {
        private readonly IServiceProvider serviceProvider;

        public RaceHandler(IServiceProvider serviceProvider)
        {
            this.serviceProvider = serviceProvider;
        }

        protected override async Task HandleRequirementAsync(AuthorizationHandlerContext context, RaceRequirement requirement, RaceEntity resource)
        {
            string userId = context.User.GetId();

            using AsyncServiceScope scope = this.serviceProvider.CreateAsyncScope();
            IGroupService groupService = scope.ServiceProvider.GetRequiredService<IGroupService>();
            GroupEntity group = await groupService.GetByIdAsync(resource.GroupId, true);

            switch (requirement.Action) 
            {
                case RaceAction.SetAttributes:
                {
                    if (group.IsMemberWithAnyRole(userId, new[] { Role.Owner, Role.Administrator }))
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
