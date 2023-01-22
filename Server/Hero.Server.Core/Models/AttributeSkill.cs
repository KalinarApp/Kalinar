namespace Hero.Server.Core.Models
{
    public class AttributeSkill
    {
        public Guid AttributeId { get; set; }
        public Guid SkillId { get; set; }
        public Attribute Attribute { get; set; }
        public Skill Skill { get; set; }
        public double Value { get; set; }

    }
}
