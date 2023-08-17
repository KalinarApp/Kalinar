namespace Kalinar.Core.Entities
{
    public class SkilltreePointEntity
    {
        public required Guid SkilltreeId { get; init; }
        public required int Available { get; init; }
        public required int Spent { get; init; }
        public required int Remaining { get; init; }
    }
}
