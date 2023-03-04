using Attribute = Hero.Server.Core.Models.Attribute;

namespace Hero.Server.Core.Repositories
{
    public interface IAttributeRepository
    {
        Task<Attribute?> GetAttributeByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<List<Attribute>> GetAllAttributesAsync(CancellationToken cancellationToken = default);
        Task<List<Attribute>> GetAllGlobalAttributesAsync(CancellationToken cancellationToken = default);
        Task<List<string>> GetAllCategoriesAsync(string? query, CancellationToken cancellationToken = default);
        Task CreateIfNotExistsAsync(Attribute attribute, CancellationToken cancellationToken = default);
        Task CreateAttributeAsync(Attribute attribute, CancellationToken cancellationToken = default);
        Task TryDeleteAttributeAsync(Guid id, string userId, CancellationToken cancellationToken = default);
        Task TryUpdateAttributeAsync(Guid id, string userId, Attribute updatedAttribute, CancellationToken cancellationToken = default);
        Task ApproveAttribute(Guid id, CancellationToken cancellationToken = default);
        Task RejectAttribute(Guid id, string reason, CancellationToken cancellationToken = default);
    }
}
