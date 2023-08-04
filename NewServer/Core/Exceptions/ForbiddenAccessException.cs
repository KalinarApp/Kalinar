namespace Kalinar.Core.Exceptions
{
    public class ForbiddenAccessException : Exception
    {
        private const String DefaultErrorMessage = "User does not have permission to access this action or resource";

        public ForbiddenAccessException(string? message = default) : base(message ?? DefaultErrorMessage) { }
    }
}
