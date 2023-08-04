using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IAttributeRepository
    {
        Task<IEnumerable<AttributeEntity>> ListAsync(CancellationToken cancellationToken = default);
        Task<IEnumerable<AttributeEntity>> ListByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<IEnumerable<string>> ListCategoriesAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<AttributeEntity?> FindByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<AttributeEntity> CreateAsync(AttributeEntity attribute, CancellationToken cancellationToken = default);
        Task<AttributeEntity> UpdateAsync(AttributeEntity attribute, CancellationToken cancellationToken = default);
        Task DeleteAsync(AttributeEntity attribute, CancellationToken cancellationToken = default);
    }
}
