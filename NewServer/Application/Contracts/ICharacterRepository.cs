using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface ICharacterRepository : IBaseRepository<CharacterEntity>
    {
        Task<IEnumerable<CharacterSkillEntity>> ListCharacterSkillsByIdAsync(Guid characterId, CancellationToken cancellationToken = default);
    }
}
