using Hero.Server.Core.Models;

namespace Hero.Server.Core.Repositories
{
    public interface ISkilltreeRepository
    {
        Task CreateSkilltreeAsync(Skilltree skilltree, CancellationToken cancellationToken = default);
        Task UpdateSkilltreeAsync(Guid id, Skilltree updatedSkilltree, CancellationToken cancellationToken = default);
        Task DeleteSkilltreeAsync(Guid id, CancellationToken cancellationToken = default);
        Task<Skilltree?> GetSkilltreeByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<List<Skilltree>> FilterSkilltrees(Guid? characterId, CancellationToken cancellationToken = default);
        Task UnlockNode(Guid skilltreeId, Guid nodeId, CancellationToken token = default);
        Task<int> GetSkillpoints(Guid skilltreeId, CancellationToken token = default);
        Task ResetSkilltreeAsync(Guid skilltreeId, CancellationToken cancellationToken = default);
        Task ResetNode(Guid skilltreeId, Guid nodeId, CancellationToken token = default);
        Task EnsureIsOwner(Guid id, string userId, CancellationToken cancellationToken = default);
        Task SwitchSkilltreeActiveStateAsync(Guid id, bool state, CancellationToken cancellationToken = default);
    }
}