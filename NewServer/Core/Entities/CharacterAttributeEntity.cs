namespace Kalinar.Core.Entities
{
    public class CharacterAttributeEntity
    {
        public required Guid CharacterId { get; init; }
        public required Guid AttributeId { get; init; }
        public required AttributeEntity Attribute { get; init; }
        public required double Value { get; init; }
    }
}
