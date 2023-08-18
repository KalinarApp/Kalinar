using Kalinar.Core.Entities;

namespace Kalinar.Core.Views
{
    public class CharacterAttributeView
    {
        public required Guid CharacterId { get; init; }
        public required Guid AttributeId { get; init; }
        public required AttributeEntity Attribute { get; init; }
        public required double Value { get; init; }
    }
}
