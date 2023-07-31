using Kalinar.Application.Messages.Requests;
using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IUserService
    {
        Task<IEnumerable<UserEntity>> ListAsync(CancellationToken cancellationToken = default);
        Task<UserEntity> GetByIdAsync(string userId, CancellationToken cancellationToken = default);
        Task<UserEntity> CreateAsync(string userId, RegisterUserRequest request, CancellationToken cancellationToken = default);
        Task<UserEntity> UpdateAsync(UserEntity user, CancellationToken cancellationToken = default);
        Task DeleteAsync(UserEntity user, CancellationToken cancellationToken = default);
        Task JoinGroupAsync(string userId, Guid groupId, RoleEntity role, CancellationToken cancellationToken = default);
        Task LeaveGroupAsync(string userId, Guid groupId, CancellationToken cancellationToken = default);
    }
}
