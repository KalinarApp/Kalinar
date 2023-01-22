namespace Hero.Server.Messages.Responses
{
    public class CreateCharacterResponse
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string? Description { get; set; }
        public string? IconUrl { get; set; }
        public int? Age { get; set; }
        public string? Inventory { get; set; }
        public string? Religion { get; set; }
        public string? Relationship { get; set; }
        public string? Notes { get; set; }
        public string? Profession { get; set; }
    }
}
