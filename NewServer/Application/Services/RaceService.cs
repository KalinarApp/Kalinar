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
            return await this.raceRepository.FindByIdAsync(id, cancellationToken) ?? throw new RaceNotFoundException(id);
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
                Attributes = new List<RaceAttributeEntity>(),
            };

            await this.CreateSuggestableAsync(userId, race, cancellationToken);

            return await this.raceRepository.CreateAsync(race, cancellationToken);
        }

        public async Task SetAttributesAsync(Guid raceId, IEnumerable<RaceAttributeRequest> request, CancellationToken cancellationToken = default)
        {
            RaceEntity race = await this.GetByIdAsync(raceId, cancellationToken: cancellationToken);
            IEnumerable<RaceAttributeEntity> existingRaceAttributes = await this.ListAttributesAsync(raceId, cancellationToken);

            race.Attributes = existingRaceAttributes;

            List<RaceAttributeEntity> raceAttributes = new();

            foreach (RaceAttributeRequest requestItem in request)
            {
                AttributeEntity attribute = await this.attributeService.GetByIdAsync(requestItem.AttributeId, cancellationToken);

                if ((race.State == SuggestionState.Approved && attribute.State == SuggestionState.Pending) || attribute.State == SuggestionState.Rejected) throw new AttributeNotApprovedException(attribute.Name);

                RaceAttributeEntity raceAttribute = new()
                {
                    AttributeId = requestItem.AttributeId,
                    Attribute = attribute,
                    RaceId = raceId,
                    Race = race,
                    Value = requestItem.Value,
                };

                raceAttributes.Add(raceAttribute);
            }

            await this.raceRepository.SetAttributesAsync(race, raceAttributes, cancellationToken);
        }

        public async Task<RaceEntity> UpdateAsync(Guid id, RaceUpdateRequest request, CancellationToken cancellationToken = default)
        {
            RaceEntity race = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            race.Name = request.Name;
            race.Description = request.Description;

            return await this.raceRepository.UpdateAsync(race, cancellationToken);
        }

        public async Task<RaceEntity> ApproveAsync(Guid id, CancellationToken cancellationToken = default)
        {
            RaceEntity race = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            this.ApproveSuggestable(race);

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
