namespace Hero.Server.Messages.Responses
{
    public class UserResponse
    {
        public Guid Id { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }

        public GroupResponse? Group { get; set; }
    }
}
