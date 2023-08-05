namespace Kalinar.Core.Exceptions
{
    public class SkilltreeEdgeNotFoundException : Exception
    {
        public Guid StartId { get; }
        public Guid EndId { get; }

        public SkilltreeEdgeNotFoundException(Guid startId, Guid endId)
            : base($"A skilltree edge between node '{startId}' and '{endId}' does not exist")
        {
            this.StartId = startId;
            this.EndId = endId;
        }
    }
}
