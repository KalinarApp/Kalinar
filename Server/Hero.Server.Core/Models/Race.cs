using System;

namespace Hero.Server.Core.Models
{
    public class Race
    {
        public Guid Id  { get; set; }
        public Guid GroupId { get; set; }
        public string Name { get; set; }
        public string? Description { get; set; }

        public List<AttributeRace> Attributes { get; set; }

        public void Update(Race race)
        {
            this.Name = race.Name;
            this.Description= race.Description;
            this.Attributes = race.Attributes;
        }
    }
}
