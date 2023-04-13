namespace Hero.Server.Core.Models.Inventory
{
    public class Item
    {
        public Guid Id { get; set; }
        public Guid GroupId { get; set; }
        public string CreatorId { get; set; }
        public string Title { get; set; }
        public string? Description { get; set; }
        public string? ImageUrl { get; set; }
        public bool IsLocked { get; set; }
        public bool IsSingle { get; set; }
        public Group Group { get; set; }
        public User Creator { get; set; }
        public List<CharacterItem> Characters { get; set; }

        public DateTimeOffset CreatedAt { get; set; }
        public DateTimeOffset UpdatedAt{ get; set; }
    }

    public class Weapon : Item
    {
        public int Dice { get; set; }
        public int DiceCount { get; set; }
        public int Bonus { get; set; } = 0;
    }
}