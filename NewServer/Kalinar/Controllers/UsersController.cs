using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Messages.Responses;

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

        public UsersController(IUserService userService)
        {
            this.userService = userService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<UserResponse>>> ListAsync([FromQuery] Guid? groupId = default, CancellationToken cancellationToken = default)
        {
            IEnumerable<UserEntity> users = await this.userService.ListAsync(cancellationToken);

            return this.Ok(users.Select(item => (UserResponse)item));
        }
    }
}
