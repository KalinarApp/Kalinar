using Hero.Server.Core.Models;

namespace Hero.Server.Messages.Responses
{
    public class CharacterSkillResponse
    {
        public required Guid Id { get; init; }
        public Guid? AbilityId { get; init; }
        public string? IconUrl { get; init; }
        public required string Name { get; init; }
        public string? Description { get; init; }
        public required bool IsFavorite { get; init; }
        public AbilityResponse? Ability { get; init; }
        public required List<AttributeValueResponse> Attributes { get; init; }

        public static implicit operator CharacterSkillResponse(SkilltreeNode node)
        {
            if (node.Skill is null) throw new ArgumentNullException(nameof(node.Skill));
            return new()
            {
                Id = node.SkillId!.Value,
                AbilityId = node.Skill.AbilityId,
                Ability = node.Skill.Ability is null ? null : (AbilityResponse)node.Skill.Ability,
                Attributes = node.Skill.Attributes.Select(item => (AttributeValueResponse)item).ToList(),
                IconUrl = node.Skill.IconUrl,
                Name = node.Skill.Name,
                Description = node.Skill.Description,
                IsFavorite = node.IsFavorite,
            };

        }
    }
}
