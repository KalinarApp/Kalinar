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
    [Route("api/v{version:apiVersion}/story-events"), ApiVersion("1.0")]
    public class StoryEventsController : ControllerBase
    {
        private readonly IStoryEventService storyEventService;
        private readonly IGroupService groupService;
        private readonly IAuthorizationService authorizationService;

        public StoryEventsController(IStoryEventService storyEventService, IGroupService groupService, IAuthorizationService authorizationService)
        {
            this.storyEventService = storyEventService;
            this.groupService = groupService;
            this.authorizationService = authorizationService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<StoryEventResponse>>> ListAsync([FromQuery] Guid? groupId, [FromQuery] bool? unlockedOnly, CancellationToken cancellationToken = default)
        {
            // ToDo: Implement an overall administrator role which than can view all story events.
            if (groupId is null) throw new ForbiddenAccessException("User is not allowed to view this resource");
            IEnumerable<StoryEventEntity> storyEvents = await this.storyEventService.ListAsync(groupId.Value, unlockedOnly, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, storyEvents, PolicyNames.CanListSkilltrees);

            return this.Ok(storyEvents.Select(item => (StoryEventResponse)item));
        }

        [HttpGet("{eventId}")]
        public async Task<ActionResult<StoryEventResponse>> GetAsync(Guid eventId, CancellationToken cancellationToken = default)
        {
            StoryEventEntity storyEvent = await this.storyEventService.GetByIdAsync(eventId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, new List<StoryEntity> { storyEvent }, PolicyNames.CanReadStoryItem);

            return this.Ok((StoryEventResponse)storyEvent);
        }

        [HttpPost]
        public async Task<ActionResult<StoryEventResponse>> CreateAsync([FromBody] StoryEventCreateRequest request, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanCreateStoryItem);

            StoryEventResponse response = await this.storyEventService.CreateAsync(request, cancellationToken);
            return this.CreatedAtAction("Get", new { eventId = response.Id}, response);
        }

        [HttpPut("{eventId}")]
        public async Task<ActionResult<StoryEventResponse>> UpdateAsync(Guid eventId, [FromBody] StoryEventUpdateRequest request, CancellationToken cancellationToken = default)
        {
            StoryEventEntity storyEvent = await this.storyEventService.GetByIdAsync(eventId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, storyEvent.Group, PolicyNames.CanUpdateStoryItem);

            StoryEventResponse response = await this.storyEventService.UpdateAsync(eventId, request, cancellationToken);
            return this.Ok(response);
        }

        [HttpDelete("{eventId}")]
        public async Task<ActionResult> DeleteAsync(Guid eventId, CancellationToken cancellationToken = default)
        {
            StoryEventEntity storyEvent = await this.storyEventService.GetByIdAsync(eventId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, storyEvent.Group, PolicyNames.CanDeleteStoryItem);

            await this.storyEventService.DeleteAsync(eventId, cancellationToken);
            return this.NoContent();
        }
    }
}
