using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    internal class RaceRepository : BaseGroupRepository<RaceEntity>, IRaceRepository
    {
        public RaceRepository(Context context) : base(context) { }

        public async Task<IEnumerable<RaceAttributeEntity>> ListAttributesAsync(Guid raceId, CancellationToken cancellationToken = default)
        {
            return await this.context.RaceAttributes.Where(item => item.RaceId == raceId).ToListAsync(cancellationToken: cancellationToken);
        }
    }
}
