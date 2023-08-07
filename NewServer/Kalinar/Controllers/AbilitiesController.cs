using Kalinar.Application.Contracts;
using Kalinar.Authorization;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Extensions;
using Kalinar.Messages.Responses;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Kalinar.Controllers
{
    [ApiController]
    [Authorize(Policy = PolicyNames.IsValidUser)]
    [Route("api/v{version:apiVersion}/abilities"), ApiVersion("1.0")]
    public class AbilitiesController : ControllerBase
    {
        private readonly IAbilityService abilityService;
        private readonly IAuthorizationService authorizationService;

        public AbilitiesController(IAbilityService abilityService, IAuthorizationService authorizationService)
        {
            this.abilityService = abilityService;
            this.authorizationService = authorizationService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<AbilityResponse>>> ListAsync([FromQuery]Guid? groupId, CancellationToken cancellationToken = default)
        {
            // ToDo: Implement an overall administrator role which than can view all abilities.
            if (groupId is null) throw new ForbiddenAccessException("User is not allowed to view this resource");

            await this.authorizationService.AuthorizeOrThrowAsync(this.User, PolicyNames.CanListSuggestables);

            IEnumerable<AbilityEntity> abilities = await this.abilityService.ListAsync(groupId.Value, cancellationToken);

            return this.Ok(abilities.Select(item => (AbilityResponse)item));
        }

        [HttpGet("{abilityId}")]
        public async Task<ActionResult<AbilityResponse>> GetByIdAsync(Guid abilityId, CancellationToken cancellationToken = default)
        {
            AbilityEntity ability = await this.abilityService.GetByIdAsync(abilityId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, ability, PolicyNames.CanReadSuggestable);

            AbilityResponse response = await this.abilityService.GetByIdAsync(abilityId, cancellationToken);

            return this.Ok(response);
        }
    }
}
