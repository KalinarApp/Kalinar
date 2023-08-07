using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class AttributeValueResponse
    {
        public required Guid AttributeId { get; init; }
        public required AttributeResponse Attribute { get; init; }
        public double Value { get; set; }

        public static implicit operator AttributeValueResponse(SkillAttributeEntity attribute)
        {
            return new()
            {
                AttributeId = attribute.AttributeId,
                Attribute = attribute.Attribute,
                Value = attribute.Value
            };
        }

        public static implicit operator AttributeValueResponse(RaceAttributeEntity attribute)
        {
            return new()
            {
                AttributeId = attribute.AttributeId,
                Attribute = attribute.Attribute,
                Value = attribute.Value
            };
        }
    }
}
