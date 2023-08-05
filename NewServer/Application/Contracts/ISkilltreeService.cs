﻿using Kalinar.Core.Entities;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Contracts
{
    public interface ISkilltreeService
    {
        Task<IEnumerable<SkilltreeEntity>> ListAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<IEnumerable<SkilltreeNodeEntity>> ListNodesAsync(Guid skilltreeId, CancellationToken cancellationToken = default);
        Task<IEnumerable<SkilltreeEdgeEntity>> ListEdgesAsync(Guid skilltreeId, CancellationToken cancellationToken = default);
        Task<SkilltreeEntity> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<SkilltreeNodeEntity> GetNodeByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<SkilltreeEdgeEntity> GetEdgeByStartAndEndIdAsync(Guid startId, Guid endId, CancellationToken cancellationToken = default);
        Task<SkilltreeEntity> CreateAsync(SkilltreeCreateRequest request, CancellationToken cancellationToken = default);
        Task<SkilltreeNodeEntity> CreateNodeAsync(SkilltreeNodeCreateRequest request, CancellationToken cancellation = default);
        Task<SkilltreeEdgeEntity> CreateEdgeAsync(SkilltreeEdgeRequest request, CancellationToken cancellationToken = default);
        Task<SkilltreeEntity> UpdateAsync(Guid id, SkilltreeUpdateRequest request, CancellationToken cancellationToken = default);
        Task<SkilltreeNodeEntity> UpdateNodeAsync(Guid id, SkilltreeNodeUpdateRequest request, CancellationToken cancellationToken = default);
        Task<SkilltreeNodeEntity> UnlockNodeAsync(Guid id, bool state, CancellationToken cancellationToken = default);
        Task ResetAsync(Guid id, CancellationToken cancellationToken = default);
        Task DeleteAsync(Guid id, CancellationToken cancellationToken = default);
        Task DeleteNodeAsync(Guid id, CancellationToken cancellationToken = default);
        Task DeleteEdgeAsync(SkilltreeEdgeRequest request, CancellationToken cancellationToken = default);
    }
}
