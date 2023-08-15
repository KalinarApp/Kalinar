using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    internal class StoryBookRepository : BaseGroupRepository<StoryBookEntity>, IStoryBookRepository
    {
        public StoryBookRepository(Context context) : base(context)  { }

        public async Task<IEnumerable<StoryBookEntity>> ListUnlockedByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.context.StoryBooks
                .Where(e => e.GroupId == groupId)
                .Where(e => e.IsUnlocked)
                .ToListAsync(cancellationToken);
        }

        public async Task<IEnumerable<StoryBookPageEntity>> ListPagesAsync(Guid bookId, CancellationToken cancellationToken = default)
        {
            return await this.context.StoryBookPages.Where(item => item.BookId == bookId).ToListAsync(cancellationToken);
        }

        public async Task<StoryBookPageEntity?> FindPageAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await this.context.StoryBookPages.FirstOrDefaultAsync(item => item.Id == id, cancellationToken);
        }

        public async Task<StoryBookPageEntity> CreatePageAsync(StoryBookPageEntity entity, CancellationToken cancellationToken = default)
        {
            await this.context.StoryBookPages.AddAsync(entity, cancellationToken);
            await this.context.SaveChangesAsync(cancellationToken);
            return entity;
        }

        public async Task<StoryBookPageEntity> UpdatePageAsync(StoryBookPageEntity entity, CancellationToken cancellationToken = default)
        {
            this.context.StoryBookPages.Update(entity);
            await this.context.SaveChangesAsync(cancellationToken);
            return entity;
        }

        public async Task DeletePageAsync(StoryBookPageEntity entity, CancellationToken cancellationToken = default)
        {
            this.context.StoryBookPages.Remove(entity);
            await this.context.SaveChangesAsync(cancellationToken);
        }
    }
}
