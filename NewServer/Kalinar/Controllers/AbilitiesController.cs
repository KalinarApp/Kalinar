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
    [Route("api/v{version:apiVersion}/abilities"), ApiVersion("1.0")]
    public class AbilitiesController : ControllerBase
    {
        private readonly IAbilityService abilityService;
        private readonly IGroupService groupService;
        private readonly IAuthorizationService authorizationService;

        public AbilitiesController(IAbilityService abilityService, IGroupService groupService, IAuthorizationService authorizationService)
        {
            this.abilityService = abilityService;
            this.groupService = groupService;
            this.authorizationService = authorizationService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<AbilityResponse>>> ListAsync([FromQuery]Guid? groupId, [FromQuery] bool? approved = default, CancellationToken cancellationToken = default)
        {
            // ToDo: Implement an overall administrator role which than can view all abilities.
            if (groupId is null) throw new ForbiddenAccessException("User is not allowed to view this resource");
            GroupEntity group = await this.groupService.GetByIdAsync(groupId.Value, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanListSuggestables);

            IEnumerable<AbilityEntity> abilities = await this.abilityService.ListAsync(groupId.Value, approved, cancellationToken);

            return this.Ok(abilities.Select(item => (AbilityResponse)item));
        }

        [HttpGet("{abilityId}/tags")]
        public async Task<ActionResult<IEnumerable<string>>> ListTagsAsync(Guid abilityId, CancellationToken cancellationToken = default) 
        { 
            AbilityEntity ability = await this.abilityService.GetByIdAsync(abilityId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, ability, PolicyNames.CanReadSuggestable);
        
            IEnumerable<AbilityTagEntity> tags = await this.abilityService.ListTagsByAbilityIdAsync(abilityId, cancellationToken);
        
            return this.Ok(tags.Select(tag => tag.Tag));
        }

        [HttpGet("{abilityId}")]
        public async Task<ActionResult<AbilityResponse>> GetAsync(Guid abilityId, CancellationToken cancellationToken = default)
        {
            AbilityEntity ability = await this.abilityService.GetByIdAsync(abilityId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, ability, PolicyNames.CanReadSuggestable);

            return this.Ok((AbilityResponse)ability);
        }

        [HttpPost]
        public async Task<ActionResult<AbilityResponse>> CreateAsync([FromBody] AbilityCreateRequest request, CancellationToken cancellationToken = default)
        {
            string userId = this.User.GetId();
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanCreateSuggestable);

            AbilityResponse response = await this.abilityService.CreateAsync(userId, request, cancellationToken);

            return this.CreatedAtAction("Get", new { abilityId = response.Id }, response);
        }

        [HttpPut("{abilityId}")]
        public async Task<ActionResult<AbilityResponse>> UpdateAsync(Guid abilityId, [FromBody] AbilityUpdateRequest request, CancellationToken cancellationToken = default)
        {
            AbilityEntity ability = await this.abilityService.GetByIdAsync(abilityId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, ability, PolicyNames.CanUpdateSuggestable);

            AbilityResponse response = await this.abilityService.UpdateAsync(abilityId, request, cancellationToken);
            return this.Ok(response);
        }

        [HttpPost("{abilityId}/tags")]
        public async Task<ActionResult> SetTagsAsync(Guid abilityId, [FromBody] IEnumerable<string> tags, CancellationToken cancellationToken = default)
        {
            AbilityEntity ability = await this.abilityService.GetByIdAsync(abilityId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, ability, PolicyNames.CanSetAbilityTags);

            await this.abilityService.SetTagsAsync(abilityId, tags, cancellationToken);
            return this.Ok();
        }

        [HttpPost("{abilityId}/approve")]
        public async Task<ActionResult<AbilityResponse>> ApproveAsync(Guid abilityId, CancellationToken cancellationToken = default)
        {
            AbilityEntity ability = await this.abilityService.GetByIdAsync(abilityId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, ability, PolicyNames.CanApproveSuggestable);

            AbilityResponse response = await this.abilityService.ApproveAsync(abilityId, cancellationToken);
            return this.Ok(response);
        }

        [HttpPost("{abilityId}/reject")]
        public async Task<ActionResult<AbilityResponse>> RejectAsync(Guid abilityId, [FromBody] RejectRequest request, CancellationToken cancellationToken = default)
        {
            AbilityEntity ability = await this.abilityService.GetByIdAsync(abilityId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, ability, PolicyNames.CanApproveSuggestable);

            AbilityResponse response = await this.abilityService.RejectAsync(abilityId, request, cancellationToken);
            return this.Ok(response);
        }

        [HttpDelete("{abilityId}")]
        public async Task<ActionResult> DeleteAsync(Guid abilityId, CancellationToken cancellationToken = default)
        {
            AbilityEntity ability = await this.abilityService.GetByIdAsync(abilityId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, ability, PolicyNames.CanDeleteSuggestable);

            await this.abilityService.DeleteAsync(abilityId, cancellationToken);
            return this.NoContent();
        }
    }
}
