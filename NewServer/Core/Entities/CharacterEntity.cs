namespace Kalinar.Core.Entities
{
    public class CharacterEntity : BaseEntityWithGroup
    {
        public required Guid RaceId { get; init; }
        public required string UserId { get; init; }
        public required string Name { get; set; }
        public string? Description { get; set; }

        public string? IconUrl { get; set; }
        public int? Age { get; set; }
        public string? Inventory { get; set; }
        public string? Religion { get; set; }
        public string? Relationship { get; set; }
        public string? Notes { get; set; }
        public string? Profession { get; set; }

        public required RaceEntity Race { get; set; }
        public required IEnumerable<SkilltreeEntity> Skilltrees { get; init; }
    }
}
