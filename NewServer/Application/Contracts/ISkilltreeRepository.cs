using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface ISkilltreeRepository : IBaseRepository<SkilltreeEntity>
    {
        Task<IEnumerable<SkilltreeNodeEntity>> ListNodesAsync(Guid skilltreeId, CancellationToken cancellationToken = default);
        Task<IEnumerable<SkilltreeEdgeEntity>> ListEdgesAsync(Guid skilltreeId, CancellationToken cancellationToken = default);
        Task<SkilltreePointEntity?> FindPointsByIdAsync(Guid skilltreeId, CancellationToken cancellationToken = default);
        Task<SkilltreeNodeEntity?> FindNodeByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<SkilltreeEdgeEntity?> FindEdgeByStartAndEndIdAsync(Guid startId, Guid endId, CancellationToken cancellationToken = default);
        Task<SkilltreeNodeEntity> CreateNodeAsync(SkilltreeNodeEntity node, CancellationToken cancellationToken = default);
        Task<SkilltreeEdgeEntity> CreateEdgeAsync(SkilltreeEdgeEntity edge, CancellationToken cancellationToken = default);
        Task<SkilltreeNodeEntity> UpdateNodeAsync(SkilltreeNodeEntity node, CancellationToken cancellationToken = default);
        Task DeleteNodeAsync(SkilltreeNodeEntity node, CancellationToken cancellationToken = default);
        Task DeleteEdgeAsync(SkilltreeEdgeEntity edge, CancellationToken cancellationToken = default);
        Task<SkilltreeEntity> CopyByIdAsync(Guid skilltreeId, CancellationToken cancellationToken = default);
    }
}
