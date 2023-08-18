using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface ICharacterRepository : IBaseRepository<CharacterEntity>
    {
        Task<IEnumerable<CharacterAttributeEntity>> ListCharacterAttributesByIdAsync(Guid characterId, CancellationToken cancellationToken = default);
        Task<IEnumerable<CharacterSkillEntity>> ListCharacterSkillsByIdAsync(Guid characterId, CancellationToken cancellationToken = default);
    }
}
