using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Logging;
using Hero.Server.Core.Models;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Database;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Hero.Server.DataAccess.Repositories
{
    public class GroupRepository : IGroupRepository
    {
        private readonly IUserRepository userRepository;
        private readonly HeroDbContext context;
        private readonly ILogger<GroupRepository> logger;

        public GroupRepository(IUserRepository userRepository, HeroDbContext context, ILogger<GroupRepository> logger)
        {
            this.userRepository = userRepository;
            this.context = context;
            this.logger = logger;
        }

        private string GenerateInvitationCode()
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, 12)
                .Select(s => s[new Random().Next(s.Length)]).ToArray());
        }

        private async Task EvaluateInvitationCode(Guid groupId, string invitationCode, CancellationToken cancellationToken = default)
        {
            Group? group = await this.context.Groups.IgnoreQueryFilters().SingleOrDefaultAsync(group =>  groupId == group.Id, cancellationToken);
            if (group == null || String.IsNullOrEmpty(invitationCode) || !String.Equals(group.InviteCode, invitationCode, StringComparison.InvariantCultureIgnoreCase))
            {
                throw new GroupAccessForbiddenException("The provided invite code is invalid");
            }
        }

        public void EnsureIsMemberOrOwner(string userId)
        {
            Group? group = this.context.Groups.FirstOrDefault(g => g.OwnerId == userId || g.Members.Any(u => u.Id == userId));

            if (null == group)
            {
                throw new GroupAccessForbiddenException("You are no member of this group");
            }
        }

        public void EnsureIsOwner(string userId)
        {
            Group? group = this.context.Groups.FirstOrDefault(g => g.OwnerId == userId);

            if (null == group)
            {
                throw new GroupAccessForbiddenException("You are no admin of this group");
            }
        }

        public async Task<Group?> GetGroupByUserId(string userId, CancellationToken cancellationToken = default)
        {
            try
            {
                User? user = await this.userRepository.GetUserByIdAsync(userId, cancellationToken);
                return user?.OwnedGroup ?? user?.Group;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting group information.");
            }
        }

        public async Task<Group> GetGroupByOwnerId(string userId, CancellationToken cancellationToken = default)
        {
            try
            {
                User? user = await this.context.Users.Include(u => u.OwnedGroup).ThenInclude(g => g.Members).SingleOrDefaultAsync(u => u.Id == userId);

                if (null == user?.OwnedGroup)
                {
                    throw new GroupAccessForbiddenException("You are no admin of any group, you should create one.");
                }

                return user.OwnedGroup;
            }
            catch (HeroException ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting group information.");
            }
        }

        public async Task<Group> GetGroupByInviteCode(string invitationCode, CancellationToken cancellationToken = default)
        {
            try
            {
                Group? group = await this.context.Groups
                    .IgnoreQueryFilters()
                    .Include(group => group.Owner)
                    .SingleOrDefaultAsync(group => EF.Functions.ILike(group.InviteCode, invitationCode), cancellationToken);

                if (null == group)
                {
                    throw new GroupAccessForbiddenException("The provided invite code is invalid");
                }

                return group;
            }
            catch (HeroException ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting group information.");
            }
        }

        public async Task<string> CreateGroup(string groupName, string? groupDescription, string ownerId, CancellationToken cancellationToken = default)
        {
            try
            {
                string code = this.GenerateInvitationCode();

                await this.context.Groups.AddAsync(new Group() { Name = groupName, Description = groupDescription, OwnerId = ownerId, InviteCode = code });
                await this.context.SaveChangesAsync(cancellationToken);

                return code;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while creating the group.");
            }
        }

        public async Task JoinGroup(Guid groupId, string userId, string invitationCode, CancellationToken cancellationToken = default)
        {
            try
            {
                await this.EvaluateInvitationCode(groupId, invitationCode, cancellationToken);

                User? user = await this.userRepository.GetUserByIdAsync(userId);

                if (null != user)
                {
                    user.GroupId = groupId;
                }

                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (HeroException ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while joining the group.");
            }
        }

        public async Task LeaveGroup(string userId, CancellationToken cancellationToken = default)
        {
            try
            {
                User? user = await this.userRepository.GetUserByIdAsync(userId);
                if (null != user)
                {
                    user.GroupId = null;

                    await this.context.SaveChangesAsync(cancellationToken);   
                }
            }
            catch (HeroException ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while leaving the group.");
            }
        }

        public async Task DeleteGroup(Guid groupId, string userId, CancellationToken cancellationToken = default)
        {
            try
            {
                Group? group = await this.context.Groups.FindAsync(groupId, cancellationToken);
                if (null != group && group.OwnerId == userId)
                {
                    this.context.Remove(group);
                    await this.context.SaveChangesAsync(cancellationToken);
                }
                else
                {
                    throw new HeroException("The group you are searching for could not be found.");
                }
            }
            catch (HeroException ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while deleting the group.");
            }
        }
    }
}
