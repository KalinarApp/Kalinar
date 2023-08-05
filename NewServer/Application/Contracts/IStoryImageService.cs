using Kalinar.Core.Entities;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Contracts
{
    public interface IStoryImageService
    {
        Task<IEnumerable<StoryImageEntity>> ListAsync(Guid groupId, CancellationToken cancellationToken = default);
        Task<StoryImageEntity> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<StoryImageEntity> CreateAsync(StoryImageCreateRequest request, CancellationToken cancellationToken = default);
        Task<StoryImageEntity> UpdateAsync(Guid id, StoryImageUpdateRequest request, CancellationToken cancellationToken = default);
        Task DeleteAsync(Guid id, CancellationToken cancellationToken = default);
    }
}
