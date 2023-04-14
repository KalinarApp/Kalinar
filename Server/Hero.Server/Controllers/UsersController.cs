using AutoMapper;

using FirebaseAdmin;
using FirebaseAdmin.Auth;

using Hero.Server.Core.Models;
using Hero.Server.Core.Repositories;
using Hero.Server.Identity;
using Hero.Server.Identity.Attributes;
using Hero.Server.Messages.Requests;
using Hero.Server.Messages.Responses;
using Hero.Server.Services;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hero.Server.Controllers
{
    [ApiController, Authorize, Route("api/[controller]")]
    public class UsersController : HeroControllerBase
    {
        private readonly IUserRepository repository;
        private readonly Notifications notifications;
        private readonly IMapper mapper;

        public UsersController(IUserRepository repository, Notifications notifications, IMapper mapper, ILogger<UsersController> logger)
            : base(logger)
        {
            this.repository = repository;
            this.notifications = notifications;
            this.mapper = mapper;
        }

        [ApiExplorerSettings(IgnoreApi = true), NonAction, Route("/error")]
        public IActionResult HandleError() => this.HandleErrors();

        private async Task<UserInfo> GetUserInfoByIdAsync(string id, CancellationToken cancellationToken = default)
        {
            if (FirebaseApp.DefaultInstance != null)
            {
                UserRecord user = await FirebaseAuth.DefaultInstance.GetUserAsync(id, cancellationToken);
                return new()
                {
                    Id = user.Uid,
                    Email = user.Email,
                    Username = user.DisplayName ?? user.Email.Split('@')[0],
                };
            }
            return new() { Id = id };
        }

        [HttpGet]
        public async Task<UserResponse> GetUser(CancellationToken cancellationToken)
        {
            UserInfo userInfo = await this.GetUserInfoByIdAsync(this.HttpContext.User.GetUserId(), cancellationToken); 
            User user = await this.repository.UpdateUserAsync(userInfo.Id, userInfo.Email, userInfo.Username, cancellationToken);

            return this.mapper.Map<UserResponse>(user); 
        }

        [HttpPost]
        public async Task CreateUserAsync(CancellationToken cancellationToken)
        {
            UserInfo userInfo = await this.GetUserInfoByIdAsync(this.HttpContext.User.GetUserId(), cancellationToken);
            await this.repository.UpdateUserAsync(userInfo.Id, userInfo.Email, userInfo.Username, cancellationToken);
        }

        [HttpPost("devices")]
        public async Task UpdateDeviceIds([FromBody] DeviceIdRequest request, CancellationToken cancellationToken = default)
        {
            string userId = this.HttpContext.User.GetUserId();
            List<string> deviceIds = await this.repository.GetDeviceIdsForUser(userId, cancellationToken);

            if (!deviceIds.Contains(request.DeviceId))
            {
                await this.repository.AddDeviceIdToUser(userId, request.DeviceId, cancellationToken);

                User? user = await this.repository.GetUserByIdAsync(userId, cancellationToken);
                notifications.SendWelcomeMessageAsync(request.DeviceId, user!.Username, cancellationToken);
            }
        }
    }
}
