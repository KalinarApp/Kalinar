using Kalinar.Core.Entities;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Contracts
{
    public interface IUserService
    {
        Task<IEnumerable<UserEntity>> ListAsync(CancellationToken cancellationToken = default);
        Task<IEnumerable<UserEntity>> ListByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<UserEntity> GetByIdAsync(string userId, CancellationToken cancellationToken = default);
        Task<UserEntity> CreateAsync(string userId, UserCreateRequest request, CancellationToken cancellationToken = default);
        Task<UserEntity> UpdateAsync(string userId, UserUpdateRequest request, CancellationToken cancellationToken = default);
        Task DeleteAsync(string id, CancellationToken cancellationToken = default);
        Task AddDeviceIdAsync(string userId, string deviceId, CancellationToken cancellationToken = default);
        Task RemoveDeviceIdAsync(string userId, string deviceId, CancellationToken cancellationToken = default);
    }
}
