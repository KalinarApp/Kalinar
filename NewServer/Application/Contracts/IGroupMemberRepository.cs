using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IGroupMemberRepository
    {
        Task<IEnumerable<GroupMemberEntity>> ListByUserIdAsync(string userId, CancellationToken cancellationToken = default);
        Task<GroupMemberEntity?> FindByUserAndGroupIdAsync(string userId, Guid groupId, CancellationToken cancellationToken = default);
        Task<GroupMemberEntity> CreateAsync(GroupMemberEntity member, CancellationToken cancellationToken = default);
        Task<GroupMemberEntity> UpdateAsync(GroupMemberEntity member, CancellationToken cancellationToken = default);
        Task DeleteAsync(GroupMemberEntity member, CancellationToken cancellationToken = default);
    }
}
