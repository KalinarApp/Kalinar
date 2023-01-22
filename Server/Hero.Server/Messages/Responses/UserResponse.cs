namespace Hero.Server.Messages.Responses
{
    public class UserResponse
    {
        public Guid Id { get; set; }
        public GroupResponse? Group { get; set; }
    }
}
