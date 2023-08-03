namespace Kalinar.Core.Entities
{
    public class RaceEntity : SuggestableEntity
    {
        public required string Name { get; set; }
        public string? Description { get; set; }
        public required List<RaceAttributeEntity> Attributes { get; init; }
    }
}
