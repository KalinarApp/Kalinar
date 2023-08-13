using Kalinar.Application.Contracts;
using Kalinar.Authorization;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Core.Extensions;
using Kalinar.Extensions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Kalinar.Controllers
{
    [ApiController]
    [Authorize(Policy = PolicyNames.IsValidUser)]
    [Route("api/v{version:apiVersion}/races"), ApiVersion("1.0")]
    public class RacesController : ControllerBase
    {
        private readonly IRaceService raceService;
        private readonly IGroupService groupService;
        private readonly IAuthorizationService authorizationService;

        public RacesController(IRaceService raceService, IGroupService groupService, IAuthorizationService authorizationService)
        {
            this.raceService = raceService;
            this.groupService = groupService;
            this.authorizationService = authorizationService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<RaceResponse>>> ListAsync([FromQuery] Guid? groupId, [FromQuery] bool? approved = default, CancellationToken cancellationToken = default)
        {
            // ToDo: Implement an overall administrator role which than can view all skill.
            if (groupId is null) throw new ForbiddenAccessException("User is not allowed to view this resource");

            GroupEntity group = await this.groupService.GetByIdAsync(groupId.Value, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanListSuggestables);

            IEnumerable<RaceEntity> races = await this.raceService.ListAsync(groupId.Value, approved, cancellationToken);

            return this.Ok(races.Select(item => (RaceResponse)item));
        }

        [HttpGet("{raceId}")]
        public async Task<ActionResult<RaceResponse>> GetAsync(Guid raceId, CancellationToken cancellationToken = default)
        {
            RaceEntity race = await this.raceService.GetByIdAsync(raceId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, race, PolicyNames.CanReadSuggestable);

            RaceResponse response = await this.raceService.GetByIdAsync(raceId, cancellationToken);

            return this.Ok(response);
        }

        [HttpGet("{raceId}/attributes")]
        public async Task<ActionResult<IEnumerable<AttributeValueResponse>>> ListAttributesByRaceId(Guid raceId, CancellationToken cancellationToken = default)
        {
            RaceEntity race = await this.raceService.GetByIdAsync(raceId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, race, PolicyNames.CanReadSuggestable);

            IEnumerable<RaceAttributeEntity> attributes = await this.raceService.ListAttributesAsync(raceId, cancellationToken);

            return this.Ok(attributes.Select(item => (AttributeValueResponse)item));
        }

        [HttpPost]
        public async Task<ActionResult<RaceResponse>> CreateAsync([FromBody] RaceCreateRequest request, CancellationToken cancellationToken = default)
        {
            string userId = this.User.GetId();
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanCreateSuggestable);

            RaceResponse response = await this.raceService.CreateAsync(userId, request, cancellationToken);

            return this.CreatedAtAction("Get", new { raceId = response.Id }, response);
        }

        [HttpPut("{raceId}")]
        public async Task<ActionResult<RaceResponse>> UpdateAsync(Guid raceId, [FromBody] RaceUpdateRequest request, CancellationToken cancellationToken = default)
        {
            RaceEntity race = await this.raceService.GetByIdAsync(raceId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, race, PolicyNames.CanUpdateSuggestable);

            RaceResponse response = await this.raceService.UpdateAsync(raceId, request, cancellationToken);
            return this.Ok(response);
        }

        [HttpPost("{raceId}/attributes")]
        public async Task<ActionResult> SetAttributesAsync(Guid raceId, [FromBody] IEnumerable<RaceAttributeRequest> request, CancellationToken cancellationToken = default)
        {
            RaceEntity race = await this.raceService.GetByIdAsync(raceId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, race, PolicyNames.CanSetRaceAttributes);

            await this.raceService.SetAttributesAsync(raceId, request, cancellationToken);
            return this.Ok();
        }

        [HttpPost("{raceId}/approve")]
        public async Task<ActionResult<AttributeResponse>> ApproveAsync(Guid raceId, CancellationToken cancellationToken = default)
        {
            RaceEntity race = await this.raceService.GetByIdAsync(raceId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, race, PolicyNames.CanApproveSuggestable);

            RaceResponse response = await this.raceService.ApproveAsync(raceId, cancellationToken);
            return this.Ok(response);
        }

        [HttpPost("{raceId}/reject")]
        public async Task<ActionResult<SkillResponse>> RejectAsync(Guid raceId, [FromBody] RejectRequest request, CancellationToken cancellationToken = default)
        {
            RaceEntity race = await this.raceService.GetByIdAsync(raceId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, race, PolicyNames.CanApproveSuggestable);

            RaceResponse response = await this.raceService.RejectAsync(raceId, request, cancellationToken);
            return this.Ok(response);
        }

        [HttpDelete("{raceId}")]
        public async Task<ActionResult> DeleteAsync(Guid raceId, CancellationToken cancellationToken = default)
        {
            RaceEntity race = await this.raceService.GetByIdAsync(raceId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, race, PolicyNames.CanDeleteSuggestable);

            await this.raceService.DeleteAsync(raceId, cancellationToken);
            return this.NoContent();
        }
    }
}
