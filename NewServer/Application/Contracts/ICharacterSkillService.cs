using Kalinar.Core.Entities;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Contracts
{
    public interface ICharacterSkillService
    {
        Task<IEnumerable<CharacterSkillEntity>> ListAsync(Guid characterId, CancellationToken cancellationToken = default);
        Task<CharacterSkillEntity> AddOrUpdateAsync(Guid characterId, Guid skillId, CharacterSkillRequest request, CancellationToken cancellationToken = default);
    }
}