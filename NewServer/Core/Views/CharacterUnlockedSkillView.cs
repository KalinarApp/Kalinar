using Kalinar.Core.Entities;

namespace Kalinar.Core.Views
{
    public class CharacterUnlockedSkillView
    {
        public required Guid CharacterId { get; init; }
        public required Guid SkillId { get; init; }
        public required SkillEntity Skill { get; init; }
    }
}
