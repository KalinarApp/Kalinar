using Kalinar.Application.Contracts;
using Kalinar.Authorization;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Extensions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Kalinar.Controllers
{
    [ApiController]
    [Authorize(Policy = PolicyNames.IsValidUser)]
    [Route("api/v{version:apiVersion}/characters"), ApiVersion("1.0")]
    public class CharactersController : ControllerBase
    {
        private readonly ICharacterService characterService;
        private readonly IGroupService groupService;
        private readonly IAuthorizationService authorizationService;

        public CharactersController(ICharacterService characterService, IGroupService groupService, IAuthorizationService authorizationService)
        {
            this.characterService = characterService;
            this.groupService = groupService;
            this.authorizationService = authorizationService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CharacterResponse>>> ListAsync([FromQuery] Guid? groupId, CancellationToken cancellationToken = default)
        {
            // ToDo: Implement an overall administrator role which than can view all characters.
            if (groupId is null) throw new ForbiddenAccessException("User is not allowed to view this resource");
            GroupEntity group = await this.groupService.GetByIdAsync(groupId.Value, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanListCharacters);

            IEnumerable<CharacterEntity> characters = await this.characterService.ListAsync(groupId.Value, cancellationToken);
            return this.Ok(characters.Select(item => (CharacterResponse)item));
        }

        [HttpGet("{characterId}")]
        public async Task<ActionResult<CharacterResponse>> GetAsync(Guid characterId, CancellationToken cancellationToken = default)
        {
            CharacterEntity character = await this.characterService.GetByIdAsync(characterId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, character, PolicyNames.CanReadCharacter);

            return this.Ok((CharacterResponse)character);
        }

        // ToDo: Add Endpoints for unlocked skills, unlocked attributes and skilltrees

        [HttpPost]
        public async Task<ActionResult<CharacterResponse>> CreateAsync([FromBody] CharacterCreateRequest request, CancellationToken cancellationToken = default)
        {
            string userId = this.User.GetId();
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanCreateCharacter);

            CharacterEntity character = await this.characterService.CreateAsync(userId, request, cancellationToken);
            return this.CreatedAtAction("Get", new { characterId = character.Id }, (CharacterResponse)character);
        }

        [HttpPut("{characterId}")]
        public async Task<ActionResult<CharacterResponse>> UpdateAsync(Guid characterId, [FromBody] CharacterUpdateRequest request, CancellationToken cancellationToken = default)
        {
            CharacterEntity character = await this.characterService.GetByIdAsync(characterId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, character, PolicyNames.CanUpdateCharacter);

            CharacterResponse response = await this.characterService.UpdateAsync(characterId, request, cancellationToken);
            return this.Ok(response);

        }

        [HttpDelete("{characterId}")]
        public async Task<ActionResult> DeleteAsync(Guid characterId, CancellationToken cancellationToken = default)
        {
            CharacterEntity character = await this.characterService.GetByIdAsync(characterId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, character, PolicyNames.CanDeleteCharacter);

            await this.characterService.DeleteAsync(characterId, cancellationToken);
            return this.NoContent();
        }
    }
}
