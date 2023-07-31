using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IGroupService
    {
        Task<GroupEntity> GetByIdAsync(Guid groupId, bool includeMembers = false, CancellationToken cancellationToken = default);
        Task<IEnumerable<GroupEntity>> ListAsync(CancellationToken cancellationToken = default);
        Task CreateGroupAsync(GroupEntity group, CancellationToken cancellationToken = default);
        Task UpdateGroupAsync(GroupEntity group, CancellationToken cancellationToken = default);
        Task DeleteGroupAsync(GroupEntity group, CancellationToken cancellationToken = default);
    }
}
