using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    internal class StoryEventRepository : BaseGroupRepository<StoryEventEntity>, IStoryEventRepository
    {
        public StoryEventRepository(Context context) : base(context) { }

        public async Task<IEnumerable<StoryEventEntity>> ListUnlockedByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.context.StoryEvents
                .Where(e => e.GroupId == groupId)
                .Where(e => e.IsUnlocked)
                .ToListAsync(cancellationToken);
        }
    }
}
