using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;

namespace Kalinar.Application.Services
{
    internal class SkillService : SuggestableService, ISkillService
    {
        private readonly ISkillRepository skillRepository;
        private readonly IAttributeService attributeService;
        private readonly IAbilityService abilityService;
        private readonly IUserService userService;

        public SkillService(ISkillRepository skillRepository, IAttributeService attributeService, IAbilityService abilityService, IUserService userService, IGroupService groupService)
            : base(groupService)
        {
            this.skillRepository = skillRepository;
            this.attributeService = attributeService;
            this.abilityService = abilityService;
            this.userService = userService;
        }

        public async Task<IEnumerable<SkillEntity>> ListAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await this.skillRepository.ListByGroupIdAsync(groupId, cancellationToken);
        }

        public async Task<IEnumerable<SkillAttributeEntity>> ListAttributesAsync(Guid skillId, CancellationToken cancellationToken = default)
        {
            return await this.skillRepository.ListAttributesAsync(skillId, cancellationToken);
        }

        public async Task<SkillEntity> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await this.skillRepository.FindByIdAsync(id, cancellationToken) ?? throw new SkillNotFoundException(id);
        }

        public async Task<SkillEntity> CreateAsync(string userId, SkillCreateRequest request, CancellationToken cancellationToken = default)
        {
            UserEntity user = await this.userService.GetByIdAsync(userId, cancellationToken);
            GroupEntity group = await this.groupService.GetByIdAsync(request.GroupId, true, cancellationToken);
            
            AbilityEntity? ability = default;
            if (request.AbilityId is not null) ability = await this.abilityService.GetByIdAsync(request.AbilityId.Value, cancellationToken);

            SkillEntity skill = new()
            {
                Id = Guid.NewGuid(),
                Name = request.Name,
                Description = request.Description,
                IconUrl = request.IconUrl,
                AbilityId = request.AbilityId,
                Ability = ability,
                Attributes = new(),
                GroupId = group.Id,
                Group = group,
                CreatedAt = DateTime.UtcNow,
                CreatorId = userId,
                Creator = user,
                State = SuggestionState.Pending,
            };

            await this.CreateSuggestableAsync(userId, skill, cancellationToken);

            return await this.skillRepository.CreateAsync(skill, cancellationToken);
        }

        public async Task<SkillEntity> SetAttributesAsync(Guid skillId, List<SkillAttributeRequest> request, CancellationToken cancellationToken = default)
        {
            List<SkillAttributeEntity> attributes = new();
            SkillEntity skill = await this.GetByIdAsync(skillId, cancellationToken);

            foreach (SkillAttributeRequest requestAttribute in request)
            {
                AttributeEntity attribute = await this.attributeService.GetByIdAsync(requestAttribute.AttributeId, cancellationToken);
                SkillAttributeEntity skillAttribute = new()
                {
                    AttributeId = requestAttribute.AttributeId,
                    Attribute = attribute,
                    SkillId = skillId,
                    Skill = skill,
                    Value = requestAttribute.Value,
                };

                attributes.Add(skillAttribute);
            }

            skill.Attributes.AddRange(attributes);

            await this.skillRepository.UpdateAsync(skill, cancellationToken);

            return skill;
        }

        public async Task<SkillEntity> UpdateAsync(Guid id, SkillUpdateRequest request, CancellationToken cancellationToken = default)
        {
            SkillEntity skill = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            skill.Name = request.Name;
            skill.Description = request.Description;
            skill.IconUrl = request.IconUrl;
            skill.AbilityId = request.AbilityId;

            return await this.skillRepository.UpdateAsync(skill, cancellationToken);
        }

        public async Task<SkillEntity> ApproveAsync(Guid id, CancellationToken cancellationToken = default)
        {
            SkillEntity skill = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            this.ApproveSuggestable(skill);

            return await this.skillRepository.UpdateAsync(skill, cancellationToken);
        }

        public async Task<SkillEntity> RejectAsync(Guid id, RejectRequest request, CancellationToken cancellationToken = default)
        {
            SkillEntity skill = await this.GetByIdAsync(id, cancellationToken: cancellationToken);

            this.RejectSuggestable(skill, request.Reason);

            return await this.skillRepository.UpdateAsync(skill, cancellationToken);
        }

        public async Task DeleteAsync(Guid id, CancellationToken cancellationToken = default)
        {
            SkillEntity skill = await this.GetByIdAsync(id, cancellationToken: cancellationToken);
            await this.skillRepository.DeleteAsync(skill, cancellationToken);
        }
    }
}
