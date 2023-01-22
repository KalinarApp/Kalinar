using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Logging;
using Hero.Server.Core.Models.Storyline;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Database;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Hero.Server.DataAccess.Repositories
{
    public class StoryEntryRepository : IStoryEntryRepository
    {
        private readonly HeroDbContext context;
        private readonly IGroupContext group;
        private readonly ILogger<StoryEntryRepository> logger;

        public StoryEntryRepository(HeroDbContext context, IGroupContext group, ILogger<StoryEntryRepository> logger)
        {
            this.context = context;
            this.group = group;
            this.logger = logger;
        }

        public async Task<List<StoryEntry>> GetAllAsync(bool unlockedOnly = false, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.StoryEntries.Where(entry => !unlockedOnly || entry.IsUnlocked).ToListAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while fetching all story entries.");
            }
        }

        public async Task<StoryEntry?> GetByIdAsync(Guid id, bool unlockedOnly = false, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.StoryEntries
                    .Include(entry => ((StoryBook)entry).Pages.Where(page => !unlockedOnly || page.IsWritten))
                    .FirstOrDefaultAsync(entry =>  entry.Id == id, cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while fetching the story entry.");
            }
        }

        public async Task CreateAsync(StoryEntry entry, CancellationToken cancellationToken = default)
        {
            try
            {
                entry.GroupId = this.group.Id;
                entry.Order = await this.context.StoryEntries.CountAsync();

                await this.context.StoryEntries.AddAsync(entry);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while creating story entry.");
            }
        }

        public async Task UpdateAsync(Guid id, StoryEntry entry, CancellationToken cancellationToken = default)
        {
            try
            {
                StoryEntry? existing = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

                if (null == existing)
                {
                    throw new ObjectNotFoundException($"The story entry you're trying to update does not exist.");
                }

                existing.Update(entry);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (HeroException ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while updating story entry.");
            }
        }

        private async Task MovePosition(int lowerBound, int upperBound, int direction)
        {
            List<StoryEntry> entriesInBounds = await this.context.StoryEntries.Where(e => e.Order > lowerBound - (direction > 0 ? direction : 0) && e.Order < upperBound - (direction < 0 ? direction : 0)).ToListAsync();

            foreach (StoryEntry entry in entriesInBounds)
            {
                entry.Order += direction;
            }
        }

        public async Task UpdatePositionAsync(Guid id, int newPosition, CancellationToken cancellationToken = default)
        {
            try
            {
                StoryEntry? existing = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

                if (null == existing)
                {
                    throw new ObjectNotFoundException($"The story entry you're trying to update does not exist.");
                }

                int oldPosition = existing.Order;

                await this.MovePosition(Math.Min(oldPosition, newPosition), Math.Max(oldPosition, newPosition), oldPosition > newPosition ? 1 : -1);

                existing.Order = newPosition;

                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (HeroException ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while updating position of story entry.");
            }
        }

        public async Task UnlockAsync(Guid id, bool isUnlocked, CancellationToken cancellationToken = default)
        {
            try
            {
                StoryEntry? entry = await this.GetByIdAsync(id, false, cancellationToken);

                if (null == entry)
                {
                    throw new ObjectNotFoundException($"The story entry (id: {id}) you're trying to get does not exist.");
                }

                entry.IsUnlocked = isUnlocked;

                await this.context.SaveChangesAsync();
            }
            catch (HeroException ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while updating the story entry unlocked state.");
            }
        }

        public async Task DeleteAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                StoryEntry? existing = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

                if (null == existing)
                {
                    throw new ObjectNotFoundException($"The story entry you're trying to delete does not exist.");
                }

                this.context.StoryEntries.Remove(existing);

                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (HeroException ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while deleting story entry.");
            }
        }
    }
}
