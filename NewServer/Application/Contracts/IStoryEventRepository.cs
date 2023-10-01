using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IStoryEventRepository : IBaseRepository<StoryEventEntity>
    {
        Task<IEnumerable<StoryEventEntity>> ListUnlockedByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default);
    }
}
