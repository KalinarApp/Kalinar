namespace Kalinar.Messages.Requests
{
    public class SkillAttributeRequest
    {
        public required Guid AttributeId { get; init; }
        public required double Value { get; init; }
    }
}
