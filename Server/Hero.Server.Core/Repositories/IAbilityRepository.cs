using Hero.Server.Core.Models;

namespace Hero.Server.Core.Repositories
{
    public interface IAbilityRepository
    {
        Task<Ability> GetAbilityByNameAsync(string name, CancellationToken cancellationToken = default);
        Task<List<Ability>> GetAllAbilitiesAsync( CancellationToken cancellationToken = default);
        Task CreateAbilityAsync(Ability ability, CancellationToken cancellationToken = default);
        Task UpdateAbilityAsync(Guid id, Ability updatedAbility, CancellationToken cancellationToken = default);
        Task DeleteAbilityAsync(Guid id, CancellationToken cancellationToken = default);
    }
}
