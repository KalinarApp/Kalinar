using Kalinar.Core.Entities;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Contracts
{
    public interface IAttributeService
    {
        Task<IEnumerable<AttributeEntity>> ListAsync(Guid groupId, bool? approved = default, CancellationToken cancellationToken = default);
        Task<IEnumerable<string>> ListCategoriesAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<AttributeEntity> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<AttributeEntity> CreateAsync(string userId, AttributeCreateRequest request, CancellationToken cancellationToken = default);
        Task<IEnumerable<AttributeEntity>> CreateDefaultAttributesAsync(string userId, Guid groupId, CancellationToken cancellationToken = default);
        Task<AttributeEntity> UpdateAsync(Guid id, AttributeUpdateRequest request, CancellationToken cancellationToken = default);
        Task<AttributeEntity> ApproveAsync(Guid id, CancellationToken cancellationToken = default);
        Task<AttributeEntity> RejectAsync(Guid id, RejectRequest request, CancellationToken cancellationToken = default);
        Task DeleteAsync(Guid id, CancellationToken cancellationToken = default);
    }
}
