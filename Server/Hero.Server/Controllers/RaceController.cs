using AutoMapper;
using Hero.Server.Core.Models;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Repositories;
using Hero.Server.Identity;
using Hero.Server.Identity.Attributes;
using Hero.Server.Messages.Requests;
using Hero.Server.Messages.Responses;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hero.Server.Controllers
{
    [ApiController, Authorize, Route("api/[controller]")]
    public class RacesController : HeroControllerBase
    {
        private readonly IRaceRepository repository;
        private readonly IUserRepository userRepository;
        private readonly IMapper mapper;

        public RacesController(IRaceRepository repository, IUserRepository userRepository, IMapper mapper, ILogger<RacesController> logger) 
            : base(logger)
        {
            this.repository = repository;
            this.userRepository = userRepository;
            this.mapper = mapper;
        }

        [ApiExplorerSettings(IgnoreApi = true), NonAction, Route("/error")]
        public IActionResult HandleError() => this.HandleErrors();

        [HttpGet("{id}"), IsGroupMember]
        public async Task<IActionResult> GetRaceByIdAsync(Guid id)
        {
            Race? race = await this.repository.GetRaceByIdAsync(id);
            if (race != null)
            {
                return this.Ok(this.mapper.Map<RaceResponse>(race));
            }

            return this.NotFound();
        }

        [HttpGet, IsGroupMember]
        public async Task<IActionResult> GetAllRacesAsync()
        {
            List<Race> races = await this.repository.GetAllRacesAsync();

            return this.Ok(races.Select(race => this.mapper.Map<RaceResponse>(race)).ToList());
        }

        [HttpDelete("{id}"), IsGroupAdmin]
        public async Task<IActionResult> DeleteRaceAsync(Guid id)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId());

            await this.repository.DeleteRaceAsync(id);

            return this.Ok();
        }

        [HttpPut("{id}"), IsGroupAdmin]
        public async Task<IActionResult> UpdateRaceAsync(Guid id, [FromBody] RaceRequest request)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId());

            Race race = this.mapper.Map<Race>(request);
            await this.repository.UpdateRaceAsync(id, race);

            return this.Ok(this.mapper.Map<RaceResponse>(race));
        }

        [HttpPost, IsGroupAdmin]
        public async Task<IActionResult> CreateRaceAsync([FromBody] RaceRequest request)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId());

            Race race = this.mapper.Map<Race>(request);

            await this.repository.CreateRaceAsync(race);
            race = await this.repository.GetRaceByIdAsync(race.Id);

            return this.Ok(this.mapper.Map<RaceResponse>(race));
        }
    }
}
