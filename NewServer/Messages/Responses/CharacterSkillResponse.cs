using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class CharacterSkillResponse
    {
        public required SkillResponse Skill { get; init; }
        public required bool IsFavorite { get; init; }

        public static implicit operator CharacterSkillResponse(CharacterSkillEntity entity)
        {
            return new CharacterSkillResponse()
            {
                Skill = entity.Skill,
                IsFavorite = entity.IsFavorite
            };
        }
    }
}
