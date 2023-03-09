using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Logging;
using Hero.Server.Core.Models;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Database;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Hero.Server.DataAccess.Repositories
{
    public class SkillRepository : ISkillRepository
    {
        private readonly HeroDbContext context;
        private readonly IGroupContext group;
        private readonly ILogger<SkillRepository> logger;

        public SkillRepository(HeroDbContext context, IGroupContext group, ILogger<SkillRepository> logger)
        {
            this.context = context;
            this.group = group;
            this.logger = logger;
        }

        private async Task<Skill> EsureUserIsEnlightableForAction(Guid id, string userId, CancellationToken cancellationToken = default)
        {
            Skill? existing = await this.GetSkillByIdAsync(id, cancellationToken);

            if (existing == null)
            {
                throw new ObjectNotFoundException("The attribute you are looking for does not exist.");
            }
            else if (null == existing || !existing.IsOwnerOrAdmin(userId))
            {
                throw new AccessForbiddenException("You are neither the creator of this attribute nor an admin.");
            }

            return existing;
        }

        public async Task<Skill?> GetSkillByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Skills
                    .Include(s => s.Creator)
                    .Include(s => s.Ability)
                    .Include(s => s.Attributes)
                        .ThenInclude(ats => ats.Attribute)
                    .FirstOrDefaultAsync(s => s.Id == id, cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting a list of skills.");
            }
        }

        public async Task<List<Skill>> FilterSkillsAsync(string? query, SuggestionState[] allowedStates, CancellationToken cancellationToken = default)
        {
            try
            {
                IQueryable<Skill> skills = this.context.Skills.Include(item => item.Creator).Where(a => a.GroupId == this.group.Id);

                if (!String.IsNullOrEmpty(query))
                {
                    skills = skills.Where(item => item.Name.ToLower().Contains(query.ToLower()) || (null != item.Description && item.Description.ToLower().Contains(query.ToLower())));
                }
                if (allowedStates.Any() && allowedStates.Distinct().Count() != Enum.GetNames(typeof(SuggestionState)).Length)
                {
                    skills = skills.Where(item => allowedStates.Any(state => state == item.State));
                }

                return await skills.ToListAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting a list of skills.");
            }
        }

        public async Task CreateSkillAsync(Skill skill, CancellationToken cancellationToken = default)
        {
            try
            {
                skill.GroupId = group.Id;

                skill.Attributes?.ForEach(ats => ats.SkillId = skill.Id);

                await this.context.Skills.AddAsync(skill, cancellationToken);
                await this.context.SaveChangesAsync(cancellationToken);                
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while creating skill.");
            }
        }

        public async Task<Skill> TryUpdateSkillAsync(Guid id, string userId, Skill updatedSkill, CancellationToken cancellationToken = default)
        {
            Skill existing = await this.EsureUserIsEnlightableForAction(id, userId, cancellationToken);

            try
            {
                existing.Update(updatedSkill);
                
                foreach (AttributeSkill existingAttributeSkill in existing.Attributes.Where(ats => updatedSkill.Attributes.Select(x => (x.SkillId, x.AttributeId)).Contains((ats.SkillId, ats.AttributeId))))
                {
                    AttributeSkill updatedAttributeSkill = updatedSkill.Attributes.Single(ats => existingAttributeSkill.SkillId == ats.SkillId && existingAttributeSkill.AttributeId == ats.AttributeId);
                    existingAttributeSkill.Value = updatedAttributeSkill.Value;
                }

                existing.Attributes.RemoveAll(ats => !updatedSkill.Attributes.Select(x => (x.SkillId, x.AttributeId)).Contains((ats.SkillId, ats.AttributeId)));
                existing.Attributes.AddRange(updatedSkill.Attributes.Where(ats => !existing.Attributes.Select(x => (x.SkillId, x.AttributeId)).Contains((ats.SkillId, ats.AttributeId))));

                if (existing.Group.OwnerId == userId && SuggestionState.Pending == existing.State)
                {
                    existing.State = SuggestionState.Approved;
                    existing.ApprovedAt = DateTime.Now;

                    foreach (AttributeSkill item in existing.Attributes.Where(item => item.Attribute.State != SuggestionState.Approved))
                    {
                        item.Attribute.State = SuggestionState.Approved;
                        item.Attribute.ApprovedAt = existing.ApprovedAt;
                    } 

                    if (existing.Ability?.State != null && existing.Ability.State != SuggestionState.Approved)
                    {
                        existing.Ability.State = SuggestionState.Approved;
                        existing.Ability.ApprovedAt = existing.ApprovedAt;
                    }
                }

                this.context.Skills.Update(existing);
                await this.context.SaveChangesAsync(cancellationToken);

                return existing;
            }
            catch (HeroException ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while updating skill.");
            }
        }

        public async Task TryDeleteSkillAsync(Guid id, string userId, CancellationToken cancellationToken = default)
        {
            Skill? existing = await this.EsureUserIsEnlightableForAction(id, userId, cancellationToken);

            try
            {
                this.context.Skills.Remove(existing);
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
                throw new HeroException("An error occured while deleting skill.");
            }
        }

        public async Task RejectSkillAsync(Guid id, string reason, CancellationToken cancellationToken = default)
        {
            Skill? skill = await this.GetSkillByIdAsync(id, cancellationToken);

            if (null == skill)
            {
                throw new ObjectNotFoundException("Skill not found.");
            }
            else if (SuggestionState.Pending != skill.State)
            {
                throw new HeroException("This skill is already approved or rejected and therefore cannot be rejected again.");
            }

            try
            {
                skill.RejectedAt = DateTime.Now;
                skill.RejectionReason = reason;
                skill.State = SuggestionState.Rejected;

                this.context.Skills.Update(skill);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error ccoured while approving skill.");
            }
        }
    }
}
