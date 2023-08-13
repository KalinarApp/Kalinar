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
    [Route("api/v{version:apiVersion}/attributes"), ApiVersion("1.0")]
    public class AttributesController : ControllerBase
    {
        private readonly IAttributeService attributesService;
        private readonly IGroupService groupService;
        private readonly IAuthorizationService authorizationService;

        public AttributesController(IAttributeService attributesService, IGroupService groupService, IAuthorizationService authorizationService)
        {
            this.attributesService = attributesService;
            this.groupService = groupService;
            this.authorizationService = authorizationService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<AttributeResponse>>> ListAsync([FromQuery] Guid? groupId, [FromQuery] bool? approved = default, CancellationToken cancellationToken = default)
        {
            // ToDo: Implement an overall administrator role which than can view all attributes.
            if (groupId is null) throw new ForbiddenAccessException("User is not allowed to view this resource");
            GroupEntity group = await this.groupService.GetByIdAsync(groupId.Value, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanListSuggestables);

            IEnumerable<AttributeEntity> abilities = await this.attributesService.ListAsync(groupId.Value, approved, cancellationToken);

            return this.Ok(abilities.Select(item => (AttributeResponse)item));
        }

        [HttpGet("{abilityId}")]
        public async Task<ActionResult<AttributeResponse>> GetAsync(Guid abilityId, CancellationToken cancellationToken = default)
        {
            AttributeEntity attribute = await this.attributesService.GetByIdAsync(abilityId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, attribute, PolicyNames.CanReadSuggestable);

            AttributeResponse response = await this.attributesService.GetByIdAsync(abilityId, cancellationToken);

            return this.Ok(response);
        }

        [HttpPost]
        public async Task<ActionResult<AttributeResponse>> CreateAsync([FromBody] AttributeCreateRequest request, CancellationToken cancellationToken = default)
        {
            string userId = this.User.GetId();
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);
            if (!group.HasMember(userId)) throw new ForbiddenAccessException("User is not allowed to view this resource");

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanCreateSuggestable);

            AttributeResponse response = await this.attributesService.CreateAsync(userId, request, cancellationToken);

            return this.CreatedAtAction("Get", new { abilityId = response.Id }, response);
        }

        [HttpPut("{attributeId}")]
        public async Task<ActionResult<AttributeResponse>> UpdateAsync(Guid attributeId, [FromBody] AttributeUpdateRequest request, CancellationToken cancellationToken = default)
        {
            AttributeEntity attribute = await this.attributesService.GetByIdAsync(attributeId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, attribute, PolicyNames.CanUpdateSuggestable);

            AttributeResponse response = await this.attributesService.UpdateAsync(attributeId, request, cancellationToken);
            return this.Ok(response);
        }

        [HttpPost("{attributeId}/approve")]
        public async Task<ActionResult<AttributeResponse>> ApproveAsync(Guid attributeId, CancellationToken cancellationToken = default)
        {
            AttributeEntity attribute = await this.attributesService.GetByIdAsync(attributeId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, attribute, PolicyNames.CanApproveSuggestable);

            AttributeResponse response = await this.attributesService.ApproveAsync(attributeId, cancellationToken);
            return this.Ok(response);
        }

        [HttpPost("{attributeId}/reject")]
        public async Task<ActionResult<AttributeResponse>> RejectAsync(Guid attributeId, [FromBody] RejectRequest request, CancellationToken cancellationToken = default)
        {
            AttributeEntity attribute = await this.attributesService.GetByIdAsync(attributeId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, attribute, PolicyNames.CanApproveSuggestable);

            AttributeResponse response = await this.attributesService.RejectAsync(attributeId, request, cancellationToken);
            return this.Ok(response);
        }

        [HttpDelete("{attributeId}")]
        public async Task<ActionResult> DeleteAsync(Guid attributeId, CancellationToken cancellationToken = default)
        {
            AttributeEntity attribute = await this.attributesService.GetByIdAsync(attributeId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, attribute, PolicyNames.CanDeleteSuggestable);

            await this.attributesService.DeleteAsync(attributeId, cancellationToken);
            return this.NoContent();
        }
    }
}
