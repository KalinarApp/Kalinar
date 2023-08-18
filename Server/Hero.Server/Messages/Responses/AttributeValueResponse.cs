using Hero.Server.Core.Models;

namespace Hero.Server.Messages.Responses
{
    public class AttributeValueResponse
    {
        public required Guid AttributeId { get; set; }
        public required AttributeResponse Attribute { get; set; }
        public double Value { get; set; }

        public static implicit operator AttributeValueResponse(AttributeSkill attribute)
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