using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface ISkillRepository : IBaseRepository<SkillEntity>
    {
        Task<IEnumerable<SkillAttributeEntity>> ListAttributesAsync(Guid skillId, CancellationToken cancellationToken = default);
    }
}
