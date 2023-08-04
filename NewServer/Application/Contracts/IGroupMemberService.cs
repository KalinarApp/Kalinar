using Kalinar.Core.Entities;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Contracts
{
    internal interface IGroupMemberService
    {
        Task<IEnumerable<GroupMemberEntity>> ListByUserIdAsync(string userId, CancellationToken cancellationToken = default);
        Task<GroupMemberEntity> GetByUserAndGroupIdAsync(string userId, Guid groupId, CancellationToken cancellationToken = default);
        Task<GroupMemberEntity> CreateAsync(string userId, Guid groupId, Role role, CancellationToken cancellationToken = default);
        Task<GroupMemberEntity> UpdateAsync(string userId, Guid groupId, GroupMemberUpdateRequest request, CancellationToken cancellationToken = default);
        Task DeleteAsync(string userId, Guid groupId, CancellationToken cancellationToken = default);
    }
}