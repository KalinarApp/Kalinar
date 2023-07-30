using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Application.Contracts
{
    public class UserRepository : IUserRepository
    {
        private readonly Context context;

        public UserRepository(Context context)
        {
            this.context = context;
        }

        public async Task<IEnumerable<UserEntity>> ListAsync(CancellationToken cancellationToken = default)
        {
            return await context.Users.ToListAsync(cancellationToken);
        }

        public async Task<UserEntity?> FindByIdAsync(string id, CancellationToken cancellationToken = default)
        {
            return await context.Users.FirstOrDefaultAsync(u => u.Id == id, cancellationToken);
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

        public async Task DeleteAsync(UserEntity UserEntity, CancellationToken cancellationToken = default)
        {
            context.Users.Remove(UserEntity);
            await context.SaveChangesAsync(cancellationToken);
        }

        public async Task JoinGroupAsync(string userId, Guid groupId, RoleEntity role, CancellationToken cancellationToken = default)
        {
            UserGroupEntity UserGroupEntity = new()
            {
                UserId = userId,
                GroupId = groupId,
                Role = role
            };

            await context.UserGroups.AddAsync(UserGroupEntity, cancellationToken);
            await context.SaveChangesAsync(cancellationToken);
        }

        public async Task LeaveGroupAsync(string userId, Guid groupId, CancellationToken cancellationToken = default)
        {
            UserGroupEntity? UserGroup = await context.UserGroups
                .FirstOrDefaultAsync(ug => ug.UserId == userId && ug.GroupId == groupId, cancellationToken);

            if (UserGroup != null)
            {
                context.UserGroups.Remove(UserGroup);
                await context.SaveChangesAsync(cancellationToken);
            }
        }
    }
}
