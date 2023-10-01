using Kalinar.Application.Contracts;
using Kalinar.Authorization;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Extensions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Kalinar.Controllers
{
    [ApiController]
    [Authorize(Policy = PolicyNames.IsValidUser)]
    [Route("api/v{version:apiVersion}/story-images"), ApiVersion("1.0")]
    public class StoryImagesController : ControllerBase
    {
        private readonly IStoryImageService storyImageService;
        private readonly IGroupService groupService;
        private readonly IAuthorizationService authorizationService;

        public StoryImagesController(IStoryImageService storyImageService, IGroupService groupService, IAuthorizationService authorizationService)
        {
            this.storyImageService = storyImageService;
            this.groupService = groupService;
            this.authorizationService = authorizationService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<StoryImageResponse>>> ListAsync([FromQuery] Guid? groupId, [FromQuery] bool? unlockedOnly, CancellationToken cancellationToken = default)
        {
            // ToDo: Implement an overall administrator role which than can view all story images.
            if (groupId is null) throw new ForbiddenAccessException("User is not allowed to view this resource");
            IEnumerable<StoryImageEntity> storyImages = await this.storyImageService.ListAsync(groupId.Value, unlockedOnly, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, storyImages, PolicyNames.CanListSkilltrees);

            return this.Ok(storyImages.Select(item => (StoryImageResponse)item));
        }

        [HttpGet("{imageId}")]
        public async Task<ActionResult<StoryImageResponse>> GetAsync(Guid imageId, CancellationToken cancellationToken = default)
        {
            StoryImageEntity storyImage = await this.storyImageService.GetByIdAsync(imageId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, new List<StoryEntity> { storyImage }, PolicyNames.CanReadStoryItem);

            return this.Ok((StoryImageResponse)storyImage);
        }

        [HttpPost]
        public async Task<ActionResult<StoryImageResponse>> CreateAsync([FromBody] StoryImageCreateRequest request, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanCreateStoryItem);

            StoryImageResponse response = await this.storyImageService.CreateAsync(request, cancellationToken);
            return this.CreatedAtAction("Get", new { imageId = response.Id}, response);
        }

        [HttpPut("{imageId}")]
        public async Task<ActionResult<StoryImageResponse>> UpdateAsync(Guid imageId, [FromBody] StoryImageUpdateRequest request, CancellationToken cancellationToken = default)
        {
            StoryImageEntity storyImage = await this.storyImageService.GetByIdAsync(imageId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, storyImage.Group, PolicyNames.CanUpdateStoryItem);

            StoryImageResponse response = await this.storyImageService.UpdateAsync(imageId, request, cancellationToken);
            return this.Ok(response);
        }

        [HttpDelete("{imageId}")]
        public async Task<ActionResult> DeleteAsync(Guid imageId, CancellationToken cancellationToken = default)
        {
            StoryImageEntity storyImage = await this.storyImageService.GetByIdAsync(imageId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, storyImage.Group, PolicyNames.CanDeleteStoryItem);

            await this.storyImageService.DeleteAsync(imageId, cancellationToken);
            return this.NoContent();
        }
    }
}
