using Kalinar.Core.Entities;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Contracts
{
    public interface IStoryEventService
    {
        Task<IEnumerable<StoryEventEntity>> ListAsync(Guid groupId, bool? unlockedOnly, CancellationToken cancellationToken = default);
        Task<StoryEventEntity> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<StoryEventEntity> CreateAsync(StoryEventCreateRequest request, CancellationToken cancellationToken = default);
        Task<StoryEventEntity> UpdateAsync(Guid id, StoryEventUpdateRequest request, CancellationToken cancellationToken = default);
        Task DeleteAsync(Guid id, CancellationToken cancellationToken = default);
    }
}
