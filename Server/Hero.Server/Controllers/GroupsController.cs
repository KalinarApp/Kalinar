﻿using AutoMapper;
using FirebaseAdmin;
using FirebaseAdmin.Auth;

using Hero.Server.Core.Logging;
using Hero.Server.Core.Models;
using Hero.Server.Core.Repositories;
using Hero.Server.Identity;
using Hero.Server.Identity.Attributes;
using Hero.Server.Messages.Requests;
using Hero.Server.Messages.Responses;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hero.Server.Controllers
{
    [ApiController, Authorize, Route("api/[controller]")]
    public class GroupsController : HeroControllerBase
    {
        private readonly IGroupRepository repository;
        private readonly IMapper mapper;

        public GroupsController(IGroupRepository repository, IMapper mapper, ILogger<GroupsController> logger)
            : base(logger)
        {
            this.repository = repository;
            this.mapper = mapper;
        }

        [ApiExplorerSettings(IgnoreApi = true), NonAction, Route("/error")]
        public IActionResult HandleError() => this.HandleErrors();

        [HttpGet, IsGroupAdmin]
        public async Task<IActionResult> GetGroupAdminInfo(CancellationToken token)
        {
            Group group = await this.repository.GetGroupByOwnerId(this.HttpContext.User.GetUserId(), token);

            return this.Ok(new { Id = group.Id, OwnerId = group.OwnerId, Name = group.Name, Code = $"https://kalinar.app/invite?code={group.InviteCode}" });
        }

        [HttpGet("{code}")]
        public async Task<IActionResult> GetGroupInfo(string code, CancellationToken token)
        {
            Group group = await this.repository.GetGroupByInviteCode(code, token);

            return this.Ok(new { Id = group.Id, Name = group.Name, Owner = group.Owner.Username, Description = group.Description });
        }
        
        [HttpGet("users"), IsGroupAdmin]
        public async Task<List<UserResponse>> GetAllUsersInGroup(CancellationToken token)
        {
            Group? group = await this.repository.GetGroupByOwnerId(this.HttpContext.User.GetUserId(), token);
            return group.Members.Select(item => this.mapper.Map<UserResponse>(item)).ToList();
        }

        [HttpPost]
        public async Task<IActionResult> CreateGroup([FromBody]GroupRequest request, CancellationToken token)
        {
                await this.repository.CreateGroup(request.Name, request.Description, this.HttpContext.User.GetUserId(), token);
                this.logger.LogGroupCreatedSuccessfully(request.Name);

                return this.Ok();
        }


        [HttpPost("{id}/join/{code}")]
        public async Task<IActionResult> JoinGroup(Guid id, string code, CancellationToken token)
        {
            await this.repository.JoinGroup(id, this.HttpContext.User.GetUserId(), code, token);

            UserRecord user = await FirebaseAuth.DefaultInstance.GetUserAsync(this.User.GetUserId(), token);
            Dictionary<string, object> claims = new(user.CustomClaims);

            List<Guid> groups = user.CustomClaims.GetValueOrDefault("groups") as List<Guid> ?? new List<Guid>();
            groups.Add(id);

            claims["groups"] = groups.Distinct();

            await FirebaseAuth.DefaultInstance.SetCustomUserClaimsAsync(this.User.GetUserId(), claims, token);

            return this.Ok();
        }

        [HttpPost("leave")]
        public async Task<IActionResult> LeaveGroup(CancellationToken token)
        {
            await this.repository.LeaveGroup(this.HttpContext.User.GetUserId(), token);

            UserRecord user = await FirebaseAuth.DefaultInstance.GetUserAsync(this.User.GetUserId(), token);
            Dictionary<string, object> claims = new(user.CustomClaims);

            List<Guid> groups = user.CustomClaims.GetValueOrDefault("groups") as List<Guid> ?? new List<Guid>();
            groups.Remove(groups.First());

            claims["groups"] = groups.Distinct();

            await FirebaseAuth.DefaultInstance.SetCustomUserClaimsAsync(this.User.GetUserId(), claims, token);

            return this.Ok(); 
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteGroup(Guid id, CancellationToken token)
        {
            await this.repository.DeleteGroup(id, this.HttpContext.User.GetUserId(), token);

            return this.Ok();
        }
    }
}
