using Hero.Server.Core.Models;

namespace Hero.Server.Messages.Responses
{
    public class SkilltreeResponse
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public bool IsActiveTree { get; set; }
        public int Points { get; set; }
        public CharacterOverviewResponse Character { get; set; }
        public List<SkilltreeNodeResponse> Nodes { get; set; } = new();
    }
}
