namespace Hero.Server.Messages.Responses
{
    public class AttributeValueResponse
    {
        public Guid AttributeId { get; set; }
        public AttributeResponse Attribute { get; set; }
        public double Value { get; set; }
    }
}