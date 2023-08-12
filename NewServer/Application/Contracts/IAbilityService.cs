using Kalinar.Core.Entities;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Contracts
{
    public interface IAbilityService
    {
        Task<IEnumerable<AbilityEntity>> ListAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<IEnumerable<AbilityTagEntity>> ListTagsAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<AbilityEntity> GetByIdAsync(Guid abilityId, CancellationToken cancellationToken = default);
        Task<AbilityEntity> CreateAsync(string userId, AbilityCreateRequest request, CancellationToken cancellationToken = default);
        Task<AbilityEntity> UpdateAsync(Guid id, AbilityUpdateRequest request, CancellationToken cancellationToken = default);
        Task<AbilityEntity> ApproveAsync(Guid id, CancellationToken cancellationToken = default);
        Task<AbilityEntity> RejectAsync(Guid id, RejectRequest request, CancellationToken cancellationToken = default);
        Task DeleteAsync(Guid id, CancellationToken cancellationToken = default);
        Task<IEnumerable<AbilityTagEntity>> ListTagsByAbilityIdAsync(Guid abilityId, CancellationToken cancellationToken = default);
        Task SetTagsAsync(Guid id, IEnumerable<string> tags, CancellationToken cancellationToken = default);
    }
}
