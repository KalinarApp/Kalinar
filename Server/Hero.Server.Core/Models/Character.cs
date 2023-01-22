namespace Hero.Server.Core.Models
{
    public class Character
    {
        public Guid Id { get; set; }
        public string UserId { get; set; }
        public Guid GroupId { get; set; }
        public string? IconUrl { get; set; }
        public int? Age { get; set; }
        public string? Inventory { get; set; }
        public string? Religion { get; set; }
        public string? Relationship { get; set; }
        public string? Notes { get; set; }
        public string? Profession { get; set; }
        public List<Skilltree> Skilltrees { get; set; }
        public string Name { get; set; }
        public string? Description { get; set; }
        public Race Race { get; set; }
        public Guid? RaceId { get; set; }

        public bool IsPublic { get; set; }
        public bool? ShareSkilltree { get; set; }
        public bool? ShareNotes { get; set; }
        public bool? ShareInventory { get; set; }
        public bool? ShareAbilities { get; set; }
        public bool? ShareAttributes { get; set; }

        public void Update(Character character)
        {
            this.Name = character.Name;
            this.Description = character.Description;
            this.Skilltrees = character.Skilltrees;
            this.RaceId = character.RaceId;
            this.Age = character.Age;
            this.Inventory = character.Inventory;
            this.Religion = character.Religion;
            this.Relationship = character.Relationship;
            this.Notes = character.Notes;
            this.Profession = character.Profession;
            this.IconUrl = character.IconUrl;
        }
    }
}
