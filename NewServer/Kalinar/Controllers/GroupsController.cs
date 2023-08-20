using Kalinar.Application.Contracts;
using Kalinar.Authorization;
using Kalinar.Core.Entities;
using Kalinar.Extensions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Kalinar.Controllers
{
    [ApiController]
    [Authorize(Policy = PolicyNames.IsValidUser)]
    [Route("api/v{version:apiVersion}/groups"), ApiVersion("1.0")]
    public class GroupsController : ControllerBase
    {
        private readonly IGroupService groupService;
        private readonly IGroupMemberService memberService;
        private readonly IUserService userService;
        private readonly IAttributeService attributeService;
        private readonly IAuthorizationService authorizationService;

        public GroupsController(IGroupService groupService, IGroupMemberService memberService, IUserService userService, IAttributeService attributeService, IAuthorizationService authorizationService)
        {
            this.groupService = groupService;
            this.memberService = memberService;
            this.userService = userService;
            this.attributeService = attributeService;
            this.authorizationService = authorizationService;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<GroupResponse>> GetAsync(Guid id, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(id, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanReadGroups);

            return this.Ok((GroupResponse)group);
        }

        [HttpGet("{id}/users")]
        public async Task<ActionResult<IEnumerable<GroupMemberResponse>>> ListUsersAsync(Guid id, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(id, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanReadGroups);

            IEnumerable<GroupMemberEntity> groupMembers = await this.memberService.ListByGroupIdAsync(id, cancellationToken);

            return this.Ok(groupMembers.Select(item => (GroupMemberResponse)item));
        }

        [HttpPost]
        public async Task<ActionResult<GroupResponse>> CreateAsync([FromBody] GroupRequest request, CancellationToken cancellationToken = default)
        {
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, PolicyNames.CanCreateGroups);

            GroupResponse response = await this.groupService.CreateAsync(request, cancellationToken);
            await this.memberService.CreateAsync(this.User.GetId(), response.Id, Role.Owner, cancellationToken);
            await this.attributeService.CreateDefaultAttributesAsync(this.User.GetId(), response.Id, cancellationToken);

            return this.CreatedAtAction("Get", new { response.Id }, response);
        }

        [HttpPost("{groupId}/join")]
        public async Task<ActionResult> JoinAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            await this.memberService.CreateAsync(this.User.GetId(), groupId, Role.Member, cancellationToken);

            return this.Ok();
        }

        [HttpPost("{groupId}/leave")]
        public async Task<ActionResult> LeaveAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            await this.memberService.DeleteAsync(this.User.GetId(), groupId, cancellationToken);

            return this.Ok();
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<GroupResponse>> UpdateAsync(Guid id, [FromBody] GroupRequest request, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(id, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanUpdateGroups);

            GroupResponse response = await this.groupService.UpdateAsync(id, request, cancellationToken);

            return this.Ok(response);
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteAsync(Guid id, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(id, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanDeleteGroups);
            await this.groupService.DeleteAsync(id, cancellationToken);

            return this.NoContent();
        }
    }
}
