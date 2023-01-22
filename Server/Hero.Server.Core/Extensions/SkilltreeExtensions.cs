using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Models;

namespace Hero.Server.Core.Extensions
{
    public static class SkilltreeExtensions
    {
        public static List<Skill> GetAllUnlockedSkills(this Skilltree tree)
        {
            return tree.Nodes.Where(node => node.IsUnlocked).Select(node => node.Skill).ToList();
        }

        public static bool IsNodeUnlockable(this Skilltree tree, Guid nodeId)
        {
            Node nodeToCheck = tree.Nodes.Single(node => nodeId == node.Id);

            bool isUnlockable = nodeToCheck.IsEasyReachable
                ? tree.Nodes.Where(node => nodeToCheck.Precessors.Contains(node.Id)).Any(node => node.IsUnlocked)
                : tree.Nodes.Where(node => nodeToCheck.Precessors.Contains(node.Id)).All(node => node.IsUnlocked);

            return 0 == nodeToCheck.Precessors.Count || isUnlockable;
        }


        public static List<SkilltreeNode> GetAllNodesToReset(this Skilltree tree, Guid nodeId, List<SkilltreeNode>? nodes = null)
        {
            SkilltreeNode nodeToCheck = tree.Nodes.Single(node => nodeId == node.Id);

            if (nodes?.Contains(nodeToCheck) ?? false)
            {
                return nodes;
            }

            if (!nodeToCheck.IsNodeResettable())
            {
                throw new NodeNotResettableException($"The node '{nodeId}' is not resettable.");
            }

            List<SkilltreeNode> nodesToReset = nodes ?? new();
            nodesToReset.Add(nodeToCheck);
            List<SkilltreeNode> successors = tree.Nodes.Where(node => nodeToCheck.Successors.Contains(node.Id) && node.IsUnlocked).ToList();

            if (successors.Any())
            {
                foreach (SkilltreeNode successor in successors)
                {
                    if (successor.Precessors.Count == 1)
                    {
                        nodesToReset.AddRange(tree.GetAllNodesToReset(successor.Id, nodesToReset));
                    }
                    else if (successor.Precessors.Count > 1)
                    {
                        if (!successor.IsEasyReachable)
                        {
                            nodesToReset.AddRange(tree.GetAllNodesToReset(successor.Id, nodesToReset));
                        }
                        else 
                        {
                            List<SkilltreeNode> otherUnlockedPressesors = tree.Nodes.Where(node => node.IsUnlocked && successor.Precessors.Where(id => id != nodeToCheck.Id).Contains(node.Id)).ToList();
                            if (otherUnlockedPressesors.All(node => nodesToReset.Contains(node)))
                            {
                                nodesToReset.AddRange(tree.GetAllNodesToReset(successor.Id, nodesToReset));
                            }
                        }
                    }
                }
            }

            return nodesToReset;
        }
    }
}
