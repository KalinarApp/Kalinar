using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface ICharacterSkillsRepository
    {
        Task<IEnumerable<CharacterSkillEntity>> ListByIdAsync(Guid characterId, CancellationToken cancellationToken = default);
        Task<CharacterSkillEntity?> FindByCharacterAndSkillIdAsync(Guid characterId, Guid skillId, CancellationToken cancellationToken);
        Task<CharacterSkillEntity> CreateAsync(CharacterSkillEntity characterSkill, CancellationToken cancellationToken = default);
        Task<CharacterSkillEntity> UpdateAsync(CharacterSkillEntity characterSkill, CancellationToken cancellationToken = default);
        Task DeleteAsync(CharacterSkillEntity characterSkill, CancellationToken cancellationToken = default);
    }
}
