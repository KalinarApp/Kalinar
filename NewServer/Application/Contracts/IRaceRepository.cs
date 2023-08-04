using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IRaceRepository
    {
        Task<IEnumerable<RaceEntity>> ListAsync(CancellationToken cancellationToken = default);
        Task<IEnumerable<RaceEntity>> ListByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<IEnumerable<RaceAttributeEntity>> ListAttributesAsync(Guid raceId, CancellationToken cancellationToken = default);
        Task<RaceEntity?> FindByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<RaceEntity> CreateAsync(RaceEntity race, CancellationToken cancellationToken = default);
        Task<RaceEntity> UpdateAsync(RaceEntity race, CancellationToken cancellationToken = default);
        Task DeleteAsync(RaceEntity race, CancellationToken cancellationToken = default);
    }
}
