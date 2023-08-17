using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    public class CharacterRepository : BaseGroupRepository<CharacterEntity>, ICharacterRepository
    {
        public CharacterRepository(Context context) : base(context) { }

        public override async Task<IEnumerable<CharacterEntity>> ListAsync(CancellationToken cancellationToken = default)
        {
            return await context.Characters.Include(item => item.Race).ToListAsync(cancellationToken);
        }

        public override async Task<IEnumerable<CharacterEntity>> ListByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.context.Characters.Where(item => item.GroupId == groupId).Include(item => item.Race).ToListAsync(cancellationToken);
        }

        public async Task<IEnumerable<CharacterSkillEntity>> ListCharacterSkillsByIdAsync(Guid characterId, CancellationToken cancellationToken = default)
        {
            return await this.context.CharacterSkills.Where(item => item.CharacterId == characterId).Include(item => item.Skill).ToListAsync(cancellationToken);
        }

        public override async Task<CharacterEntity?> FindByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await context.Characters.Include(item => item.Race).FirstOrDefaultAsync(item => item.Id == id, cancellationToken);
        }
    }
}
