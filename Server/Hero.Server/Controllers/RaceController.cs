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
        public async Task<RaceResponse> GetRaceByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            Race? race = await this.repository.GetRaceByIdAsync(id, cancellationToken);
            if (race == null)
            {
                throw new ObjectNotFoundException("No race found.");
            }

            return this.mapper.Map<RaceResponse>(race);
        }

        [HttpGet, IsGroupMember]
        public async Task<List<RaceResponse>> FilterRacesAsync([FromQuery] string? query, [FromQuery] SuggestionState[]? allowedStates, CancellationToken token)
        {
            List<Race> races = await this.repository.FilterRacesAsync(query, allowedStates ?? Array.Empty<SuggestionState>(), token);

            return races.Select(skill => this.mapper.Map<RaceResponse>(skill)).ToList();
        }

        [HttpDelete("{id}"), IsGroupMember]
        public async Task DeleteRaceAsync(Guid id, CancellationToken cancellationToken = default)
        {
            await this.repository.TryDeleteRaceAsync(id, this.HttpContext.User.GetUserId(), cancellationToken);
        }

        [HttpPut("{id}"), IsGroupMember]
        public async Task<RaceResponse> UpdateRaceAsync(Guid id, [FromBody] RaceRequest request, CancellationToken cancellationToken = default)
        {
            Race race = this.mapper.Map<Race>(request);
            await this.repository.TryUpdateRaceAsync(id, this.HttpContext.User.GetUserId(), race, cancellationToken);
            race = await this.repository.GetRaceByIdAsync(id, cancellationToken);

            return this.mapper.Map<RaceResponse>(race);
        }
         
        [HttpPost, IsGroupMember]
        public async Task<RaceResponse> CreateRaceAsync([FromBody] RaceRequest request, CancellationToken cancellationToken = default)
        {
            string userId = this.HttpContext.User.GetUserId();
            Race race = this.mapper.Map<Race>(request);

            race.CreatorId = userId;
            if (await userRepository.IsOwner(userId, cancellationToken))
            {
                race.State = SuggestionState.Approved;
                race.ApprovedAt = DateTime.Now;
            }

            await this.repository.CreateRaceAsync(race, cancellationToken);
            race = await this.repository.GetRaceByIdAsync(race.Id, cancellationToken);

            return this.mapper.Map<RaceResponse>(race);
        }

        [HttpPost("{id}/reject"), IsGroupAdmin]
        public async Task RejectRaceAsync(Guid id, [FromBody] SuggestionRejectionRequest request, CancellationToken cancellationToken)
        {
            await this.repository.RejectRaceAsync(id, request.Reason, cancellationToken);
        }
    }
}
