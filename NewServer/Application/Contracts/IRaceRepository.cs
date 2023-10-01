using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IRaceRepository : IBaseRepository<RaceEntity>
    {
        Task<IEnumerable<RaceAttributeEntity>> ListAttributesAsync(Guid raceId, CancellationToken cancellationToken = default);
        Task SetAttributesAsync(RaceEntity race, IEnumerable<RaceAttributeEntity> attributes, CancellationToken cancellationToken = default);
    } 
}
