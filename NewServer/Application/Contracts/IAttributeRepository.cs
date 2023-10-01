using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IAttributeRepository : IBaseRepository<AttributeEntity>
    {
        Task<IEnumerable<string>> ListCategoriesAsync(Guid groupId, CancellationToken cancellationToken = default);
    }
}
