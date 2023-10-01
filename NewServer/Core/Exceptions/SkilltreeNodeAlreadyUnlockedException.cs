namespace Kalinar.Core.Exceptions
{
    public class SkilltreeNodeAlreadyUnlockedException : Exception
    {
        public SkilltreeNodeAlreadyUnlockedException(Guid nodeId)
            : base($"The node with the ide '{nodeId}' is already unlocked")
        { }
    }
}
