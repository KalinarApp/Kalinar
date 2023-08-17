using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Services
{
    public class GroupService : IGroupService
    {
        private readonly IGroupRepository groupRepository;

        public GroupService(IGroupRepository groupRepository)
        {
            this.groupRepository = groupRepository;
        }

        public async Task<GroupEntity> GetByIdAsync(Guid groupId, bool includeMembers = false, CancellationToken cancellationToken = default)
        {
            return await this.groupRepository.FindByIdAsync(groupId, includeMembers, cancellationToken) ?? throw new GroupNotFoundException(groupId);
        }

        public Task<IEnumerable<GroupEntity>> ListAsync(CancellationToken cancellationToken = default)
        {
            return this.groupRepository.ListAsync(cancellationToken);
        }

        public Task<GroupEntity> CreateAsync(GroupRequest request, CancellationToken cancellationToken = default)
        {
            GroupEntity group = new()
            {
                Id = Guid.NewGuid(),
                Name = request.Name,
                Description = request.Description,
                Members = new(),
            };

            return this.groupRepository.CreateAsync(group, cancellationToken);
        }

        public async Task<GroupEntity> UpdateAsync(Guid id, GroupRequest request, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            group.Name = request.Name;
            group.Description = request.Description;

            return await this.groupRepository.UpdateAsync(group, cancellationToken);
        }

        public async Task DeleteAsync(Guid id, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.GetByIdAsync(id, cancellationToken: cancellationToken);
            await this.groupRepository.DeleteAsync(group, cancellationToken);
        }
    }
}
