using AutoMapper;
using Hero.Server.Core.Models;

namespace Hero.Server.Messages.Responses
{
    public class SkillResponse
    {
        public Guid Id { get; set; }
        public Guid? AbilityId { get; set; }
        public string? IconUrl { get; set; }
        public string Name { get; set; }
        public string? Description { get; set; }
        public AbilityResponse? Ability { get; set; }
        public List<AttributeValueResponse> Attributes { get; set; } = new ();
        
    }
}