using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    internal class SkillRepository : BaseGroupRepository<SkillEntity>, ISkillRepository
    {
        public SkillRepository(Context context) : base(context) { }

        public async Task<IEnumerable<SkillAttributeEntity>> ListAttributesAsync(Guid skillId, CancellationToken cancellationToken = default)
        {
            return await this.context.SkillAttributes.Where(item => item.SkillId == skillId).ToListAsync(cancellationToken: cancellationToken);
        }
    }
}
