using System.Diagnostics.Metrics;
using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Logging;
using Hero.Server.Core.Models;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Database;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Hero.Server.DataAccess.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly HeroDbContext context;
        private readonly IGroupContext group;
        private readonly ILogger<UserRepository> logger;

        public UserRepository(HeroDbContext context, IGroupContext group, ILogger<UserRepository> logger)
        {
            this.context = context;
            this.group = group;
            this.logger = logger;
        }

        public async Task<bool> IsOwner(string userId, CancellationToken cancellationToken = default)
        {
            User? user = await this.GetUserByIdAsync(userId, cancellationToken);
            return null != user?.OwnedGroup && user.OwnedGroup.Id == this.group.Id;
        }

        public async Task<User> UpdateUserAsync(string id, string email, string username, CancellationToken cancellationToken = default)
        {
            User? user = await this.GetUserByIdAsync(id, cancellationToken);

            if (null == user)
            {
                user = new()
                {
                    Id = id,
                    Email = email,
                    Username = username,
                };

                await this.context.Users.AddAsync(user, cancellationToken);
            }
            else
            {
                user.Email = email;
                user.Username = username;

                this.context.Users.Update(user);
            }

            try
            {
                await this.context.SaveChangesAsync(cancellationToken);
                return user;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting user.");
            }
        } 

        public async Task<User?> GetUserByIdAsync(string id, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Users
                    .IgnoreQueryFilters()
                    .Include(u => u.OwnedGroup)
                    .Include(g => g.Group)
                    .Include(u => u.Characters)
                    .FirstOrDefaultAsync(item => id == item.Id, cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting user.");
            }
        }

        public async Task<List<User>> GetUsersByIdAsync(List<string> ids, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Users
                    .Where(item => ids.Contains(item.Id))
                    .ToListAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting a list of users.");
            }
        }
    }
}
