using Kalinar.Application.Contracts;
using Kalinar.Authorization;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Core.Views;
using Kalinar.Extensions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Kalinar.Controllers
{
    [ApiController]
    [Authorize(Policy = PolicyNames.IsValidUser)]
    [Route("api/v{version:apiVersion}/characters"), ApiVersion("1.0")]
    public class CharactersController : ControllerBase
    {
        private readonly ICharacterService characterService;
        private readonly ICharacterSkillService characterSkillService;
        private readonly ISkilltreeService skilltreeService;
        private readonly IGroupService groupService;
        private readonly IAuthorizationService authorizationService;

        public CharactersController(ICharacterService characterService, ICharacterSkillService characterSkillService, ISkilltreeService skilltreeService, IGroupService groupService, IAuthorizationService authorizationService)
        {
            this.characterService = characterService;
            this.characterSkillService = characterSkillService;
            this.skilltreeService = skilltreeService;
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

        [HttpGet("{characterId}/attributes")]
        public async Task<ActionResult<IEnumerable<AttributeValueResponse>>> ListAttributesByIdAsync(Guid characterId, CancellationToken cancellationToken = default)
        {
            CharacterEntity character = await this.characterService.GetByIdAsync(characterId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, character, PolicyNames.CanReadCharacter);

            IEnumerable<CharacterAttributeView> attributes = await this.characterService.ListAttributesByIdAsync(characterId, cancellationToken);
            return this.Ok(attributes.Select(item => (AttributeValueResponse)item));
        }

        [HttpGet("{characterId}/skilltrees")]
        public async Task<ActionResult<IEnumerable<SkilltreeResponse>>> ListSkilltreesByIdAsync(Guid characterId, CancellationToken cancellationToken = default)
        {
            CharacterEntity character = await this.characterService.GetByIdAsync(characterId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, character, PolicyNames.CanReadCharacter);

            IEnumerable<SkilltreeEntity> skilltrees = await this.skilltreeService.ListByCharacterIdAsync(characterId, cancellationToken);
            return this.Ok(skilltrees.Select(item => (SkilltreeResponse)item));
        }

        [HttpGet("{characterId}/skills")]
        public async Task<ActionResult<IEnumerable<SkillResponse>>> ListUnlockedSkillsByIdAsync(Guid characterId, [FromQuery] bool? isFavorite = default, CancellationToken cancellationToken = default)
        {
            CharacterEntity character = await this.characterService.GetByIdAsync(characterId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, character, PolicyNames.CanReadCharacter);

            IEnumerable<SkillEntity> skills = await this.characterService.ListUnlockedSkillsByIdAsync(characterId, cancellationToken);
            IEnumerable<CharacterSkillEntity> favorites = await this.characterSkillService.ListAsync(characterId, cancellationToken);
            IEnumerable<CharacterSkillEntity> characterSkills = 
                isFavorite.HasValue 
                    ? isFavorite.Value 
                        ? favorites.Where(item => item.IsFavorite)
                        : skills.Where(skill => !favorites.Any(item => item.SkillId == skill.Id) || favorites.Any(item => item.SkillId == skill.Id && !item.IsFavorite)).Select(skill => new CharacterSkillEntity() { CharacterId = characterId, Character = character, SkillId = skill.Id, Skill = skill, IsFavorite = false})
                    : skills.Select(skill => new CharacterSkillEntity() { CharacterId = characterId, Character = character, SkillId = skill.Id, Skill = skill, IsFavorite = favorites.FirstOrDefault(item => item.SkillId == skill.Id)?.IsFavorite ?? false });

            return this.Ok(characterSkills.Select(item => (CharacterSkillResponse)item));
        }

        [HttpPost]
        public async Task<ActionResult<CharacterResponse>> CreateAsync([FromBody] CharacterCreateRequest request, CancellationToken cancellationToken = default)
        {
            string userId = this.User.GetId();
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, group, PolicyNames.CanCreateCharacter);

            CharacterEntity character = await this.characterService.CreateAsync(userId, request, cancellationToken);
            return this.CreatedAtAction("Get", new { characterId = character.Id }, (CharacterResponse)character);
        }

        [HttpPost("{characterId}/skills/{skillId}")]
        public async Task AddOrUpdateCharacterSkillAsync(Guid characterId, Guid skillId, [FromBody] CharacterSkillRequest request, CancellationToken cancellationToken = default)
        {
            CharacterEntity character = await this.characterService.GetByIdAsync(characterId, cancellationToken);
            await this.authorizationService.AuthorizeOrThrowAsync(this.User, character, PolicyNames.CanUpdateCharacter);

            await this.characterSkillService.AddOrUpdateAsync(characterId, skillId, request, cancellationToken);    
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
