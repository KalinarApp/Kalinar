namespace Kalinar.Core.Entities
{
    public class RaceEntity : SuggestableEntity
    {
        public required string Name { get; set; }
        public string? Description { get; set; }
        public required IEnumerable<RaceAttributeEntity> Attributes { get; set; }
    }
}
