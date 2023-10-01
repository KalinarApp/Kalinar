namespace Kalinar.Core.Entities
{
    public class SkilltreeEdgeEntity
    {
        public required Guid SkilltreeId { get; init; }
        public required Guid StartId { get; init; }
        public required Guid EndId { get; init; }

        public required SkilltreeEntity Skilltree { get; set; }
        public required SkilltreeNodeEntity Start { get; set; }
        public required SkilltreeNodeEntity End { get; set; }
    }
}
