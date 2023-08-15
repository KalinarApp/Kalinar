using Kalinar.Application.Contracts;
using Kalinar.Authorization;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Extensions;
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

        public async Task<IEnumerable<StoryEventResponse>> ListAsync([FromQuery] Guid? groupId, CancellationToken cancellationToken = default)
        {
            // ToDo: Implement an overall administrator role which than can view all story events.
            if (groupId is null) throw new ForbiddenAccessException("User is not allowed to view this resource");
            GroupEntity group = await this.groupService.GetByIdAsync(groupId.Value, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanListSkilltrees);

            IEnumerable<StoryEventEntity> storyEvents = await this.storyEventService.ListAsync(groupId.Value, cancellationToken);
            return storyEvents.Select(item => (StoryEventResponse)item);
        }

        [HttpGet("{eventId}")]
        public async Task<StoryEventResponse> GetAsync(Guid eventId, CancellationToken cancellationToken = default)
        {
            StoryEventEntity storyEvent = await this.storyEventService.GetByIdAsync(eventId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, storyEvent.Group, PolicyNames.CanReadStoryItem);

            return (StoryEventResponse)storyEvent;
        }
    }
}
