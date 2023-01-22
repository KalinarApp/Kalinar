using Hero.Server.Core.Models;

namespace Hero.Server.Core.Extensions
{
    public static class NodeExtensions
    {
        public static bool IsNodeResettable(this SkilltreeNode node)
        {
            return null != node.UnlockedAt && node.UnlockedAt > DateTime.UtcNow.AddMinutes(-5);
        }
    }
}
