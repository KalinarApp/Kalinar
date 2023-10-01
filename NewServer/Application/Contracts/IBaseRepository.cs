using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IBaseRepository<T>
        where T : BaseEntityWithGroup
    {
        Task<IEnumerable<T>> ListAsync(CancellationToken cancellationToken = default);
        Task<IEnumerable<T>> ListByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<T?> FindByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<T> CreateAsync(T entity, CancellationToken cancellationToken = default);
        Task<T> UpdateAsync(T entity, CancellationToken cancellationToken = default);
        Task DeleteAsync(T entity, CancellationToken cancellationToken = default);
    }
}
