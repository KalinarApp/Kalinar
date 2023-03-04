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
    public class AbilitiesController : HeroControllerBase
    {
        private readonly IAbilityRepository repository;
        private readonly IUserRepository userRepository;
        private readonly IMapper mapper;

        public AbilitiesController(IAbilityRepository repository, IUserRepository userRepository, IMapper mapper, ILogger<AbilitiesController> logger) 
            : base(logger)
        {
            this.repository = repository;
            this.userRepository = userRepository;
            this.mapper = mapper;
        }

        [ApiExplorerSettings(IgnoreApi = true), NonAction, Route("/error")]
        public IActionResult HandleError() => this.HandleErrors();

        [HttpGet("{name}"), IsGroupMember]
        public async Task<AbilityResponse> GetAbilityByIdAsync(string name, CancellationToken token)
        {
            Ability ability = await this.repository.GetAbilityByNameAsync(name, token);
            return this.mapper.Map<AbilityResponse>(ability);
        }

        [HttpGet, IsGroupMember]
        [ProducesErrorResponseType(typeof(HeroException))]
        public async Task<List<AbilityResponse>> GetAllAbilitiesAsync(CancellationToken token)
        {
            List<Ability> abilities = await this.repository.GetAllAbilitiesAsync(token);
            return abilities.Select(ability => this.mapper.Map<AbilityResponse>(ability)).ToList();
        }

        [HttpDelete("{id}"), IsGroupMember]
        public async Task DeleteAbilityAsync(Guid id, CancellationToken token)
        {
            await this.repository.TryDeleteAbilityAsync(id, this.HttpContext.User.GetUserId(), token);
        }

        [HttpPut("{id}"), IsGroupMember]
        public async Task<AbilityResponse> UpdateAbilityAsync(Guid id, [FromBody] AbilityRequest request, CancellationToken token)
        {
            Ability updated = this.mapper.Map<Ability>(request);
            await this.repository.TryUpdateAbilityAsync(id, this.HttpContext.User.GetUserId(), updated, token);

            return this.mapper.Map<AbilityResponse>(updated);
        }

        [HttpPost, IsGroupMember]
        public async Task<AbilityResponse> CreateAbilityAsync([FromBody] AbilityRequest request, CancellationToken token)
        {
            string userId = this.HttpContext.User.GetUserId();
            Ability ability = this.mapper.Map<Ability>(request);

            ability.CreatorId = userId;
            if (!await userRepository.IsOwner(userId, token))
            {
                ability.State = SuggestionState.Pending;
            }

            await this.repository.CreateAbilityAsync(ability, token);

            return this.mapper.Map<AbilityResponse>(ability);
        }

        [HttpPost("{id}/approve"), IsGroupAdmin]
        public async Task ApproveAbilityAsync(Guid id, CancellationToken cancellationToken)
        {
            await this.repository.ApproveAbility(id, cancellationToken);
        }

        [HttpPost("{id}/reject"), IsGroupAdmin]
        public async Task RejectAbilityAsync(Guid id, [FromBody] SuggestionRejectionRequest request, CancellationToken cancellationToken)
        {
            await this.repository.RejectAbility(id, request.Reason, cancellationToken);
        }
    }
}
