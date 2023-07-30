using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;

namespace Kalinar.Application.Services
{
    public class GroupService : IGroupService
    {
        private readonly IGroupRepository groupRepository;

        public GroupService(IGroupRepository groupRepository)
        {
            this.groupRepository = groupRepository;
        }

        public async Task<GroupEntity> GetByIdAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.groupRepository.FindByIdAsync(groupId, cancellationToken) ?? throw new GroupNotFoundException(groupId);
        }

        public Task<IEnumerable<GroupEntity>> ListAsync(CancellationToken cancellationToken = default)
        {
            return this.groupRepository.ListAsync(cancellationToken);
        }

        public Task CreateGroupAsync(GroupEntity group, CancellationToken cancellationToken = default)
        {
            return this.groupRepository.CreateAsync(group, cancellationToken);
        }

        public Task UpdateGroupAsync(GroupEntity group, CancellationToken cancellationToken = default)
        {
            return this.groupRepository.UpdateAsync(group, cancellationToken);
        }

        public Task DeleteGroupAsync(GroupEntity group, CancellationToken cancellationToken = default)
        {
            return this.groupRepository.DeleteAsync(group, cancellationToken);
        }
    }
}
