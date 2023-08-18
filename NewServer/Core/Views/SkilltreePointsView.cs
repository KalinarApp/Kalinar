namespace Kalinar.Core.Views
{
    public class SkilltreePointsView
    {
        public required Guid SkilltreeId { get; init; }
        public required int Available { get; init; }
        public required int Spent { get; init; }
        public required int Remaining { get; init; }
    }
}
