using Hero.Server.Core.Models;

namespace Hero.Server.Core.Repositories
{
    public interface IAbilityRepository
    {
        Task<Ability> GetAbilityByNameAsync(string name, CancellationToken cancellationToken = default);
        Task<List<Ability>> GetAllAbilitiesAsync( CancellationToken cancellationToken = default);
        Task CreateAbilityAsync(Ability ability, CancellationToken cancellationToken = default);
        Task<Ability?> GetAbilityByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task TryUpdateAbilityAsync(Guid id, string userId, Ability updated, CancellationToken cancellationToken = default);
        Task TryDeleteAbilityAsync(Guid id, string userId, CancellationToken cancellationToken = default);
    }
}
