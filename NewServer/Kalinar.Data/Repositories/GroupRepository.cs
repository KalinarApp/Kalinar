using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    public class GroupRepository : IGroupRepository
    {
        private readonly Context context;

        public GroupRepository(Context context)
        {
            this.context = context;
        }

        public async Task<GroupEntity?> FindByIdAsync(Guid id, bool includeMembers, CancellationToken cancellationToken = default)
        {
            return includeMembers 
                ? await context.Groups.Include(group => group.Members).FirstOrDefaultAsync(g => g.Id == id, cancellationToken) 
                : await context.Groups.FirstOrDefaultAsync(g => g.Id == id, cancellationToken);
        }

        public async Task<IEnumerable<GroupEntity>> ListAsync(CancellationToken cancellationToken = default)
        {
            return await context.Groups.ToListAsync(cancellationToken);
        }

        public async Task<GroupEntity> CreateAsync(GroupEntity group, CancellationToken cancellationToken = default)
        {
            await context.Groups.AddAsync(group, cancellationToken);
            await context.SaveChangesAsync(cancellationToken);

            return group;
        }

        public async Task<GroupEntity> UpdateAsync(GroupEntity group, CancellationToken cancellationToken = default)
        {
            context.Groups.Update(group);
            await context.SaveChangesAsync(cancellationToken);

            return group;
        }

        public async Task DeleteAsync(GroupEntity group, CancellationToken cancellationToken = default)
        {
            context.Groups.Remove(group);
            await context.SaveChangesAsync(cancellationToken);
        }
    }

}
