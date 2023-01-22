using AutoMapper;

using Hero.Server.Core.Models.Storyline;
using Hero.Server.Core.Repositories;
using Hero.Server.Identity;
using Hero.Server.Identity.Attributes;
using Hero.Server.Messages.Requests;
using Hero.Server.Messages.Responses;

using Microsoft.AspNetCore.Mvc;

namespace Hero.Server.Controllers
{
    [Route("api/story/book/{id}")]
    [ApiController]
    public class StoryBookController : ControllerBase
    {
        private readonly IStoryBookPageRepository repository;
        private readonly IUserRepository userRepository;
        private readonly IMapper mapper;

        public StoryBookController(IStoryBookPageRepository repository, IUserRepository userRepository, IMapper mapper)
        {
            this.repository = repository;
            this.userRepository = userRepository;
            this.mapper = mapper;
        }

        //[HttpGet, IsGroupMember]
        //public async Task<IActionResult> GetAllPages(Guid id, CancellationToken cancellationToken = default)
        //{
        //    bool isAdmin = await this.userRepository.IsOwner(this.HttpContext.User.GetUserId());
        //    List<StoryBookPage> pages = await this.repository.GetAllAsync(id, !isAdmin, cancellationToken);

        //    return this.Ok(pages.Select(entry => this.mapper.Map<StoryBookPageResponse>(entry)));
        //}

        [HttpPost("reorder"), IsGroupAdmin]
        public async Task<IActionResult> UpdatePageNumberAsync(Guid id, [FromBody] ReorderRequest request, CancellationToken cancellationToken = default)
        {
            await this.repository.UpdatePositionAsync(id, request.EntityId, request.Position, cancellationToken);

            return this.Ok();
        }

        [HttpPost("{pageId}/unlock"), IsGroupAdmin]
        public async Task<IActionResult> SwitchActiveStateForSkilltreeAsync(Guid id, Guid pageId, [FromBody] ChangeStateRequest request, CancellationToken cancellationToken)
        {
            await this.repository.UnlockAsync(id, pageId, request.State, cancellationToken);
            return this.Ok();
        }

        [HttpPost, IsGroupAdmin]
        public async Task<IActionResult> CreatePageAsync(Guid id, [FromBody] StoryBookPageRequest request, CancellationToken cancellationToken = default)
        {
            StoryBookPage page = this.mapper.Map<StoryBookPage>(request);
            await this.repository.CreateAsync(id, page, cancellationToken);

            return this.Ok(this.mapper.Map<StoryBookPage>(page));
        }

        [HttpPut("{pageId}"), IsGroupAdmin]
        public async Task<IActionResult> UpdatePageAsync(Guid id, Guid pageId, [FromBody] StoryBookPageRequest request, CancellationToken cancellationToken = default)
        {
            StoryBookPage page = this.mapper.Map<StoryBookPage>(request);
            await this.repository.UpdateAsync(id, pageId, page, cancellationToken);

            return this.Ok(this.mapper.Map<StoryBookPage>(page));
        }

        [HttpDelete("{pageId}"), IsGroupAdmin]
        public async Task<IActionResult> DeletePageAsync(Guid id, Guid pageId, CancellationToken cancellationToken = default)
        {
            await this.repository.DeleteAsync(id, pageId, cancellationToken);

            return this.Ok();
        }
    }
}
