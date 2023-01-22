using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Logging;
using Hero.Server.Core.Models.Storyline;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Database;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Hero.Server.DataAccess.Repositories
{
    public class StoryBookPageRepository : IStoryBookPageRepository
    {
        private readonly HeroDbContext context;
        private readonly IStoryEntryRepository entryRepository;
        private readonly IGroupContext group;
        private readonly ILogger<StoryBookPageRepository> logger;

        public StoryBookPageRepository(HeroDbContext context, IStoryEntryRepository entryRepository, IGroupContext group, ILogger<StoryBookPageRepository> logger)
        {
            this.context = context;
            this.entryRepository = entryRepository;
            this.group = group;
            this.logger = logger;
        }

        private async Task<StoryBookPage?> GetByIdAsync(Guid bookId, Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.StoryBookPages.SingleOrDefaultAsync(page => page.BookId == bookId && page.Id == id, cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while fetching page.");
            }
        }

        public async Task CreateAsync(Guid bookId, StoryBookPage page, CancellationToken cancellationToken = default)
        {
            try
            {
                StoryEntry? existing = await this.entryRepository.GetByIdAsync(bookId, cancellationToken: cancellationToken);
                StoryBook? book = existing as StoryBook;
                if (null == existing && !(existing is StoryBook))
                {
                    throw new ObjectNotFoundException($"The story entry you're trying to update does not exist.");
                }

                book!.Pages.Add(page);
                page.GroupId = this.group.Id;
                page.PageNumber = await this.context.StoryBookPages.CountAsync();

                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while creating page.");
            }
        }

        public async Task UpdateAsync(Guid bookId, Guid id, StoryBookPage page, CancellationToken cancellationToken = default)
        {
            try
            {
                StoryBookPage? existing = await this.GetByIdAsync(bookId, id, cancellationToken);

                if (null == existing)
                {
                    throw new ObjectNotFoundException($"The book page you're trying to update does not exist.");
                }

                existing.Update(page);
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
                throw new HeroException("An error occured while updating page.");
            }
        }

        private async Task MovePosition(int lowerBound, int upperBound, int direction)
        {
            List<StoryBookPage> entriesInBounds = await this.context.StoryBookPages.Where(e => e.PageNumber > lowerBound - (direction > 0 ? direction : 0) && e.PageNumber < upperBound - (direction < 0 ? direction : 0)).ToListAsync();

            foreach (StoryBookPage entry in entriesInBounds)
            {
                entry.PageNumber += direction;
            }
        }

        public async Task UpdatePositionAsync(Guid bookId, Guid id, int newPosition, CancellationToken cancellationToken = default)
        {
            try
            {
                StoryBookPage? existing = await this.GetByIdAsync(bookId, id, cancellationToken);

                if (null == existing)
                {
                    throw new ObjectNotFoundException($"The book page you're trying to update does not exist.");
                }

                int oldPosition = existing.PageNumber;
                existing.PageNumber = newPosition;

                await this.MovePosition(Math.Min(oldPosition, newPosition), Math.Max(oldPosition, newPosition), oldPosition > newPosition ? 1 : -1);

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
                throw new HeroException("An error occured while updating page number.");
            }
        }

        public async Task UnlockAsync(Guid id, Guid pageId, bool isUnlocked, CancellationToken cancellationToken = default)
        {
            try
            {
                StoryBookPage? page = await this.GetByIdAsync(id, pageId, cancellationToken);

                if (null == page)
                {
                    throw new ObjectNotFoundException($"The book page you're trying to update does not exist.");
                }

                page.IsWritten = isUnlocked;

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
                throw new HeroException("An error occured while updating the book state written state.");
            }
        }

        public async Task DeleteAsync(Guid bookId, Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                StoryBookPage? existing = await this.GetByIdAsync(bookId, id, cancellationToken);

                if (null == existing)
                {
                    throw new ObjectNotFoundException($"The story entry you're trying to delete does not exist.");
                }

                this.context.StoryBookPages.Remove(existing);

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
                throw new HeroException("An error occured while deleting page.");
            }
        }

        public async Task<List<StoryBookPage>> GetAllAsync(Guid bookId, bool writtenOnly, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.StoryBookPages
                    .Where(page => page.BookId == bookId)
                    .Where(page => !writtenOnly || page.IsWritten)
                    .ToListAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while fetching all book pages.");
            }
        }
    }
}
