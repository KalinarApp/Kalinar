using AutoMapper;

using FirebaseAdmin.Auth;

using Hero.Server.Core.Models;
using Hero.Server.Core.Repositories;
using Hero.Server.Identity;
using Hero.Server.Identity.Attributes;
using Hero.Server.Messages.Responses;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hero.Server.Controllers
{
    [ApiController, Authorize, Route("api/[controller]")]
    public class UsersController : HeroControllerBase
    {
        private readonly IUserRepository repository;
        private readonly IMapper mapper;

        public UsersController(IUserRepository repository, IMapper mapper, ILogger<UsersController> logger)
            : base(logger)
        {
            this.repository = repository;
            this.mapper = mapper;
        }

        [ApiExplorerSettings(IgnoreApi = true), NonAction, Route("/error")]
        public IActionResult HandleError() => this.HandleErrors();

        [HttpGet()]
        public async Task<IActionResult> GetUser()
        {
            User? user = await this.repository.GetUserByIdAsync(this.HttpContext.User.GetUserId());
                
            if (null == user)
            {
                user = await repository.CreateUserIfNotExistAsync(this.HttpContext.User.GetUserId());
            }

            return this.Ok(new {Id = user.Id, Group = this.mapper.Map<GroupResponse>(user.OwnedGroup ?? user.Group)}); 
        }

        [HttpPost]
        public async Task<IActionResult> CreateUser()
        {
            await repository.CreateUserIfNotExistAsync(this.HttpContext.User.GetUserId());
            return this.Ok(); 
        }
    }
}
