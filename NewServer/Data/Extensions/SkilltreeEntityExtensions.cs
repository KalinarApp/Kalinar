using Kalinar.Core.Entities;

namespace Kalinar.Data.Extensions
{
    public static class SkilltreeEntityExtensions
    {
        public static SkilltreeEntity Copy(this SkilltreeEntity skilltree)
        {
            Dictionary<Guid, SkilltreeNodeEntity> newNodes = new();

            SkilltreeEntity newSkilltree = new()
            {
                Id = skilltree.Id,
                CharacterId = null,
                Character = null,
                GroupId = skilltree.GroupId,
                Group = skilltree.Group,
                CreatedAt = DateTimeOffset.UtcNow,
                IsActive = skilltree.IsActive,
                Name = skilltree.Name,
                Points = skilltree.Points,
                Edges = new(),
                Nodes = new(),
            };

            foreach (SkilltreeNodeEntity node in skilltree.Nodes)
            {
                SkilltreeNodeEntity newNode = new()
                {
                    Id = node.Id,
                    Color = node.Color,
                    Cost = node.Cost,
                    Importance = node.Importance,
                    IsEasyReachable = node.IsEasyReachable,
                    IsUnlocked = node.IsUnlocked,
                    Skill = node.Skill,
                    SkillId = node.SkillId,
                    Skilltree = newSkilltree,
                    SkilltreeId = newSkilltree.Id,
                    XPos = node.XPos,
                    YPos = node.YPos,
                };

                newSkilltree.Nodes.Add(newNode);
                newNodes.Add(node.Id, newNode);
            }

            foreach (SkilltreeEdgeEntity edge in skilltree.Edges)
            {
                SkilltreeNodeEntity newStart = newNodes[edge.StartId];
                SkilltreeNodeEntity newEnd = newNodes[edge.EndId];

                SkilltreeEdgeEntity newEdge = new()
                {
                    StartId = newStart.Id,
                    Start = newStart,
                    EndId = newEnd.Id,
                    End = newEnd,
                    SkilltreeId = newSkilltree.Id,
                    Skilltree = newSkilltree,
                };

                newSkilltree.Edges.Add(newEdge);
            }

            return newSkilltree;
        }
    }
}
