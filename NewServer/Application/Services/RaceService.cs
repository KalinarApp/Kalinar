using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Services
{
    internal class RaceService : SuggestableService, IRaceService
    {
        private readonly IRaceRepository raceRepository;
        private readonly IUserService userService;
        private readonly IAttributeService attributeService;

        public RaceService(IRaceRepository raceRepository, IUserService userService, IGroupService groupService, IAttributeService attributeService)
            : base(groupService)
        {
            this.raceRepository = raceRepository;
            this.userService = userService;
            this.attributeService = attributeService;
        }

        public async Task<IEnumerable<RaceEntity>> ListAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.raceRepository.ListByGroupIdAsync(groupId, cancellationToken);
        }

        public async Task<IEnumerable<RaceAttributeEntity>> ListAttributesAsync(Guid skillId, CancellationToken cancellationToken = default)
        {
            return await this.raceRepository.ListAttributesAsync(skillId, cancellationToken);
        }

        public async Task<RaceEntity> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await this.raceRepository.FindByIdAsync(id, cancellationToken) ?? throw new SkillNotFoundException(id);
        }

        public async Task<RaceEntity> CreateAsync(string userId, RaceCreateRequest request, CancellationToken cancellationToken = default)
        {
            UserEntity user = await this.userService.GetByIdAsync(userId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);

            RaceEntity race = new()
            {
                Id = Guid.NewGuid(),
                Name = request.Name,
                Description = request.Description,
                GroupId = group.Id,
                Group = group,
                CreatedAt = DateTime.UtcNow,
                CreatorId = userId,
                Creator = user,
                State = SuggestionState.Pending,
                Attributes = new(),
            };

            await this.CreateSuggestableAsync(userId, race, cancellationToken);

            return await this.raceRepository.CreateAsync(race, cancellationToken);
        }

        public async Task<RaceEntity> SetAttributesAsync(Guid raceId, List<RaceAttributeRequest> request, CancellationToken cancellationToken = default)
        {
            List<RaceAttributeEntity> attributes = new();
            RaceEntity race = await this.GetByIdAsync(raceId, cancellationToken);

            foreach (RaceAttributeRequest requestAttribute in request)
            {
                AttributeEntity attribute = await this.attributeService.GetByIdAsync(requestAttribute.AttributeId, cancellationToken);
                RaceAttributeEntity raceAttribute = new()
                {
                    AttributeId = requestAttribute.AttributeId,
                    Attribute = attribute,
                    RaceId = raceId,
                    Race = race,
                    Value = requestAttribute.Value,
                };

                attributes.Add(raceAttribute);
            }

            race.Attributes.AddRange(attributes);

            await this.raceRepository.UpdateAsync(race, cancellationToken);

            return race;
        }

        public async Task<RaceEntity> UpdateAsync(string userId, Guid id, RaceUpdateRequest request, CancellationToken cancellationToken = default)
        {
            RaceEntity race = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            race.Name = request.Name;
            race.Description = request.Description;

            await this.UpdateSuggestableAsync(userId, race, cancellationToken);

            return await this.raceRepository.UpdateAsync(race, cancellationToken);
        }

        public async Task<RaceEntity> RejectAsync(Guid id, RejectRequest request, CancellationToken cancellationToken = default)
        {
            RaceEntity race = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            this.RejectSuggestable(race, request.Reason);

            return await this.raceRepository.UpdateAsync(race, cancellationToken);
        }

        public async Task DeleteAsync(Guid id, CancellationToken cancellationToken = default)
        {
            RaceEntity skill = await this.GetByIdAsync(id, cancellationToken: cancellationToken);
            await this.raceRepository.DeleteAsync(skill, cancellationToken);
        }
    }
}
