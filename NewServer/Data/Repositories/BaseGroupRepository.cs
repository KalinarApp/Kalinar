using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    public class BaseGroupRepository<T> : BaseRepository<T>
        where T : BaseEntityWithGroup
    {
        public BaseGroupRepository(Context context) 
            : base(context) { }

        public virtual async Task<IEnumerable<T>> ListByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.context.Set<T>().Include(item => item.Group).Where(item => item.GroupId == groupId).ToListAsync(cancellationToken);
        }

        public override async Task<T?> FindByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await this.context.Set<T>().Include(item => item.Group).FirstOrDefaultAsync(item => item.Id == id, cancellationToken);
        }
    }
}
