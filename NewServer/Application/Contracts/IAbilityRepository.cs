using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IAbilityRepository : IBaseRepository<AbilityEntity>
    {
        Task<IEnumerable<string>> ListTagsAsync(Guid groupId, CancellationToken cancellationToken = default);
    }
}
