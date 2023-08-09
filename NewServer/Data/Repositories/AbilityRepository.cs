using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    internal class AbilityRepository : BaseGroupRepository<AbilityEntity>, IAbilityRepository
    {
        public AbilityRepository(Context context) : base(context) { }

        public override async Task<IEnumerable<AbilityEntity>> ListAsync(CancellationToken cancellationToken = default)
        {
            return await context.Abilities.Include(item => item.Tags).ToListAsync(cancellationToken);
        }

        public override async Task<IEnumerable<AbilityEntity>> ListByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.context.Abilities.Include(item => item.Tags).Where(item => item.GroupId == groupId).ToListAsync(cancellationToken);
        }

        public override async Task<AbilityEntity?> FindByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await context.Abilities.Include(item => item.Tags).FirstOrDefaultAsync(item => item.Id == id, cancellationToken);
        }

        public async Task<IEnumerable<AbilityTagEntity>> ListTagsAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await context.Abilities
                .Include(item => item.Tags)
                .Where(item => item.GroupId == groupId)
                .SelectMany(item => item.Tags)
                .Distinct()
                .ToListAsync(cancellationToken);
        }
    }
}
