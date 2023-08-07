using Kalinar.Core.Entities;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Contracts
{
    public interface IRaceService
    {
        Task<IEnumerable<RaceEntity>> ListAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<IEnumerable<RaceAttributeEntity>> ListAttributesAsync(Guid skillId, CancellationToken cancellationToken = default);
        Task<RaceEntity> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<RaceEntity> CreateAsync(string userId, RaceCreateRequest request, CancellationToken cancellationToken = default);
        Task<RaceEntity> UpdateAsync(string userId, Guid id, RaceUpdateRequest request, CancellationToken cancellationToken = default);
        Task<RaceEntity> SetAttributesAsync(Guid raceId, List<RaceAttributeRequest> request, CancellationToken cancellationToken = default);
        Task<RaceEntity> ApproveAsync(Guid id, CancellationToken cancellationToken = default);
        Task<RaceEntity> RejectAsync(Guid id, RejectRequest request, CancellationToken cancellationToken = default);
        Task DeleteAsync(Guid id, CancellationToken cancellationToken = default);
    }
}
