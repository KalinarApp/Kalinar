namespace Kalinar.Core.Entities
{
    public class AbilityTagEntity
    {
        public required string Tag { get; init; }
        public required Guid AbilityId { get; init; }
    }
}
