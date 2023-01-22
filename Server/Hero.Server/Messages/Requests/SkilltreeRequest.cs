using System.ComponentModel.DataAnnotations;

namespace Hero.Server.Messages.Requests
{
    public class SkilltreeRequest
    {
        public Guid? CharacterId { get; set; }
        [Required]
        public string Name { get; set; }
        public int Points { get; set; }
        public bool IsActiveTree { get; set; }
        public List<SkilltreeNodeRequest> Nodes { get; set; }
    }
}
