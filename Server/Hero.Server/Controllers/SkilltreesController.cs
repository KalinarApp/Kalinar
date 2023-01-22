using AutoMapper;

using Hero.Server.Core.Exceptions;
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
    public class SkilltreesController : HeroControllerBase
    {
        private readonly ISkilltreeRepository repository;
        private readonly IUserRepository userRepository;
        private readonly IMapper mapper;

        public SkilltreesController(ISkilltreeRepository repository, IUserRepository userRepository, IMapper mapper, ILogger<SkilltreesController> logger)
            : base(logger)
        {
            this.repository = repository;
            this.userRepository = userRepository;
            this.mapper = mapper;
        }

        [Route("/error"), ApiExplorerSettings(IgnoreApi = true)]
        public IActionResult HandleError() => this.HandleErrors();

        [HttpGet("{id}"), IsGroupMember]
        public async Task<IActionResult> GetSkilltreeByIdAsync(Guid id)
        {
            Skilltree? tree = await this.repository.GetSkilltreeByIdAsync(id);
            if (tree != null)
            {
                return this.Ok(this.mapper.Map<SkilltreeResponse>(tree));
            }

            return this.NotFound();
        }

        [HttpGet, IsGroupMember]
        public async Task<IActionResult> GetSkilltreeOverviewsAsync(CancellationToken token)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId(), token);

            List<Skilltree> trees = await this.repository.FilterSkilltrees(null, token);

            return this.Ok(trees.Select(skilltrees => this.mapper.Map<SkilltreeOverviewResponse>(skilltrees)).ToList());
        }

        [HttpDelete("{id}"), IsGroupAdmin]
        public async Task<IActionResult> DeleteSkilltreeAsync(Guid id)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId());

            await this.repository.DeleteSkilltreeAsync(id);

            return this.Ok();
        }

        [HttpPut("{id}"), IsGroupAdmin]
        public async Task<IActionResult> UpdateSkilltreeAsync(Guid id, [FromBody] SkilltreeRequest request)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId());

            Skilltree tree = this.mapper.Map<Skilltree>(request);
            await this.repository.UpdateSkilltreeAsync(id, tree);

            return this.Ok();
        }

        [HttpPost, IsGroupAdmin]
        public async Task<IActionResult> CreateSkilltreeAsync([FromBody] SkilltreeRequest request)
        {
            Skilltree tree = this.mapper.Map<Skilltree>(request);
            await this.repository.CreateSkilltreeAsync(tree);

            return this.Ok(this.mapper.Map<SkilltreeResponse>(tree));
        }

        [HttpPost("{skilltreeId}/nodes/{nodeId}/unlock"), IsGroupMember]
        public async Task<IActionResult> UnlockNodeAsync(Guid skilltreeId, Guid nodeId, CancellationToken token)
        {
            await this.repository.EnsureIsOwner(skilltreeId, this.HttpContext.User.GetUserId(), token);
            await this.repository.UnlockNode(skilltreeId, nodeId, token);
            return this.Ok();
        }

        [HttpPost("{skilltreeId}/nodes/{nodeId}/reset"), IsGroupMember]
        public async Task<IActionResult> ResetNodeAsync(Guid skilltreeId, Guid nodeId, CancellationToken token)
        {
            await this.repository.EnsureIsOwner(skilltreeId, this.HttpContext.User.GetUserId(), token);
            await this.repository.ResetNode(skilltreeId, nodeId, token);
            return this.Ok();
        }

        [HttpPost("{id}/reset"), IsGroupMember]
        public async Task<IActionResult> ResetSkilltreeAsync(Guid id, CancellationToken token)
        {
            await this.repository.ResetSkilltreeAsync(id, token);
            return this.Ok();
        }

        [HttpPost("{id}/active"), IsGroupAdmin]
        public async Task<IActionResult> SwitchActiveStateForSkilltreeAsync(Guid id, [FromBody] ChangeStateRequest request, CancellationToken cancellationToken)
        {
            await this.repository.SwitchSkilltreeActiveStateAsync(id, request.State, cancellationToken);
            return this.Ok();
        }

        [HttpGet("{id}/skillpoints"), IsGroupMember]
        public async Task<IActionResult> GetSkillpointsBySkilltreeIdAsync(Guid id, CancellationToken token)
        {
            int currentSkillpoints= await this.repository.GetSkillpoints(id, token);
            Skilltree? skilltree = await this.repository.GetSkilltreeByIdAsync(id, token);

            return this.Ok(new { CurrentSkillpoints = currentSkillpoints, MaxSkillpoints = skilltree!.Points });
        }
    }
}
