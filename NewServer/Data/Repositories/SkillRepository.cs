﻿using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    internal class SkillRepository : BaseGroupRepository<SkillEntity>, ISkillRepository
    {
        public SkillRepository(Context context) : base(context) { }

        public override async Task<IEnumerable<SkillEntity>> ListAsync(CancellationToken cancellationToken = default)
        {
            return await context.Skills.Include(item => item.Ability).ToListAsync(cancellationToken);
        }

        public override async Task<SkillEntity?> FindByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await context.Skills.Include(item => item.Ability).FirstOrDefaultAsync(item => item.Id == id, cancellationToken);
        }

        public async Task<IEnumerable<SkillAttributeEntity>> ListAttributesAsync(Guid skillId, CancellationToken cancellationToken = default)
        {
            return await this.context.SkillAttributes.Include(item => item.Attribute).Where(item => item.SkillId == skillId).ToListAsync(cancellationToken: cancellationToken);
        }
    }
}
