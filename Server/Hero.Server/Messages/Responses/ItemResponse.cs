namespace Hero.Server.Messages.Responses
{
    public class ItemResponse
    {
        public string Type { get; set; } = "Item";
        public Guid Id { get; set; }
        public string Title { get; set; }
        public string? Description { get; set; }
        public string? ImageUrl { get; set; }
        public bool IsLocked { get; set; }
        public bool IsSingle { get; set; }
    }

    public class WeaponResponse : ItemResponse
    {
        public new string Type { get; set; } = "Weapon";
        public int Dice { get; set; }
        public int DiceCount { get; set; }
        public int Bonus { get; set; }
    }
}
