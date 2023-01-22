namespace Hero.Server.Messages.Responses
{
    public class CharacterOverviewResponse
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string? IconUrl { get; set; }
        public string UserId { get; set; }
    }
}
