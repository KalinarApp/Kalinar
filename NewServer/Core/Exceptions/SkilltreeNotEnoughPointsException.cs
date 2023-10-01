namespace Kalinar.Core.Exceptions
{
    public class SkilltreeNotEnoughPointsException : Exception
    {
        public SkilltreeNotEnoughPointsException(Guid id, Guid nodeId)
            : base($"Skilltree with id {id} does not have enough points to unlock node with id {nodeId}")
        { }
    }
}
