namespace Kalinar.Application.Messages.Requests
{
    public class RegisterUserRequest
    {
        public required string Email { get; init; }
        public required string Username { get; init; }
    }
}
