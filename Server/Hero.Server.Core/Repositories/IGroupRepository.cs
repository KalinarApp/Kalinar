using Hero.Server.Core.Models;

namespace Hero.Server.Core.Repositories
{
    public interface IGroupRepository
    {
        Task<string> CreateGroup(string groupName, string? groupDescription, string ownerId, CancellationToken cancellationToken = default);
        Task JoinGroup(Guid groupId, string userId, string invitationCode, CancellationToken cancellationToken = default);
        Task LeaveGroup(string userId, CancellationToken cancellationToken = default);
        Task DeleteGroup(Guid groupId, string userId, CancellationToken cancellationToken = default);
        Task<Group> GetGroupByOwnerId(string userId, CancellationToken cancellationToken = default);
        //Task<List<UserInfo>> GetAllUsersInGroupAsync(string userId, CancellationToken cancellationToken = default);
        Task<Group?> GetGroupByUserId(string userId, CancellationToken cancellationToken = default);
        Task<Group> GetGroupByInviteCode(string invitationCode, CancellationToken cancellationToken = default);
        //Task<UserInfo> GetGroupOwner(Group group, CancellationToken cancellationToken = default);
        void EnsureIsMemberOrOwner(string userId);
        void EnsureIsOwner(string userId);
    }
}
