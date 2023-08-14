namespace Kalinar.Core.Exceptions
{
    public class SkilltreeEdgeAlreadyExistsException : Exception
    {
        public SkilltreeEdgeAlreadyExistsException(Guid startId, Guid endId)
            : base($"A edge betwteen node '{startId}' and node '{endId}' already exists")
        { }
    }
}
