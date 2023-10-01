using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    internal class CharacterSkillsRepository : ICharacterSkillsRepository
    {
        private readonly Context context;

        public CharacterSkillsRepository(Context context)
        {
            this.context = context;
        }

        public async Task<IEnumerable<CharacterSkillEntity>> ListByIdAsync(Guid characterId, CancellationToken cancellationToken = default)
        {
            return await this.context.CharacterSkills.Include(item => item.Skill).Where(item => item.CharacterId == characterId).ToListAsync(cancellationToken);
        }

        public async Task<CharacterSkillEntity?> FindByCharacterAndSkillIdAsync(Guid characterId, Guid skillId, CancellationToken cancellationToken)
        {
            return await this.context.CharacterSkills.Include(item => item.Skill).FirstOrDefaultAsync(item => item.CharacterId == characterId && item.SkillId == skillId, cancellationToken);

        }

        public async Task<CharacterSkillEntity> CreateAsync(CharacterSkillEntity characterSkill, CancellationToken cancellationToken = default)
        {
            await this.context.CharacterSkills.AddAsync(characterSkill, cancellationToken);
            await this.context.SaveChangesAsync(cancellationToken);

            return characterSkill;
        }

        public async Task<CharacterSkillEntity> UpdateAsync(CharacterSkillEntity characterSkill, CancellationToken cancellationToken = default)
        {
            this.context.CharacterSkills.Update(characterSkill);
            await this.context.SaveChangesAsync(cancellationToken);

            return characterSkill;
        }

        public async Task DeleteAsync(CharacterSkillEntity characterSkill, CancellationToken cancellationToken = default)
        {
            this.context.CharacterSkills.Remove(characterSkill);
            await this.context.SaveChangesAsync(cancellationToken);
        }

    }
}
