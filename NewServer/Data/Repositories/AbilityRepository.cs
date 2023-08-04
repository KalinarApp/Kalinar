using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    internal class AbilityRepository : BaseGroupRepository<AbilityEntity>, IAbilityRepository
    {
        public AbilityRepository(Context context) : base(context) { }

        public async Task<IEnumerable<string>> ListTagsAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await context.Abilities
                .Where(item => item.GroupId == groupId)
                .SelectMany(item => item.Tags)
                .Distinct()
                .ToListAsync(cancellationToken);
        }
    }
}
