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
    [Route("api/v{version:apiVersion}/skills"), ApiVersion("1.0")]
    public class SkillsController : ControllerBase
    {
        private readonly ISkillService skillsService;
        private readonly IGroupService groupService;
        private readonly IAuthorizationService authorizationService;

        public SkillsController(ISkillService skillsService, IGroupService groupService, IAuthorizationService authorizationService)
        {
            this.skillsService = skillsService;
            this.groupService = groupService;
            this.authorizationService = authorizationService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<SkillResponse>>> ListAsync([FromQuery] Guid? groupId, CancellationToken cancellationToken = default)
        {
            // ToDo: Implement an overall administrator role which than can view all skill.
            if (groupId is null) throw new ForbiddenAccessException("User is not allowed to view this resource");

            GroupEntity group = await this.groupService.GetByIdAsync(groupId.Value, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanListSuggestables);

            IEnumerable<SkillEntity> skills = await this.skillsService.ListAsync(groupId.Value, cancellationToken);

            return this.Ok(skills.Select(item => (SkillResponse)item));
        }

        [HttpGet("{skillId}")]
        public async Task<ActionResult<SkillResponse>> GetAsync(Guid skillId, CancellationToken cancellationToken = default)
        {
            SkillEntity skill = await this.skillsService.GetByIdAsync(skillId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, skill, PolicyNames.CanReadSuggestable);

            SkillResponse response = await this.skillsService.GetByIdAsync(skillId, cancellationToken);

            return this.Ok(response);
        }

        [HttpGet("{skillId}/attributes")]
        public async Task<ActionResult<IEnumerable<AttributeValueResponse>>> ListAttributesBySkillId(Guid skillId, CancellationToken cancellationToken = default)
        {
            SkillEntity skill = await this.skillsService.GetByIdAsync(skillId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, skill, PolicyNames.CanReadSuggestable);

            IEnumerable<SkillAttributeEntity> attributes = await this.skillsService.ListAttributesAsync(skillId, cancellationToken);

            return this.Ok(attributes.Select(item => (AttributeValueResponse)item));
        }

        [HttpPost]
        public async Task<ActionResult<SkillResponse>> CreateAsync([FromBody] SkillCreateRequest request, CancellationToken cancellationToken = default)
        {
            string userId = this.User.GetId();
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanCreateSuggestable);

            SkillResponse response = await this.skillsService.CreateAsync(userId, request, cancellationToken);

            return this.CreatedAtAction("Get", new { skillId = response.Id }, response);
        }

        [HttpPut("{skillId}")]
        public async Task<ActionResult<SkillResponse>> UpdateAsync(Guid skillId, [FromBody] SkillUpdateRequest request, CancellationToken cancellationToken = default)
        {
            SkillEntity skill = await this.skillsService.GetByIdAsync(skillId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, skill, PolicyNames.CanUpdateSuggestable);

            SkillResponse response = await this.skillsService.UpdateAsync(skillId, request, cancellationToken);
            return this.Ok(response);
        }

        [HttpPost("{skillId}/attributes")]
        public async Task<ActionResult> SetAttributesAsync(Guid skillId, [FromBody] IEnumerable<SkillAttributeRequest> request, CancellationToken cancellationToken = default)
        {
            SkillEntity skill = await this.skillsService.GetByIdAsync(skillId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, skill, PolicyNames.CanSetSkillAttributes);

            await this.skillsService.SetAttributesAsync(skillId, request, cancellationToken);
            return this.Ok();
        }

        [HttpPost("{skillId}/approve")]
        public async Task<ActionResult<AttributeResponse>> ApproveAsync(Guid skillId, CancellationToken cancellationToken = default)
        {
            SkillEntity skill = await this.skillsService.GetByIdAsync(skillId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, skill, PolicyNames.CanApproveSuggestable);

            SkillResponse response = await this.skillsService.ApproveAsync(skillId, cancellationToken);
            return this.Ok(response);
        }

        [HttpPost("{skillId}/reject")]
        public async Task<ActionResult<SkillResponse>> RejectAsync(Guid skillId, [FromBody] RejectRequest request, CancellationToken cancellationToken = default)
        {
            SkillEntity skill = await this.skillsService.GetByIdAsync(skillId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, skill, PolicyNames.CanApproveSuggestable);

            SkillResponse response = await this.skillsService.RejectAsync(skillId, request, cancellationToken);
            return this.Ok(response);
        }

        [HttpDelete("{skillId}")]
        public async Task<ActionResult> DeleteAsync(Guid skillId, CancellationToken cancellationToken = default)
        {
            SkillEntity skill = await this.skillsService.GetByIdAsync(skillId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, skill, PolicyNames.CanDeleteSuggestable);

            await this.skillsService.DeleteAsync(skillId, cancellationToken);
            return this.NoContent();
        }
    }
}
