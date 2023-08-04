using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    public class BaseRepository<T>
        where T : BaseEntity
    {
        protected readonly Context context;

        public BaseRepository(Context context)
        {
            this.context = context;
        }

        public virtual async Task<IEnumerable<T>> ListAsync(CancellationToken cancellationToken = default)
        {
            return await context.Set<T>().ToListAsync(cancellationToken);
        }

        public virtual async Task<T?> FindByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await context.Set<T>().FirstOrDefaultAsync(item => item.Id == id, cancellationToken);
        }

        public virtual async Task<T> CreateAsync(T entity, CancellationToken cancellationToken = default)
        {
            await context.Set<T>().AddAsync(entity, cancellationToken);
            await context.SaveChangesAsync(cancellationToken);

            return entity;
        }

        public async Task<T> UpdateAsync(T entity, CancellationToken cancellationToken = default)
        {
            context.Set<T>().Update(entity);
            await context.SaveChangesAsync(cancellationToken);

            return entity;
        }

        public async Task DeleteAsync(T entity, CancellationToken cancellationToken = default)
        {
            context.Set<T>().Remove(entity);
            await context.SaveChangesAsync(cancellationToken);
        }
    }
}
