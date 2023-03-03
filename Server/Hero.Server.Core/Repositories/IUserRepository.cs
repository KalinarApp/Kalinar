using Hero.Server.Core.Models;

namespace Hero.Server.Core.Repositories
{
    public interface IUserRepository
    {
        Task<bool> IsOwner(string userId, CancellationToken cancellationToken = default);
        Task<User?> GetUserByIdAsync(string id, CancellationToken cancellationToken = default);
        Task<List<User>> GetUsersByIdAsync(List<string> ids, CancellationToken cancellationToken = default);
        Task<User> UpdateUserAsync(string id, string email, string username, CancellationToken cancellationToken = default);
    }
}
