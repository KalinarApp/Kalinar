namespace Kalinar.Core.Entities
{
    public class SkilltreeNodeEntity
    {
        public required Guid Id { get; init; }
        public required Guid SkilltreeId { get; set; }
        public required int Importance { get; set; }
        public required int Cost { get; set; }
        public required double XPos { get; set; }
        public required double YPos { get; set; }
        public required string Color { get; set; }
        public required bool IsEasyReachable { get; set; }
        public required bool IsUnlocked { get; set; }
        public required SkilltreeEntity Skilltree { get; set; }

        public Guid? SkillId { get; set; }
        public SkillEntity? Skill { get; set; }
    }
}
