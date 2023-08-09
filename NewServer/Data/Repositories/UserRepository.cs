using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Application.Contracts
{
    internal class UserRepository : IUserRepository
    {
        private readonly Context context;

        public UserRepository(Context context)
        {
            this.context = context;
        }

        public async Task<IEnumerable<UserEntity>> ListAsync(CancellationToken cancellationToken = default)
        {
            return await context.Users.Include(user => user.Devices).ToListAsync(cancellationToken);
        }

        public async Task<IEnumerable<UserEntity>> ListByGroupIdAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await context.Users.Include(user => user.Devices).Where(user => user.Groups.Any(group => group.GroupId == groupId)).ToListAsync(cancellationToken);
        }

        public async Task<UserEntity?> FindByIdAsync(string id, CancellationToken cancellationToken = default)
        {
            return await context.Users.Include(user => user.Devices).FirstOrDefaultAsync(u => u.Id == id, cancellationToken);
        }

        public async Task<UserEntity> CreateAsync(UserEntity user, CancellationToken cancellationToken = default)
        {
            await context.Users.AddAsync(user, cancellationToken);
            await context.SaveChangesAsync(cancellationToken);

            return user;
        }

        public async Task<UserEntity> UpdateAsync(UserEntity user, CancellationToken cancellationToken = default)
        {
            context.Users.Update(user);
            await context.SaveChangesAsync(cancellationToken);

            return user;
        }

        public async Task DeleteAsync(UserEntity user, CancellationToken cancellationToken = default)
        {
            context.Users.Remove(user);
            await context.SaveChangesAsync(cancellationToken);
        }
    }
}
