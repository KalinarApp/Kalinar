using Kalinar.Application.Contracts;
using Kalinar.Authorization;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Extensions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

using System.Threading;

namespace Kalinar.Controllers
{
    [ApiController]
    [Authorize(Policy = PolicyNames.IsValidUser)]
    [Route("api/v{version:apiVersion}/story-books"), ApiVersion("1.0")]
    public class StoryBooksController : ControllerBase
    {
        private readonly IStoryBookService storyBookService;
        private readonly IGroupService groupService;
        private readonly IAuthorizationService authorizationService;

        public StoryBooksController(IStoryBookService storyBookService, IGroupService groupService, IAuthorizationService authorizationService)
        {
            this.storyBookService = storyBookService;
            this.groupService = groupService;
            this.authorizationService = authorizationService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<StoryBookResponse>>> ListAsync([FromQuery] Guid? groupId, [FromQuery] bool? unlockedOnly, CancellationToken cancellationToken = default)
        {
            // ToDo: Implement an overall administrator role which than can view all story books.
            if (groupId is null) throw new ForbiddenAccessException("User is not allowed to view this resource");
            IEnumerable<StoryBookEntity> storyBooks = await this.storyBookService.ListAsync(groupId.Value, unlockedOnly, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, storyBooks, PolicyNames.CanListSkilltrees);

            return this.Ok(storyBooks.Select(item => (StoryBookResponse)item));
        }

        [HttpGet("{boolId}/pages")]
        public async Task<ActionResult<IEnumerable<StoryBookPageResponse>>> ListPagesAsync(Guid bookId, CancellationToken cancellationToken = default)
        {
            StoryBookEntity storyBook = await this.storyBookService.GetByIdAsync(bookId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, new List<StoryEntity> { storyBook }, PolicyNames.CanReadStoryItem);

            IEnumerable<StoryBookPageEntity> pages = await this.storyBookService.ListPagesAsync(bookId, cancellationToken);

            return this.Ok(pages.Select(item => (StoryBookPageResponse)item));
        }

        [HttpGet("{bookId}")]
        public async Task<ActionResult<StoryBookResponse>> GetAsync(Guid bookId, CancellationToken cancellationToken = default)
        {
            StoryBookEntity storyBook = await this.storyBookService.GetByIdAsync(bookId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, new List<StoryEntity> { storyBook }, PolicyNames.CanReadStoryItem);

            return this.Ok((StoryBookResponse)storyBook);
        }

        [HttpGet("{bookId}/pages/{pageId}")]
        public async Task<ActionResult<StoryBookPageResponse>> GetPageAsync(Guid bookId, Guid pageId, CancellationToken cancellationToken = default)
        {
            StoryBookEntity storyBook = await this.storyBookService.GetByIdAsync(bookId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, new List<StoryEntity> { storyBook }, PolicyNames.CanReadStoryItem);

            StoryBookPageResponse response = await this.storyBookService.GetPageByIdAsync(pageId, cancellationToken);
            return this.Ok(response);
        }

        [HttpPost]
        public async Task<ActionResult<StoryBookResponse>> CreateAsync([FromBody] StoryBookCreateRequest request, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanCreateStoryItem);

            StoryBookResponse response = await this.storyBookService.CreateAsync(request, cancellationToken);
            return this.CreatedAtAction("Get", new { bookId = response.Id}, response);
        }

        [HttpPost("{bookId}/pages")]
        public async Task<ActionResult<StoryBookPageResponse>> CreatePageAsync([FromBody] StoryBookPageCreateRequest request, CancellationToken cancellationToken = default)
        {
            StoryBookEntity storyBook = await this.storyBookService.GetByIdAsync(request.BookId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, storyBook.Group, PolicyNames.CanCreateStoryItem);

            StoryBookPageResponse response = await this.storyBookService.CreatePageAsync(request, cancellationToken);
            return this.CreatedAtAction("GetPage", new { bookId = response.BookId, pageId = response.Id }, response);
        }

        [HttpPut("{bookId}")]
        public async Task<ActionResult<StoryBookResponse>> UpdateAsync(Guid bookId, [FromBody] StoryBookUpdateRequest request, CancellationToken cancellationToken = default)
        {
            StoryBookEntity storyBook = await this.storyBookService.GetByIdAsync(bookId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, storyBook.Group, PolicyNames.CanUpdateStoryItem);

            StoryBookResponse response = await this.storyBookService.UpdateAsync(bookId, request, cancellationToken);
            return this.Ok(response);
        }

        [HttpPut("{bookId}/pages/{pageId}")]
        public async Task<ActionResult<StoryBookPageResponse>> UpdatePageAsync(Guid bookId, Guid pageId, [FromBody] StoryBookPageUpdateRequest request, CancellationToken cancellationToken = default)
        {
            StoryBookEntity storyBook = await this.storyBookService.GetByIdAsync(bookId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, storyBook.Group, PolicyNames.CanUpdateStoryItem);

            StoryBookPageResponse response = await this.storyBookService.UpdatePageAsync(pageId, request, cancellationToken);
            return this.Ok(response);
        }

        [HttpDelete("{bookId}")]
        public async Task<ActionResult> DeleteAsync(Guid bookId, CancellationToken cancellationToken = default)
        {
            StoryBookEntity storyBook = await this.storyBookService.GetByIdAsync(bookId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, storyBook.Group, PolicyNames.CanDeleteStoryItem);

            await this.storyBookService.DeleteAsync(bookId, cancellationToken);
            return this.NoContent();
        }

        [HttpDelete("{bookId}/pages/{pageId}")]
        public async Task<ActionResult> DeletePageAsync(Guid bookId, Guid pageId, CancellationToken cancellationToken = default)
        {
            StoryBookEntity storyBook = await this.storyBookService.GetByIdAsync(bookId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, storyBook.Group, PolicyNames.CanDeleteStoryItem);

            await this.storyBookService.DeletePageAsync(pageId, cancellationToken);
            return this.NoContent();
        }
    }
}
