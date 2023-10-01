namespace Kalinar.Core.Exceptions
{
    public class SkilltreeNodeNotUnlockableException : Exception
    {
        public SkilltreeNodeNotUnlockableException(Guid nodeId)
            : base($"The node with id '{nodeId}' is not unlockable")
        { }
    }
}
