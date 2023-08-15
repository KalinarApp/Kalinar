using Kalinar.Core.Entities;

namespace Kalinar.Application.Contracts
{
    public interface IStoryImageRepository : IBaseRepository<StoryImageEntity>
    {
        Task<IEnumerable<StoryImageEntity>> ListUnlockedByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default);
    }
}
