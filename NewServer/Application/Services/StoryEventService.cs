using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Services
{
    internal class StoryEventService : IStoryEventService
    {
        private readonly IStoryEventRepository eventRepository;
        private readonly IGroupService groupService;

        public StoryEventService(IStoryEventRepository eventRepository, IGroupService groupService)
        {
            this.eventRepository = eventRepository;
            this.groupService = groupService;
        }

        public async Task<IEnumerable<StoryEventEntity>> ListAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.eventRepository.ListByGroupIdAsync(groupId, cancellationToken);
        }

        public async Task<StoryEventEntity> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await this.eventRepository.FindByIdAsync(id, cancellationToken) ?? throw new StoryEventNotFoundException(id);
        }

        public async Task<StoryEventEntity> CreateAsync(StoryEventCreateRequest request, CancellationToken cancellationToken = default)
        {
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, cancellationToken: cancellationToken);   

            StoryEventEntity storyEvent = new()
            {
                Id = Guid.NewGuid(),
                CreatedAt = DateTime.UtcNow,
                GroupId = request.GroupId,
                Group = group,
                Title = request.Title,
                Description = request.Description,
                Order = request.Order,
                Date = request.Date,
                IsUnlocked = request.IsUnlocked
            };

            return await this.eventRepository.CreateAsync(storyEvent, cancellationToken);
        }

        public async Task<StoryEventEntity> UpdateAsync(Guid id, StoryEventUpdateRequest request, CancellationToken cancellationToken = default)
        {
            StoryEventEntity storyEvent = await this.GetByIdAsync(id, cancellationToken);

            storyEvent.Title = request.Title;
            storyEvent.Description = request.Description;
            storyEvent.Order = request.Order;
            storyEvent.Date = request.Date;
            storyEvent.IsUnlocked = request.IsUnlocked;

            return await this.eventRepository.UpdateAsync(storyEvent, cancellationToken);
        }

        public async Task DeleteAsync(Guid id, CancellationToken cancellationToken = default) 
        {             
            StoryEventEntity storyEvent = await this.GetByIdAsync(id, cancellationToken);
            await this.eventRepository.DeleteAsync(storyEvent, cancellationToken);
        }
    }
}
