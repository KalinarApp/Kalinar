using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class SkillResponse : SuggestableResponse
    {
        public required string Name { get; set; }
        public string? IconUrl { get; set; }
        public string? Description { get; set; }
        public Guid? AbilityId { get; set; }
        public AbilityResponse? Ability { get; set; }

        public static implicit operator SkillResponse(SkillEntity skill)
        {
            return new()
            {
                Id = skill.Id,
                GroupId = skill.GroupId,
                CreatorId = skill.CreatorId,
                Name = skill.Name,
                Description = skill.Description,
                AbilityId = skill.AbilityId,
                Ability = skill.Ability is not null ? (AbilityResponse)skill.Ability : null,
                IconUrl = skill.IconUrl,
                State = skill.State.ToString(),
                CreatedAt = skill.CreatedAt,
                ApprovedAt = skill.ApprovedAt,
                ModifiedAt = skill.ModifiedAt,
                RejectedAt = skill.RejectedAt,
                RejectionReason = skill.RejectionReason,
            };
        }
    }
}
