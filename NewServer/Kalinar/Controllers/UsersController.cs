using Kalinar.Application.Contracts;
using Kalinar.Application.Messages.Requests;
using Kalinar.Application.Messages.Responses;
using Kalinar.Authorization;
using Kalinar.Core.Entities;
using Kalinar.Extensions;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

using System.ComponentModel.DataAnnotations;

namespace Kalinar.Controllers
{
    [ApiController]
    [Authorize]
    [Route("api/v{version:apiVersion}/users"), ApiVersion("1.0")]
    public class UsersController : ControllerBase
    {
        private readonly IUserService userService;
        private readonly IAuthorizationService authorizationService;

        public UsersController(IUserService userService, IAuthorizationService authorizationService)
        {
            this.userService = userService;
            this.authorizationService = authorizationService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<UserResponse>>> ListAsync([FromQuery] Guid? groupId = default, CancellationToken cancellationToken = default)
        {
            UserEntity loggedInUser = await this.userService.GetByIdAsync(this.User.GetId(), cancellationToken);

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, loggedInUser, PolicyNames.CanListUsers);

            IEnumerable<UserEntity> users = await this.userService.ListAsync(cancellationToken);

            return this.Ok(users.Select(item => (UserResponse)item));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<UserResponse>> GetByIdAsync(string id, CancellationToken cancellationToken = default)
        {
            UserEntity loggedInUser = await this.userService.GetByIdAsync(this.User.GetId(), cancellationToken);

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, loggedInUser, PolicyNames.CanListUsers);

            UserEntity user = await this.userService.GetByIdAsync(id, cancellationToken);

            return this.Ok((UserResponse)user);
        }

        [HttpPost("register")]
        public async Task<ActionResult<UserResponse>> RegisterAsync([FromBody] RegisterUserRequest request, CancellationToken cancellationToken = default)
        {
            UserEntity user = await this.userService.CreateAsync(this.User.GetId(), request, cancellationToken);

            return this.Ok((UserResponse)user);
        }
    }
}
