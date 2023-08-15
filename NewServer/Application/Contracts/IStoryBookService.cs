using Kalinar.Core.Entities;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Contracts
{
    public interface IStoryBookService
    {
        Task<IEnumerable<StoryBookEntity>> ListAsync(Guid groupId, bool? unlockedOnly, CancellationToken cancellationToken = default);
        Task<IEnumerable<StoryBookPageEntity>> ListPagesAsync(Guid bookId, CancellationToken cancellationToken = default);
        Task<StoryBookEntity> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<StoryBookPageEntity> GetPageByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<StoryBookEntity> CreateAsync(StoryBookCreateRequest request, CancellationToken cancellationToken = default);
        Task<StoryBookPageEntity> CreatePageAsync(StoryBookPageCreateRequest request, CancellationToken cancellationToken = default);
        Task<StoryBookEntity> UpdateAsync(Guid id, StoryBookUpdateRequest request, CancellationToken cancellationToken = default);
        Task<StoryBookPageEntity> UpdatePageAsync(Guid id, StoryBookPageUpdateRequest request, CancellationToken cancellationToken = default);
        Task DeleteAsync(Guid id, CancellationToken cancellationToken = default);
        Task DeletePageAsync(Guid id, CancellationToken cancellationToken = default);
    }
}
