using Kalinar.Application.Messages.Requests;
using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IUserService
    {
        Task<IEnumerable<UserEntity>> ListAsync(CancellationToken cancellationToken = default);
        Task<UserEntity> GetByIdAsync(string userId, CancellationToken cancellationToken = default);
        Task<UserEntity> CreateAsync(string userId, RegisterUserRequest request, CancellationToken cancellationToken = default);
        Task<UserEntity> UpdateAsync(string userId, UserUpdateRequest request, CancellationToken cancellationToken = default);
        Task DeleteAsync(UserEntity user, CancellationToken cancellationToken = default);
        Task AddDeviceIdAsync(string userId, string deviceId, CancellationToken cancellationToken = default);
        Task RemoveDeviceIdAsync(string userId, string deviceId, CancellationToken cancellationToken = default);
    }
}
