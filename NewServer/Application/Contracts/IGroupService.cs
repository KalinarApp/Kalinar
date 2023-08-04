using Kalinar.Core.Entities;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Contracts
{
    public interface IGroupService
    {
        Task<IEnumerable<GroupEntity>> ListAsync(CancellationToken cancellationToken = default);
        Task<GroupEntity> GetByIdAsync(Guid groupId, bool includeMembers = false, CancellationToken cancellationToken = default);
        Task<GroupEntity> CreateAsync(GroupRequest request, CancellationToken cancellationToken = default);
        Task<GroupEntity> UpdateAsync(Guid id, GroupRequest request, CancellationToken cancellationToken = default);
        Task DeleteAsync(Guid id, CancellationToken cancellationToken = default);
    }
}
