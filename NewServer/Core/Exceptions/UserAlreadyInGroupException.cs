namespace Kalinar.Core.Exceptions
{
    public class UserAlreadyInGroupException : Exception
    {
        public UserAlreadyInGroupException(string userId, Guid groupId)
            : base($"User '{userId}' is already in group '{groupId}'")
        { }
    }
}
