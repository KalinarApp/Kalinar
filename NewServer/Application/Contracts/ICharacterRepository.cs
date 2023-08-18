using Kalinar.Core.Entities;
using Kalinar.Core.Views;

namespace Kalinar.Application.Contracts
{
    public interface ICharacterRepository : IBaseRepository<CharacterEntity>
    {
        Task<IEnumerable<CharacterAttributeView>> ListCharacterAttributesByIdAsync(Guid characterId, CancellationToken cancellationToken = default);
        Task<IEnumerable<CharacterUnlockedSkillView>> ListUnlockedCharacterSkillsByIdAsync(Guid characterId, CancellationToken cancellationToken = default);
    }
}
