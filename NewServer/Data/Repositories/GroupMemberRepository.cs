using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    internal class GroupMemberRepository : IGroupMemberRepository
    {
        private readonly Context context;

        public GroupMemberRepository(Context context)
        {
            this.context = context;
        }

        public async Task<IEnumerable<GroupMemberEntity>> ListByUserIdAsync(string userId, CancellationToken cancellationToken = default)
        {
            return await this.context.GroupMembers.Include(item => item.Group).Include(item => item.User).Where(member => member.UserId == userId).ToListAsync(cancellationToken);
        }

        public async Task<GroupMemberEntity?> FindByUserAndGroupIdAsync(string userId, Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.context.GroupMembers.FirstOrDefaultAsync(member => member.UserId == userId && member.GroupId == groupId, cancellationToken);
        }

        public async Task<GroupMemberEntity> CreateAsync(GroupMemberEntity member, CancellationToken cancellationToken = default)
        {
            await this.context.GroupMembers.AddAsync(member, cancellationToken);
            await this.context.SaveChangesAsync(cancellationToken);

            return member;
        }

        public async Task<GroupMemberEntity> UpdateAsync(GroupMemberEntity member, CancellationToken cancellationToken = default)
        {
            this.context.GroupMembers.Update(member);
            await this.context.SaveChangesAsync(cancellationToken);

            return member;
        }

        public async Task DeleteAsync(GroupMemberEntity member, CancellationToken cancellationToken = default)
        {
            this.context.GroupMembers.Remove(member);
            await this.context.SaveChangesAsync(cancellationToken);
        }
    }
}
