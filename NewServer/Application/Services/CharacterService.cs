using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Services
{
    internal class CharacterService : ICharacterService
    {
        private readonly ICharacterRepository characterRepository;
        private readonly IGroupService groupService;
        private readonly IRaceService raceService;

        public CharacterService(ICharacterRepository characterRepository, IGroupService groupService, IRaceService raceService)
        {
            this.characterRepository = characterRepository;
            this.groupService = groupService;
            this.raceService = raceService;
        }

        public Task<IEnumerable<CharacterEntity>> ListAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return this.characterRepository.ListByGroupIdAsync(groupId, cancellationToken);
        }

        public async Task<IEnumerable<SkillEntity>> ListUnlockedSkillsByIdAsync(Guid characterId, CancellationToken cancellationToken = default)
        {
            IEnumerable<CharacterSkillEntity> characterSkills = await this.characterRepository.ListCharacterSkillsByIdAsync(characterId, cancellationToken);
            return characterSkills.Select(item => item.Skill);
        }

        public async Task<CharacterEntity> GetByIdAsync(Guid characterId, CancellationToken cancellationToken = default)
        {
            return await this.characterRepository.FindByIdAsync(characterId, cancellationToken) ?? throw new CharacterNotFoundException(characterId);
        }

        public async Task<CharacterEntity> CreateAsync(string userId, CharacterCreateRequest request, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);
            RaceEntity race = await this.raceService.GetByIdAsync(request.RaceId, cancellationToken);

            if (race.State != SuggestionState.Approved) throw new RaceNotApprovedException(race.Name);

            CharacterEntity character = new()
            {
                Id = Guid.NewGuid(),
                UserId = userId,
                GroupId = request.GroupId,
                Group = group,
                RaceId = request.RaceId,
                Race = race,
                Name = request.Name,
                Description = request.Description,
                Age = request.Age,
                IconUrl = request.IconUrl,
                Inventory = request.Inventory,
                Religion = request.Religion,
                Relationship = request.Relationship,
                Notes = request.Notes,
                Profession = request.Profession,
                Skilltrees = new List<SkilltreeEntity>(),
                CreatedAt = DateTime.UtcNow,
            };

            return await this.characterRepository.CreateAsync(character, cancellationToken);
        }

        public async Task<CharacterEntity> UpdateAsync(Guid id, CharacterUpdateRequest request, CancellationToken cancellationToken = default)
        {
            CharacterEntity character = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            character.Name = request.Name;
            character.Description = request.Description;
            character.IconUrl = request.IconUrl;
            character.Age = request.Age;
            character.Religion = request.Religion;
            character.Relationship = request.Relationship;
            character.Notes = request.Notes;
            character.Profession = request.Profession;
            character.Inventory = request.Inventory;
            character.ModifiedAt = DateTime.UtcNow; 

            return await this.characterRepository.UpdateAsync(character, cancellationToken);
        }

        public async Task DeleteAsync(Guid id, CancellationToken cancellationToken = default)
        {
            CharacterEntity character = await this.GetByIdAsync(id, cancellationToken: cancellationToken);
            await this.characterRepository.DeleteAsync(character, cancellationToken);
        }
    }
}
