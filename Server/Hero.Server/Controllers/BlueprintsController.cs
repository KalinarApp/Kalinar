using AutoMapper;

using Hero.Server.Core.Models;
using Hero.Server.Core.Repositories;
using Hero.Server.Identity;
using Hero.Server.Identity.Attributes;
using Hero.Server.Messages.Requests;
using Hero.Server.Messages.Responses;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Hero.Server.Controllers
{
    [ApiController, Authorize, Route("api/[controller]")]
    public class BlueprintsController : HeroControllerBase
    {
        private readonly IBlueprintRepository repository;
        private readonly IUserRepository userRepository;
        private readonly IMapper mapper;

        public BlueprintsController(IBlueprintRepository repository, IUserRepository userRepository, IMapper mapper, ILogger<BlueprintsController> logger)
            : base(logger)
        {
            this.repository = repository;
            this.userRepository = userRepository;
            this.mapper = mapper;
        }

        [ApiExplorerSettings(IgnoreApi = true), NonAction, Route("/error")]
        public IActionResult HandleError() => this.HandleErrors();

        [HttpGet, IsGroupAdmin]
        public async Task<IActionResult> GetBlueprintsAsync(CancellationToken token)
        {
            await this.userRepository.IsOwner(this.HttpContext.User.GetUserId(), token);

            List<Blueprint> blueprints = await this.repository.GetAllBlueprintsAsync(token);

            return this.Ok(blueprints.Select(print => this.mapper.Map<BlueprintOverviewResponse>(print)));
        } 

        [HttpGet("{id}"), IsGroupAdmin]
        public async Task<IActionResult> GetBlueprintByIdAsync(Guid id, CancellationToken token)
        {
            await this.userRepository.IsOwner(this.HttpContext.User.GetUserId(), token);

            Blueprint? blueprint = await this.repository.GetBlueprintByIdAsync(id, token);
            if (null != blueprint)
            {
                return this.Ok(this.mapper.Map<BlueprintResponse>(blueprint));
            }

            return this.NotFound();
        }

        [HttpGet("{id}/load"), IsGroupAdmin]
        public async Task<IActionResult> LoadBlueprintByIdAsync(Guid id, CancellationToken token)
        {
            await this.userRepository.IsOwner(this.HttpContext.User.GetUserId(), token);

            Blueprint? blueprint = await this.repository.LoadBlueprintByIdAsync(id, token);
            if (null != blueprint)
            {
                return this.Ok(this.mapper.Map<BlueprintResponse>(blueprint));
            }

            return this.NotFound();
        }

        [HttpDelete("{id}"), IsGroupAdmin]
        public async Task<IActionResult> DeleteBlueprintAsync(Guid id, CancellationToken token)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId(), token);

            await this.repository.DeleteBlueprintAsync(id, token);

            return this.Ok();
        }

        [HttpPut("{id}"), IsGroupAdmin]
        public async Task<IActionResult> UpdateSkilltreeAsync(Guid id, [FromBody] BlueprintRequest request, CancellationToken token)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId(), token);

            Blueprint blueprint = this.mapper.Map<Blueprint>(request);
            await this.repository.UpdateBlueprintAsync(id, blueprint, token);

            return this.Ok();
        }

        [HttpPost, IsGroupAdmin]
        public async Task<IActionResult> CreateSkilltreeAsync([FromBody] BlueprintRequest request, CancellationToken token)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId(), token);

            Blueprint blueprint = this.mapper.Map<Blueprint>(request);
            await this.repository.CreateBlueprintAsync(blueprint, token);

            return this.Ok(this.mapper.Map<BlueprintResponse>(blueprint));
        }
    }
}
