using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    internal class StoryImageRepository : BaseGroupRepository<StoryImageEntity>, IStoryImageRepository
    {
        public StoryImageRepository(Context context) : base(context) { }

        public async Task<IEnumerable<StoryImageEntity>> ListUnlockedByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.context.StoryImages
                .Where(e => e.GroupId == groupId)
                .Where(e => e.IsUnlocked)
                .ToListAsync(cancellationToken);
        }
    }
}
