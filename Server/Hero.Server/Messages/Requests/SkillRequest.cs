using Hero.Server.Core.Models;
using System.ComponentModel.DataAnnotations;

namespace Hero.Server.Messages.Requests
{
    public class SkillRequest
    {
        public string? IconUrl { get; set; }
        [Required]
        public string Name { get; set; }
        public string? Description { get; set; }
        public Guid? AbilityId { get; set; }

        public List<AttributeSkillValueRequest> Attributes { get; set; }
    }
}
