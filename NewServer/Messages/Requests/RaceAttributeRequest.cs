namespace Kalinar.Messages.Requests
{
    public class RaceAttributeRequest
    {
        public required Guid AttributeId { get; init; }
        public required double Value { get; init; }
    }
}
