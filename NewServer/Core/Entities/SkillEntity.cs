namespace Kalinar.Core.Entities
{
    public class SkillEntity : SuggestableEntity
    {
        public required string Name { get; set; }
        public string? IconUrl { get; set; }
        public string? Description { get; set; }
        public Guid? AbilityId { get; set; }
        public AbilityEntity? Ability { get; set; }
        public required IEnumerable<SkillAttributeEntity> Attributes { get; set; }
    }
}
