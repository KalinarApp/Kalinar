namespace Kalinar.Core.Entities
{
    public class SkillAttributeEntity
    {
        public required Guid SkillId { get; init; }
        public required Guid AttributeId { get; init; }
        public required SkillEntity Skill { get; init; }
        public required AttributeEntity Attribute { get; init; }
        public double Value { get; set; }
    }
}
