using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Services
{
    internal class AbilityService : SuggestableService, IAbilityService
    {
        private readonly IAbilityRepository abilityRepository;
        private readonly IUserService userService;

        public AbilityService(IAbilityRepository abilityRepository, IUserService userService, IGroupService groupService)
            : base(groupService)
        {
            this.abilityRepository = abilityRepository;
            this.userService = userService;
        }

        public async Task<IEnumerable<AbilityEntity>> ListAsync(Guid groupId, bool? approved = default, CancellationToken cancellationToken = default)
        {
            IEnumerable<AbilityEntity> items = await this.abilityRepository.ListByGroupIdAsync(groupId, cancellationToken);
            return items.Where(item => approved is null || (item.State == SuggestionState.Approved) == approved);
        }

        public async Task<IEnumerable<AbilityTagEntity>> ListTagsAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.abilityRepository.ListTagsAsync(groupId, cancellationToken);
        }

        public async Task<IEnumerable<AbilityTagEntity>> ListTagsByAbilityIdAsync(Guid abilityId, CancellationToken cancellationToken = default)
        {
            AbilityEntity ability = await this.GetByIdAsync(abilityId, cancellationToken);
            return ability.Tags;
        }

        public async Task<AbilityEntity> GetByIdAsync(Guid abilityId, CancellationToken cancellationToken = default)
        {
            return await this.abilityRepository.FindByIdAsync(abilityId, cancellationToken) ?? throw new AbilityNotFoundException(abilityId);
        }

        public async Task<AbilityEntity> CreateAsync(string userId, AbilityCreateRequest request, CancellationToken cancellationToken = default)
        {
            UserEntity user = await this.userService.GetByIdAsync(userId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);

            Guid abilityId = Guid.NewGuid();
            AbilityEntity ability = new()
            {
                Id = abilityId,
                Name = request.Name,
                Description = request.Description,
                GroupId = request.GroupId,
                Group = group,
                Creator = user,
                CreatorId = userId,
                IsPassive = request.IsPassive,
                State = SuggestionState.Pending,
                CreatedAt = DateTime.UtcNow,
                Tags = new List<AbilityTagEntity>(),
            };

            await this.CreateSuggestableAsync(userId, ability, cancellationToken);

            return await this.abilityRepository.CreateAsync(ability, cancellationToken);
        }

        public async Task<AbilityEntity> UpdateAsync(Guid id, AbilityUpdateRequest request, CancellationToken cancellationToken = default)
        {
            AbilityEntity ability = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            ability.Name = request.Name;
            ability.Description = request.Description;
            ability.IsPassive = request.IsPassive;
            ability.ModifiedAt = DateTime.UtcNow;
                        
            return await this.abilityRepository.UpdateAsync(ability, cancellationToken);
        }

        public async Task SetTagsAsync(Guid id, IEnumerable<string> tags, CancellationToken cancellationToken = default)
        {
            AbilityEntity ability = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            await this.abilityRepository.SetTagsAsync(ability, tags, cancellationToken);
        }

        public async Task<AbilityEntity> ApproveAsync(Guid id, CancellationToken cancellationToken = default)
        {
            AbilityEntity ability = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            this.ApproveSuggestable(ability);

            return await this.abilityRepository.UpdateAsync(ability, cancellationToken);
        }

        public async Task<AbilityEntity> RejectAsync(Guid id, RejectRequest request, CancellationToken cancellationToken = default)
        {
            AbilityEntity ability = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            this.RejectSuggestable(ability, request.Reason);

            return await this.abilityRepository.UpdateAsync(ability, cancellationToken);
        }

        public async Task DeleteAsync(Guid id, CancellationToken cancellationToken = default)
        {
            AbilityEntity ability = await this.GetByIdAsync(id, cancellationToken: cancellationToken);
            await this.abilityRepository.DeleteAsync(ability, cancellationToken);
        }
    }
}
