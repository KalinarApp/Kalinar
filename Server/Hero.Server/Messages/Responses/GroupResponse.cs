namespace Hero.Server.Messages.Responses
{
    public class GroupResponse
    {
        public Guid Id { get; set; }
        public string OwnerId { get; set; }
        public string Name { get; set; }
        public string? Description { get; set; }
    }
}