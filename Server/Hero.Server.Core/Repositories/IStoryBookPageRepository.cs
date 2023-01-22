using Hero.Server.Core.Models.Storyline;

namespace Hero.Server.Core.Repositories
{
    public interface IStoryBookPageRepository
    {
        Task<List<StoryBookPage>>  GetAllAsync(Guid bookId, bool writtenOnly, CancellationToken cancellationToken = default);
        Task CreateAsync(Guid bookId, StoryBookPage page, CancellationToken cancellationToken = default);
        Task DeleteAsync(Guid bookId, Guid id, CancellationToken cancellationToken = default);
        Task UpdateAsync(Guid bookId, Guid id, StoryBookPage page, CancellationToken cancellationToken = default);
        Task UpdatePositionAsync(Guid bookId, Guid id, int newPosition, CancellationToken cancellationToken = default);
        Task UnlockAsync(Guid id, Guid pageId, bool state, CancellationToken cancellationToken);
    }
}
