using Kalinar.Core.Entities;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Contracts
{
    public interface ISkillService
    {
        Task<IEnumerable<SkillEntity>> ListAsync(Guid groupId, bool? approved = default, CancellationToken cancellationToken = default);
        Task<IEnumerable<SkillAttributeEntity>> ListAttributesAsync(Guid skillId, CancellationToken cancellationToken = default);
        Task<SkillEntity> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<SkillEntity> CreateAsync(string userId, SkillCreateRequest request, CancellationToken cancellationToken = default);
        Task<SkillEntity> UpdateAsync(Guid id, SkillUpdateRequest request, CancellationToken cancellationToken = default);
        Task<SkillEntity> ApproveAsync(Guid id, CancellationToken cancellationToken = default);
        Task<SkillEntity> RejectAsync(Guid id, RejectRequest request, CancellationToken cancellationToken = default);
        Task DeleteAsync(Guid id, CancellationToken cancellationToken = default);
        Task SetAttributesAsync(Guid id, IEnumerable<SkillAttributeRequest> request, CancellationToken cancellationToken = default);
    }
}
