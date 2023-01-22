using AutoMapper;

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

        [HttpGet("{name}"), IsGroupAdmin]
        public async Task<IActionResult> GetAbilityByIdAsync(string name, CancellationToken token)
        {
            Ability ability = await this.repository.GetAbilityByNameAsync(name, token);
            return this.Ok(this.mapper.Map<AbilityResponse>(ability));
        }

        [HttpGet, IsGroupAdmin]
        public async Task<IActionResult> GetAllAbilitiesAsync(CancellationToken token)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId(), token);
            List<Ability> abilities = await this.repository.GetAllAbilitiesAsync(token);

            return this.Ok(abilities.Select(ability => this.mapper.Map<AbilityResponse>(ability)).ToList());
        }

        [HttpDelete("{id}"), IsGroupAdmin]
        public async Task<IActionResult> DeleteAbilityAsync(Guid id, CancellationToken token)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId(), token);
            await this.repository.DeleteAbilityAsync(id, token);
            return this.Ok();
        }

        [HttpPut("{id}"), IsGroupAdmin]
        public async Task<IActionResult> UpdateAbilityAsync(Guid id, [FromBody] AbilityRequest request, CancellationToken token)
        {
            Ability ability = this.mapper.Map<Ability>(request);

            await userRepository.IsOwner(this.HttpContext.User.GetUserId(), token);

            await this.repository.UpdateAbilityAsync(id, ability, token);

            return this.Ok(this.mapper.Map<AbilityResponse>(ability));
        }

        [HttpPost, IsGroupAdmin]
        public async Task<IActionResult> CreateAbilityAsync([FromBody] AbilityRequest request, CancellationToken token)
        {
            Ability ability = this.mapper.Map<Ability>(request);

            await userRepository.IsOwner(HttpContext.User.GetUserId(), token);
            await this.repository.CreateAbilityAsync(ability, token);

            return this.Ok(this.mapper.Map<AbilityResponse>(ability));
        }
    }
}
