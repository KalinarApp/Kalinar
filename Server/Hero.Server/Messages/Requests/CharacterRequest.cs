using Hero.Server.Messages.Responses;
using System.ComponentModel.DataAnnotations;

namespace Hero.Server.Messages.Requests
{
    public class CharacterRequest
    {
        [Required]
        public string Name { get; set; }
        public string? Description { get; set; }
        public string? IconUrl { get; set; }
        public int? Age { get; set; }
        public string? Inventory { get; set; }
        public string? Religion { get; set; }
        public string? Relationship { get; set; }
        public string? Notes { get; set; }
        public string? Profession { get; set; }
        public Guid RaceId { get; set; }
    }
}
