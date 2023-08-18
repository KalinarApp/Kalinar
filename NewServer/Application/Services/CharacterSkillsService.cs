using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Services
{
    internal class CharacterSkillsService : ICharacterSkillService
    {
        private readonly ICharacterSkillsRepository characterSkillsRepository;
        private readonly ICharacterService characterService;
        private readonly ISkillService skillService;

        public CharacterSkillsService(ICharacterSkillsRepository characterSkillsRepository, ICharacterService characterService, ISkillService skillService)
        {
            this.characterSkillsRepository = characterSkillsRepository;
            this.characterService = characterService;
            this.skillService = skillService;
        }

        public async Task<IEnumerable<CharacterSkillEntity>> ListAsync(Guid characterId, CancellationToken cancellationToken = default)
        {
            return await this.characterSkillsRepository.ListByIdAsync(characterId, cancellationToken);
        }

        public async Task<CharacterSkillEntity?> FindByCharacterAndSkillId(Guid characterId, Guid skillId, CancellationToken cancellationToken = default)
        {
            return await this.characterSkillsRepository.FindByCharacterAndSkillIdAsync(characterId, skillId, cancellationToken);
        }   

        public async Task<CharacterSkillEntity> AddOrUpdateAsync(Guid characterId, Guid skillId, CharacterSkillRequest request, CancellationToken cancellationToken = default)
        {
            CharacterSkillEntity? existing = await this.FindByCharacterAndSkillId(characterId, skillId, cancellationToken);

            if (existing is null)
            {
                CharacterEntity character = await this.characterService.GetByIdAsync(characterId, cancellationToken);
                SkillEntity skill = await this.skillService.GetByIdAsync(skillId, cancellationToken);
                return await this.characterSkillsRepository.CreateAsync(new() { CharacterId = character.Id, Character = character, SkillId = skill.Id, Skill = skill, IsFavorite = request.IsFavorite }, cancellationToken);
            }
            else
            {
                existing.IsFavorite = request.IsFavorite;
                return await this.characterSkillsRepository.UpdateAsync(existing, cancellationToken);
            }
        }
    }
}
