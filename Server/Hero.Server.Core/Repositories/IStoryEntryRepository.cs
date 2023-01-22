using Hero.Server.Core.Models.Storyline;

namespace Hero.Server.Core.Repositories
{
    public interface IStoryEntryRepository
    {
        Task CreateAsync(StoryEntry entry, CancellationToken cancellationToken = default);
        Task DeleteAsync(Guid id, CancellationToken cancellationToken = default);
        Task<List<StoryEntry>> GetAllAsync(bool unlockedOnly = false, CancellationToken cancellationToken = default);
        Task<StoryEntry?> GetByIdAsync(Guid id, bool unlockedOnly = false, CancellationToken cancellationToken = default);
        Task UnlockAsync(Guid id, bool isUnlocked, CancellationToken cancellationToken = default);
        Task UpdateAsync(Guid id, StoryEntry entry, CancellationToken cancellationToken = default);
        Task UpdatePositionAsync(Guid id, int newPosition, CancellationToken cancellationToken = default);
    }
}
