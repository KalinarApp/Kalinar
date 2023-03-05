namespace Hero.Server.Messages.Responses
{
    public class UserResponse
    {
        public string Id { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }

        public GroupResponse? Group { get; set; }
    }
}
