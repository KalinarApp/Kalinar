using Hero.Server.Core.Models;

namespace Hero.Server.Core.Repositories
{
    public interface IBlueprintRepository
    {
        Task CreateBlueprintAsync(Blueprint blueprint, CancellationToken cancellationToken = default);
        Task UpdateBlueprintAsync(Guid id, Blueprint updatedBlueprint, CancellationToken cancellationToken = default);
        Task DeleteBlueprintAsync(Guid id, CancellationToken cancellationToken = default);
        Task<List<Blueprint>> GetAllBlueprintsAsync(CancellationToken cancellationToken = default);
        Task<Blueprint?> GetBlueprintByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<Blueprint?> LoadBlueprintByIdAsync(Guid id, CancellationToken cancellationToken = default);
    }
}
