using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Services
{
    internal class AttributeService : SuggestableService, IAttributeService
    {
        private readonly IAttributeRepository attributeRepository;
        private readonly IUserService userService;

        public AttributeService(IAttributeRepository attributeRepository, IUserService userService, IGroupService groupService) 
            : base(groupService)
        {
            this.attributeRepository = attributeRepository;
            this.userService = userService;
        }

        public async Task<IEnumerable<AttributeEntity>> ListAsync(Guid groupId, bool? approved = default, CancellationToken cancellationToken = default)
        {
            IEnumerable<AttributeEntity> items = await this.attributeRepository.ListByGroupIdAsync(groupId, cancellationToken);
            return items.Where(item => approved is null || (item.State == SuggestionState.Approved) == approved);
        }

        public async Task<AttributeEntity> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await this.attributeRepository.FindByIdAsync(id, cancellationToken) ?? throw new AttributeNotFoundException(id);
        }

        public async Task<IEnumerable<string>> ListCategoriesAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.attributeRepository.ListCategoriesAsync(groupId, cancellationToken);
        }

        public async Task<AttributeEntity> CreateAsync(string userId, AttributeCreateRequest request, CancellationToken cancellationToken = default)
        {
            UserEntity user = await this.userService.GetByIdAsync(userId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);

            AttributeEntity attribute = new()
            {
                Id = Guid.NewGuid(),
                Name = request.Name,
                Description = request.Description,
                GroupId = request.GroupId,
                Group = group,
                CreatorId = userId,
                Creator = user,
                State = SuggestionState.Pending,
                Category = request.Category,
                IconData = request.IconData,
                MaxValue = request.MaxValue,
                MinValue = request.MinValue,
                StepSize = request.StepSize,
                CreatedAt = DateTime.UtcNow,
            };

            await this.CreateSuggestableAsync(userId, attribute, cancellationToken);

            return await this.attributeRepository.CreateAsync(attribute, cancellationToken);
        }

        public async Task<AttributeEntity> UpdateAsync(Guid id, AttributeUpdateRequest request, CancellationToken cancellationToken = default)
        {
            AttributeEntity attribute = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            attribute.Name = request.Name;
            attribute.Description = request.Description;
            attribute.Category = request.Category;
            attribute.IconData = request.IconData;
            attribute.MaxValue = request.MaxValue;
            attribute.MinValue = request.MinValue;
            attribute.StepSize = request.StepSize;

            return await this.attributeRepository.UpdateAsync(attribute, cancellationToken);
        }

        public async Task<AttributeEntity> ApproveAsync(Guid id, CancellationToken cancellationToken = default)
        {
            AttributeEntity attribute = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            this.ApproveSuggestable(attribute);

            return await this.attributeRepository.UpdateAsync(attribute, cancellationToken);
        }

        public async Task<AttributeEntity> RejectAsync(Guid id, RejectRequest request, CancellationToken cancellationToken = default)
        {
            AttributeEntity attribute = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            this.RejectSuggestable(attribute, request.Reason);

            return await this.attributeRepository.UpdateAsync(attribute, cancellationToken);
        }

        public async Task DeleteAsync(Guid id, CancellationToken cancellationToken = default) 
        {             
            AttributeEntity attribute = await this.GetByIdAsync(id, cancellationToken: cancellationToken);
            await this.attributeRepository.DeleteAsync(attribute, cancellationToken);
        }
    }
}
