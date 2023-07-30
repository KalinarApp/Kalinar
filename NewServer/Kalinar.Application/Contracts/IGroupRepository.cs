
using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IGroupRepository
    {
        Task<GroupEntity?> FindByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<IEnumerable<GroupEntity>> ListAsync(CancellationToken cancellationToken = default);
        Task<GroupEntity> CreateAsync(GroupEntity group, CancellationToken cancellationToken = default);
        Task<GroupEntity> UpdateAsync(GroupEntity group, CancellationToken cancellationToken = default);
        Task DeleteAsync(GroupEntity group, CancellationToken cancellationToken = default);
    }
}
