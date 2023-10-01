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
    [Route("api/v{version:apiVersion}/users"), ApiVersion("1.0")]
    public class UsersController : ControllerBase
    {
        private readonly IUserService userService;
        private readonly IGroupMemberService groupMemberService;
        private readonly IAuthorizationService authorizationService;

        public UsersController(IUserService userService, IGroupMemberService groupMemberService, IAuthorizationService authorizationService)
        {
            this.userService = userService;
            this.groupMemberService = groupMemberService;
            this.authorizationService = authorizationService;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<UserResponse>> GetAsync(string id, CancellationToken cancellationToken = default)
        {
            UserEntity loggedInUser = await this.userService.GetByIdAsync(this.User.GetId(), cancellationToken);

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, loggedInUser, PolicyNames.CanListUsers);

            UserEntity user = await this.userService.GetByIdAsync(id, cancellationToken);

            return this.Ok((UserResponse)user);
        }

        [HttpGet("{id}/groups")]
        public async Task<ActionResult<IEnumerable<GroupMemberResponse>>> GetGroupsAsync(string id, CancellationToken cancellationToken = default)
        {
            UserEntity loggedInUser = await this.userService.GetByIdAsync(this.User.GetId(), cancellationToken);

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, loggedInUser, PolicyNames.CanListUsers);

            IEnumerable<GroupMemberEntity> groups = await this.groupMemberService.ListByUserIdAsync(id, cancellationToken);

            return this.Ok(groups.Select(item => (GroupMemberResponse)item));
        }

        [HttpPost("register")]
        public async Task<ActionResult<UserResponse>> RegisterAsync([FromBody] UserCreateRequest request, CancellationToken cancellationToken = default)
        {
            UserResponse response = await this.userService.CreateAsync(this.User.GetId(), request, cancellationToken);

            return this.CreatedAtAction("Get", new { id = response.Id }, response);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<UserResponse>> UpdateAsync(string id, [FromBody] UserUpdateRequest request, CancellationToken cancellationToken = default)
        {
            UserEntity user = await this.userService.GetByIdAsync(this.User.GetId(), cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, user, PolicyNames.CanUpdateUsers);

            return this.Ok((UserResponse)await this.userService.UpdateAsync(id, request, cancellationToken));
        }

        [HttpPost("{id}/devices")]
        public async Task<ActionResult> AddDeviceIdAsync(string id, [FromBody] UserDeviceIdRequest request, CancellationToken cancellationToken = default)
        {
            UserEntity user = await this.userService.GetByIdAsync(this.User.GetId(), cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, user, PolicyNames.CanUpdateUsers);
            await this.userService.AddDeviceIdAsync(id, request.DeviceId, cancellationToken);

            return this.Ok();
        }

        [HttpDelete("{id}/devices/{deviceId}")]
        public async Task<ActionResult> RemoveDeviceIdAsync(string id, string deviceId, CancellationToken cancellationToken = default)
        {
            UserEntity user = await this.userService.GetByIdAsync(this.User.GetId(), cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, user, PolicyNames.CanUpdateUsers);
            await this.userService.RemoveDeviceIdAsync(id, deviceId, cancellationToken);

            return this.NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteAsync(string id, CancellationToken cancellationToken = default)
        {
            UserEntity user = await this.userService.GetByIdAsync(id, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, user, PolicyNames.CanDeleteUsers);
            await this.userService.DeleteAsync(id, cancellationToken);

            return this.NoContent();
        }
    }
}
