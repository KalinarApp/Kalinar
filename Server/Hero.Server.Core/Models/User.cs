namespace Hero.Server.Core.Models
{
    public class User
    {
        public string Id { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
        public List<string>? DeviceIds { get; set; } = new();

        public Guid? GroupId { get; set; }

        public List<Character> Characters { get; set; }
        public Group? OwnedGroup { get; set; }
        public Group? Group { get; set; }
    }
}
