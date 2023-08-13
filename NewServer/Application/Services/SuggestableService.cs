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

            bool isAdmin = group.HasMemberWithAnyRole(userId, new[] { Role.Owner, Role.Administrator });

            entity.State = isAdmin ? SuggestionState.Approved : SuggestionState.Pending;
        } 

        protected void ApproveSuggestable(SuggestableEntity entity)
        {
            entity.State = SuggestionState.Approved;
            entity.ApprovedAt = DateTimeOffset.UtcNow;
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