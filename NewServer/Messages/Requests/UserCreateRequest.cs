namespace Kalinar.Messages.Requests
{
    public class UserCreateRequest
    {
        public required string Username { get; init; }
        public string? ImageUrl { get; init; }
    }
}
