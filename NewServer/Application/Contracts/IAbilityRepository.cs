using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IAbilityRepository
    {
        Task<IEnumerable<AbilityEntity>> ListAsync(CancellationToken cancellationToken = default);
        Task<IEnumerable<AbilityEntity>> ListByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<IEnumerable<string>> ListTagsAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<AbilityEntity?> FindByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<AbilityEntity> CreateAsync(AbilityEntity ability, CancellationToken cancellationToken = default);
        Task<AbilityEntity> UpdateAsync(AbilityEntity ability, CancellationToken cancellationToken = default);
        Task DeleteAsync(AbilityEntity ability, CancellationToken cancellationToken = default);
    }
}
