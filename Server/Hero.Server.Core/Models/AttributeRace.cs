namespace Hero.Server.Core.Models
{
    public class AttributeRace
    {
        public Guid AttributeId { get; set; }
        public Guid RaceId { get; set; }
        public Attribute Attribute { get; set; }
        public Race Race { get; set; }
        public double Value { get; set; }

    }
}
