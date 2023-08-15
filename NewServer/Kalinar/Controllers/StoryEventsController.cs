using Kalinar.Application.Contracts;
using Kalinar.Authorization;
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
        private readonly IGroupService groupService;
        private readonly IAuthorizationService authorizationService;

        public StoryEventsController(IStoryEventService storyEventService, IGroupService groupService, IAuthorizationService authorizationService)
        {
            this.groupService = groupService;
            this.authorizationService = authorizationService;
        }

        public async Task<IEnumerable<StoryEventResponse>> ListAsync([FromQuery] Guid? groupId, CancellationToken cancellationToken = default)
        {

        }
    }
}
