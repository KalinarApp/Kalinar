using Hero.Server.Core.Models;

namespace Hero.Server.Messages.Responses
{
    public class SkilltreeOverviewResponse
    {
        public Guid Id { get; set; }
        public CharacterOverviewResponse? Character { get; set; }
        public string Name { get; set; }
        public bool IsActiveTree { get; set; }
        public int Points { get; set; }
        public int LeftPoints { get; set; }
        public int NodeCount { get; set; }
        public int UnlockedNodeCount { get; set; }
    }
}
