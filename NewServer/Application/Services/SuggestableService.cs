using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Extensions;

namespace Kalinar.Application.Services
{
    internal class SuggestableService
    {
        protected readonly IGroupService groupService;

        public SuggestableService(IGroupService groupService)
        {
            this.groupService = groupService;
        }

        protected async Task CreateSuggestableAsync(string userId, SuggestableEntity entity, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(entity.GroupId, true, cancellationToken);

            bool isAdmin = group.IsMemberWithAnyRole(userId, new[] { Role.Owner, Role.Administrator });

            entity.State = isAdmin ? SuggestionState.Approved : SuggestionState.Pending;
        } 

        protected async Task UpdateSuggestableAsync(string userId, SuggestableEntity entity, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(entity.GroupId, true, cancellationToken);

            bool isAdmin = group.IsMemberWithAnyRole(userId, new[] { Role.Owner, Role.Administrator });

            if (isAdmin && entity.State == SuggestionState.Pending)
            {
                entity.State = SuggestionState.Approved;
                entity.ApprovedAt = DateTime.UtcNow;
            }
        }

        protected void RejectSuggestable(SuggestableEntity entity, string rejectionReason)
        {
            entity.State = SuggestionState.Rejected;
            entity.RejectedAt = DateTime.UtcNow;
            entity.RejectionReason = rejectionReason;
            entity.ApprovedAt = null;
        }
    }
}