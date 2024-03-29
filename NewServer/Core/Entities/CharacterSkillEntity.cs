﻿namespace Kalinar.Core.Entities
{
    public class CharacterSkillEntity
    {
        public required Guid CharacterId { get; init; }
        public required CharacterEntity Character { get; init; }
        public required Guid SkillId { get; init; }
        public required SkillEntity Skill { get; init; }
        public bool IsFavorite { get; set; }
    }
}
