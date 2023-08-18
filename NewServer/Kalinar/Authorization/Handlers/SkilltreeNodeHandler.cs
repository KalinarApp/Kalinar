using Kalinar.Application.Contracts;
using Kalinar.Authorization.Actions;
using Kalinar.Authorization.Requirements;
using Kalinar.Core.Entities;
using Kalinar.Core.Extensions;
using Kalinar.Extensions;

using Microsoft.AspNetCore.Authorization;

using System.Threading;

namespace Kalinar.Authorization.Handlers
{
    public class SkilltreeNodeHandler : AuthorizationHandler<SkilltreeNodeRequirement, SkilltreeNodeEntity>
    {
        private readonly IServiceProvider provider;

        public SkilltreeNodeHandler(IServiceProvider provider)
        {
            this.provider = provider;
        }

        protected override async Task HandleRequirementAsync(AuthorizationHandlerContext context, SkilltreeNodeRequirement requirement, SkilltreeNodeEntity resource)
        {
            string userId = context.User.GetId();
            await using AsyncServiceScope scope = provider.CreateAsyncScope();
            ISkilltreeService skilltreeService= scope.ServiceProvider.GetRequiredService<ISkilltreeService>();
            IGroupService groupService= scope.ServiceProvider.GetRequiredService<IGroupService>();
            ICharacterService characterService= scope.ServiceProvider.GetRequiredService<ICharacterService>();

            SkilltreeEntity skilltree = await skilltreeService.GetByIdAsync(resource.SkilltreeId);
            GroupEntity group = await groupService.GetByIdAsync(skilltree.GroupId);

            if (!skilltree.CharacterId.HasValue)
            {
                context.Fail(new AuthorizationFailureReason(this, $"User is not allowed to execute '{requirement.Action}' action"));
                return;
            }

            CharacterEntity character = await characterService.GetByIdAsync(skilltree.CharacterId.Value);

            switch (requirement.Action)
            {
                case SkilltreeNodeAction.Unlock:
                {
                    if (character.UserId == userId)
                    {
                        context.Succeed(requirement);
                        break;
                    }
                    else
                    {
                        context.Fail(new AuthorizationFailureReason(this, $"User is not allowed to execute '{requirement.Action}' action"));
                    }

                    break;
                }
                case SkilltreeNodeAction.Reset:
                {
                    if (group.HasMemberWithAnyRole(userId, new[] { Role.Owner, Role.Administrator }))
                    {
                        context.Succeed(requirement);
                    }
                    else if(character.UserId == userId && resource.UnlockedAt.HasValue && (DateTimeOffset.UtcNow - resource.UnlockedAt).Value.TotalMinutes <= 5)
                    {
                        context.Succeed(requirement);
                    }
                    else
                    {
                        context.Fail(new AuthorizationFailureReason(this, $"User is not allowed to execute '{requirement.Action}' action"));
                    }

                    break;
                }
                default:
                {
                    context.Fail(new AuthorizationFailureReason(this, $"User is not allowed to execute '{requirement.Action}' action"));
                    break;
                }
            }
        }
    }
}
