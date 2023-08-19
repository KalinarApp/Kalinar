using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Services
{
    internal class StoryBookService : IStoryBookService
    {
        private readonly IStoryBookRepository bookRepository;
        private readonly IGroupService groupService;

        public StoryBookService(IStoryBookRepository bookRepository, IGroupService groupService)
        {
            this.bookRepository = bookRepository;
            this.groupService = groupService;
        }

        public async Task<IEnumerable<StoryBookEntity>> ListAsync(Guid groupId, bool? unlockedOnly, CancellationToken cancellationToken = default)
        {
            return unlockedOnly.HasValue && unlockedOnly.Value 
                ? await this.bookRepository.ListUnlockedByGroupIdAsync(groupId, cancellationToken) 
                : await this.bookRepository.ListByGroupIdAsync(groupId, cancellationToken);
        }

        public async Task<IEnumerable<StoryBookPageEntity>> ListPagesAsync(Guid bookId, CancellationToken cancellationToken = default)
        {
            return await this.bookRepository.ListPagesAsync(bookId, cancellationToken);
        }

        public async Task<StoryBookEntity> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await this.bookRepository.FindByIdAsync(id, cancellationToken) ?? throw new StoryBookNotFoundException(id);
        }

        public async Task<StoryBookPageEntity> GetPageByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await this.bookRepository.FindPageAsync(id, cancellationToken) ?? throw new StoryBookPageNotFoundException(id);
        }

        public async Task<StoryBookEntity> CreateAsync(StoryBookCreateRequest request, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, cancellationToken: cancellationToken);

            StoryBookEntity book = new()
            {
                Id = Guid.NewGuid(),
                CreatedAt = DateTime.UtcNow,
                GroupId = request.GroupId,
                Group = group,
                Title = request.Title,
                ImageUrl = request.ImageUrl,
                Description = request.Description,
                IsUnlocked = request.IsUnlocked,
                Pages = new List<StoryBookPageEntity>(),
            };

            return await this.bookRepository.CreateAsync(book, cancellationToken);
        }

        public async Task<StoryBookPageEntity> CreatePageAsync(StoryBookPageCreateRequest request, CancellationToken cancellationToken = default)
        {
            await this.GetByIdAsync(request.BookId, cancellationToken: cancellationToken);

            IEnumerable<StoryBookPageEntity> pages = await this.ListPagesAsync(request.BookId, cancellationToken);

            int pageNumber = pages.Any() ? pages.Max(page => page.PageNumber) + 1 : 1;
            StoryBookPageEntity page = new()
            {
                Id = Guid.NewGuid(),
                BookId = request.BookId,
                Title = request.Title,
                Content = request.Content,
                IsUnlocked = request.IsUnlocked,
                PageNumber = pageNumber,
            };

            return await this.bookRepository.CreatePageAsync(page, cancellationToken);
        }

        public async Task<StoryBookEntity> UpdateAsync(Guid id, StoryBookUpdateRequest request, CancellationToken cancellationToken = default)
        {
            StoryBookEntity book = await this.GetByIdAsync(id, cancellationToken);

            book.Title = request.Title;
            book.Description = request.Description;
            book.ImageUrl = request.ImageUrl;
            book.IsUnlocked = request.IsUnlocked;

            return await this.bookRepository.UpdateAsync(book, cancellationToken);
        }

        public async Task<StoryBookPageEntity> UpdatePageAsync(Guid id, StoryBookPageUpdateRequest request, CancellationToken cancellationToken = default)
        {
            StoryBookPageEntity page = await this.GetPageByIdAsync(id, cancellationToken);

            page.Title = request.Title;
            page.Content = request.Content;
            page.IsUnlocked = request.IsUnlocked;

            return await this.bookRepository.UpdatePageAsync(page, cancellationToken);
        }

        public async Task DeleteAsync(Guid id, CancellationToken cancellationToken = default)
        {
            StoryBookEntity book = await this.GetByIdAsync(id, cancellationToken);
            await this.bookRepository.DeleteAsync(book, cancellationToken);
        }

        public async Task DeletePageAsync(Guid id, CancellationToken cancellationToken = default)
        {
            StoryBookPageEntity page = await this.GetPageByIdAsync(id, cancellationToken);
            await this.bookRepository.DeletePageAsync(page, cancellationToken);

            IEnumerable<StoryBookPageEntity> pages = await this.ListPagesAsync(page.BookId, cancellationToken);
            foreach (StoryBookPageEntity p in pages.Where(p => p.PageNumber > page.PageNumber))
            {
                p.PageNumber--;
                await this.bookRepository.UpdatePageAsync(p, cancellationToken);
            }
        }
    }
}
