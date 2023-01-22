namespace Hero.Server.Messages.Requests
{
    public class CharacterUpdateRequest
    {
        public string? Name { get; set; }
        public string? Description { get; set; }
        public string? IconUrl { get; set; }
        public int? Age { get; set; }
        public string? Inventory { get; set; }
        public string? Religion { get; set; }
        public string? Relationship { get; set; }
        public string? Notes { get; set; }
        public string? Profession { get; set; }

        public bool? IsPublic { get; set; }
        public bool? ShareSkilltree { get; set; }
        public bool? ShareNotes { get; set; }
        public bool? ShareInventory { get; set; }
        public bool? ShareAbilities { get; set; }
        public bool? ShareAttributes { get; set; }
    }
}
