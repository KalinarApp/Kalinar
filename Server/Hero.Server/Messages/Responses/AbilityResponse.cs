using Hero.Server.Core.Models;

namespace Hero.Server.Messages.Responses
{
    public class AbilityResponse : SuggestableResponse
    {
        public required Guid Id { get; set; }
        public required string Name { get; set; }
        public required bool IsPassive { get; set; }
        public string? Description { get; set; }
        public List<string>? Tags { get; set; }


        public static implicit operator AbilityResponse(Ability ability)
        {
            return new()
            {
                Id = ability.Id,
                Name = ability.Name,
                Description = ability.Description,
                Tags = ability.Tags,
                Creator = ability.Creator,
                IsPassive = ability.IsPassive,
                ApprovedAt = ability.ApprovedAt,
                CreatedAt = ability.CreatedAt,
                LastUpdatedAt = ability.LastUpdatedAt,
                RejectedAt = ability.RejectedAt,
                RejectionReason = ability.RejectionReason,
                State = ability.State
            };
        }
    }
}