namespace Kalinar.Core.Exceptions
{
    public class SkilltreeNodeNotResetableException : Exception
    {
        public SkilltreeNodeNotResetableException(Guid nodeId)
            : base($"Node with the id '{nodeId}' is not resetable")
        { }
    }
}
