namespace Kalinar.Core.Entities
{
    public class RaceAttributeEntity
    {
        public required Guid RaceId { get; init; }
        public required Guid AttributeId { get; init; }
        public required RaceEntity Race { get; init; }
        public required AttributeEntity Attribute { get; init; }
        public double Value { get; set; }
    }
}
