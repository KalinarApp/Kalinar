using Kalinar.Core.Entities;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Contracts
{
    public interface ICharacterService
    {
        Task<IEnumerable<CharacterEntity>> ListAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<IEnumerable<SkillEntity>> ListUnlockedSkillsByIdAsync(Guid characterId, CancellationToken cancellationToken = default);
        Task<IEnumerable<CharacterAttributeEntity>> ListAttributesByIdAsync(Guid characterId, CancellationToken cancellationToken = default);
        Task<CharacterEntity> GetByIdAsync(Guid characterId, CancellationToken cancellationToken = default);
        Task<CharacterEntity> CreateAsync(string userId, CharacterCreateRequest request, CancellationToken cancellationToken = default);
        Task<CharacterEntity> UpdateAsync(Guid id, CharacterUpdateRequest request, CancellationToken cancellationToken = default);
        Task DeleteAsync(Guid id, CancellationToken cancellationToken = default);
    }
}
