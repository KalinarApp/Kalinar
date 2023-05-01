namespace Hero.Server.Core.Models.Inventory
{
    public class CharacterItem
    {
        public Guid CharacterId { get; set; }
        public Guid ItemId { get; set; }
        public Character Character { get; set; }
        public Item Item { get; set; }
        public int Count { get; set; }
    }
}
