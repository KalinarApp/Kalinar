using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface ISkillRepository
    {
        Task<IEnumerable<SkillEntity>> ListAsync(CancellationToken cancellationToken = default);
        Task<IEnumerable<SkillEntity>> ListByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<IEnumerable<SkillAttributeEntity>> ListAttributesAsync(Guid skillId, CancellationToken cancellationToken = default);
        Task<SkillEntity?> FindByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<SkillEntity> CreateAsync(SkillEntity skill, CancellationToken cancellationToken = default);
        Task<SkillEntity> UpdateAsync(SkillEntity skill, CancellationToken cancellationToken = default);
        Task DeleteAsync(SkillEntity skill, CancellationToken cancellationToken = default);
    }
}
