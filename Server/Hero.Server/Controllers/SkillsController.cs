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
using System.Data;
using Attribute = Hero.Server.Core.Models.Attribute;

namespace Hero.Server.Controllers
{
    [ApiController, Authorize, Route("api/[controller]")]
    public class SkillsController : HeroControllerBase
    {
        private readonly ISkillRepository repository;
        private readonly IUserRepository userRepository;
        private readonly IMapper mapper;

        public SkillsController(ISkillRepository repository, IUserRepository userRepository, IMapper mapper, ILogger<SkillsController> logger)
            : base(logger)
        {
            this.repository = repository;
            this.userRepository = userRepository;
            this.mapper = mapper;
        }

        [ApiExplorerSettings(IgnoreApi = true), NonAction, Route("/error")]
        public IActionResult HandleError() => this.HandleErrors();

        [HttpGet("{id}"), IsGroupMember]
        public async Task<SkillResponse> GetSkillByIdAsync(Guid id, CancellationToken token)
        {
            Skill? skill = await this.repository.GetSkillByIdAsync(id, token);

            if (skill == null)
            {
                throw new ObjectNotFoundException("No skill found.");
            }

            return this.mapper.Map<SkillResponse>(skill);
        }

        [HttpGet, IsGroupMember]
        public async Task<List<SkillResponse>> FilterSkillsAsync([FromQuery] string? query, [FromQuery] SuggestionState[]? allowedStates, CancellationToken token)
        {
            List<Skill> skills = await this.repository.FilterSkillsAsync(query, allowedStates ?? Array.Empty<SuggestionState>(), token);

            return skills.Select(skill => this.mapper.Map<SkillResponse>(skill)).ToList();
        }

        [HttpDelete("{id}"), IsGroupMember]
        public async Task DeleteSkillAsync(Guid id, CancellationToken token)
        {
            await this.repository.TryDeleteSkillAsync(id, this.HttpContext.User.GetUserId(), token);
        }

        [HttpPut("{id}"), IsGroupMember]
        public async Task<SkillResponse> UpdateSkillAsync(Guid id, [FromBody] SkillRequest request, CancellationToken token)
        {
            Skill skill = this.mapper.Map<Skill>(request);
            skill = await this.repository.TryUpdateSkillAsync(id, this.HttpContext.User.GetUserId(), skill, token);

            return this.mapper.Map<SkillResponse>(skill);
        }

        [HttpPost, IsGroupMember]
        public async Task<SkillResponse> CreateSkillAsync([FromBody] SkillRequest request, CancellationToken token)
        {
            string userId = this.HttpContext.User.GetUserId();
            Skill skill = this.mapper.Map<Skill>(request);

            skill.CreatorId = userId;
            if (await userRepository.IsOwner(userId, token))
            {
                skill.State = SuggestionState.Approved;
                skill.ApprovedAt = DateTime.Now;
            }

            await this.repository.CreateSkillAsync(skill, token);

            return this.mapper.Map<SkillResponse>(skill);
        }

        [HttpPost("{id}/reject"), IsGroupAdmin]
        public async Task RejectSkillAsync(Guid id, [FromBody] SuggestionRejectionRequest request, CancellationToken cancellationToken)
        {
            await this.repository.RejectSkillAsync(id, request.Reason, cancellationToken);
        }
    }
}
