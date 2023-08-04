using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IUserRepository
    {
        Task<UserEntity?> FindByIdAsync(string userId, CancellationToken cancellationToken = default);
        Task<IEnumerable<UserEntity>> ListAsync(CancellationToken cancellationToken = default);
        Task<UserEntity> CreateAsync(UserEntity user, CancellationToken cancellationToken = default);
        Task<UserEntity> UpdateAsync(UserEntity user, CancellationToken cancellationToken = default);
        Task DeleteAsync(UserEntity user, CancellationToken cancellationToken = default);
    }
}
