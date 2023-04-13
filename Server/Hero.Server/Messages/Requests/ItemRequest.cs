namespace Hero.Server.Messages.Requests
{
    public class ItemRequest
    {
        public string Type { get; set; }
        public string Title { get; set; }
        public string? Description { get; set; }
        public string? ImageUrl { get; set; }
        public bool IsLocked { get; set; }
        public bool IsSingle { get; set; }
        public Guid? CharacterId { get; set; }
        public int? Dice { get; set; }
        public int? DiceCount { get; set; }
        public int? Bonus { get; set; }
    }
}
