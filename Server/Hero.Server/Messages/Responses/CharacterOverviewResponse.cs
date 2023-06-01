namespace Hero.Server.Messages.Responses
{
    public class CharacterOverviewResponse
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string? IconUrl { get; set; }
        public string UserId { get; set; }
    }

    public class ExtendedCharacterOverviewResponse : CharacterOverviewResponse
    {
        public List<SkilltreeOverviewResponse> Skilltrees { get; set; }
    }
}
