using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IStoryBookRepository : IBaseRepository<StoryBookEntity>
    {
        Task<IEnumerable<StoryBookEntity>> ListUnlockedByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<IEnumerable<StoryBookPageEntity>> ListPagesAsync(Guid bookId, CancellationToken cancellationToken = default);
        Task<StoryBookPageEntity?> FindPageAsync(Guid id, CancellationToken cancellationToken = default);
        Task<StoryBookPageEntity> CreatePageAsync(StoryBookPageEntity entity, CancellationToken cancellationToken = default);
        Task<StoryBookPageEntity> UpdatePageAsync(StoryBookPageEntity entity, CancellationToken cancellationToken = default);
        Task DeletePageAsync(StoryBookPageEntity entity, CancellationToken cancellationToken = default);
    }
}
