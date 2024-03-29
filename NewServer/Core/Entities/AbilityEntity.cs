﻿namespace Kalinar.Core.Entities
{
    public class AbilityEntity : SuggestableEntity
    {
        public required string Name { get; set; }
        public required bool IsPassive { get; set; }
        public string? Description { get; set; }
        public required IEnumerable<AbilityTagEntity> Tags { get; set; }
    }
}
