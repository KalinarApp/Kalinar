using System.ComponentModel.DataAnnotations;

namespace Hero.Server.Messages.Requests
{
    public class BlueprintRequest
    {
        [Required]
        public string Name { get; set; }
        public List<BlueprintNodeRequest> Nodes { get; set; }
    }
}
