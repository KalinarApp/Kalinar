﻿namespace Hero.Server.Core.Models
{
    public class Skill : Suggestable
    {
        public Guid? AbilityId { get; set; }
        public string? IconUrl { get; set; }
        public string Name { get; set; }
        public string? Description { get; set; }
        public List<AttributeSkill> Attributes { get; set; }
        public Ability? Ability { get; set; }

        public void Update(Skill skill)
        {
            this.AbilityId = skill.AbilityId;
            this.IconUrl= skill.IconUrl;
            this.Name= skill.Name;
            this.Description= skill.Description;   
        }
    }
}
