using System.ComponentModel.DataAnnotations;

namespace Hero.Server.Messages.Requests
{
    public class AbilityRequest
    {
        [Required]
        public string Name { get; set; }

        public string? Description { get; set; }

        [Required]
        public bool IsPassive { get; set; }

    }
}
