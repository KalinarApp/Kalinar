using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class SkilltreeNodeResponse
    {
        public required Guid Id { get; init; }
        public required int Importance { get; init; }
        public required int Cost { get; init; }
        public required double XPos { get; init; }
        public required double YPos { get; init; }
        public required string Color { get; init; }
        public required bool IsEasyReachable { get; init; }
        public required bool IsUnlocked { get; init; }

        public required Guid SkillId { get; init; }
        public required SkillResponse Skill { get; init; }

        public static implicit operator SkilltreeNodeResponse(SkilltreeNodeEntity node)
        {
            return new SkilltreeNodeResponse
            {
                Id = node.Id,
                Importance = node.Importance,
                Cost = node.Cost,
                XPos = node.XPos,
                YPos = node.YPos,
                Color = node.Color,
                IsEasyReachable = node.IsEasyReachable,
                IsUnlocked = node.IsUnlocked,
                SkillId = node.SkillId,
                Skill = node.Skill
            };
        }
    }
}
