using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Services
{
    internal class GroupMemberService : IGroupMemberService
    {
        private readonly IGroupMemberRepository groupMemberRepository;
        private readonly IGroupService groupService;
        private readonly IUserService userService;

        public GroupMemberService(IGroupMemberRepository groupMemberRepository, IGroupService groupService, IUserService userService)
        {
            this.groupMemberRepository = groupMemberRepository;
            this.groupService = groupService;
            this.userService = userService;
        }

        public async Task<IEnumerable<GroupMemberEntity>> ListByUserIdAsync(string userId, CancellationToken cancellationToken = default)
        {
            return await this.groupMemberRepository.ListByUserIdAsync(userId, cancellationToken);
        }

        public async Task<GroupMemberEntity> GetByUserAndGroupIdAsync(string userId, Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.groupMemberRepository.FindByUserAndGroupIdAsync(userId, groupId, cancellationToken) ?? throw new GroupMemberNotFoundException(userId, groupId);
        }

        public async Task<GroupMemberEntity> CreateAsync(string userId, Guid groupId, Role role, CancellationToken cancellationToken = default)
        {
            UserEntity user = await this.userService.GetByIdAsync(userId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(groupId, cancellationToken: cancellationToken);

            if (await this.groupMemberRepository.FindByUserAndGroupIdAsync(userId, groupId, cancellationToken) != null) throw new UserAlreadyInGroupException(userId, groupId);

            GroupMemberEntity member = new()
            {
                UserId = userId,
                User = user,
                GroupId = groupId,
                Group = group,
                Role = role,
            };

            return await this.groupMemberRepository.CreateAsync(member, cancellationToken);
        }

        public async Task<GroupMemberEntity> UpdateAsync(string userId, Guid groupId, GroupMemberUpdateRequest request, CancellationToken cancellationToken = default)
        {
            GroupMemberEntity member = await this.GetByUserAndGroupIdAsync(userId, groupId, cancellationToken);

            member.Role = Enum.Parse<Role>(request.Role);

            return await this.groupMemberRepository.UpdateAsync(member, cancellationToken);
        }

        public async Task DeleteAsync(string userId, Guid groupId, CancellationToken cancellationToken = default)
        {
            GroupMemberEntity member = await this.GetByUserAndGroupIdAsync(userId, groupId, cancellationToken);
            await this.groupMemberRepository.DeleteAsync(member, cancellationToken);
        }
    }
}
