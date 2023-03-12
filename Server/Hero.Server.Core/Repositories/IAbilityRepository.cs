using Hero.Server.Core.Models;

namespace Hero.Server.Core.Repositories
{
    public interface IAbilityRepository
    {
        Task<Ability?> GetAbilityByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<List<Ability>> FilterAbilitiesAsync(string? query, SuggestionState[] allowedStates, CancellationToken cancellationToken = default);
        Task CreateAbilityAsync(Ability ability, CancellationToken cancellationToken = default);
        Task<Ability> TryUpdateAbilityAsync(Guid id, string userId, Ability updated, CancellationToken cancellationToken = default);
        Task TryDeleteAbilityAsync(Guid id, string userId, CancellationToken cancellationToken = default);
        Task RejectAbility(Guid id, string reason, CancellationToken cancellationToken = default);
        Task<List<string>> GetAllTagsAsync(CancellationToken cancellationToken = default);
        Task UpdateAbilityTagsAsync(Guid id, List<string> tags, CancellationToken cancellationToken = default);
    }
}
