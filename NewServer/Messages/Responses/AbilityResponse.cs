using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class AbilityResponse : SuggestableResponse
    {
        public required string Name { get; init; }
        public required bool IsPassive { get; init; }
        public string? Description { get; init; }

        public static implicit operator AbilityResponse(AbilityEntity ability)
        {
            return new()
            {
                Id = ability.Id,
                GroupId = ability.GroupId,
                CreatorId = ability.CreatorId,
                Name = ability.Name,
                Description = ability.Description,
                IsPassive = ability.IsPassive,
                State = ability.State.ToString(),
                ApprovedAt = ability.ApprovedAt,
                ModifiedAt = ability.ModifiedAt,
                RejectedAt = ability.RejectedAt,
                RejectionReason = ability.RejectionReason,
            };
        }
    }
}
