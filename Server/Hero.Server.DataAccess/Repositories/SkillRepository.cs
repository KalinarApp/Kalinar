using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Logging;
using Hero.Server.Core.Models;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Database;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System.Xml.Linq;

namespace Hero.Server.DataAccess.Repositories
{
    public class SkillRepository : ISkillRepository
    {
        private readonly HeroDbContext context;
        private readonly IGroupContext group;
        private readonly IUserRepository userRepository;
        private readonly ILogger<SkillRepository> logger;

        public SkillRepository(HeroDbContext context, IGroupContext group, IUserRepository userRepository, ILogger<SkillRepository> logger)
        {
            this.context = context;
            this.group = group;
            this.userRepository = userRepository;
            this.logger = logger;
        }

        public async Task<Skill?> GetSkillByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Skills.Include(s => s.Ability).Include(s => s.Attributes).ThenInclude(ats => ats.Attribute).FirstOrDefaultAsync(s => s.Id == id, cancellationToken);
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
                skill.Id = Guid.NewGuid();
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

        public async Task DeleteSkillAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                Skill? existing = await this.GetSkillByIdAsync(id, cancellationToken);
                if (null == existing)
                {
                    this.logger.LogSkillDoesNotExist(id);
                    throw new ObjectNotFoundException("The skill you are looking for could not be found.");
                }
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

        public async Task<List<Skill>> GetAllSkillsAsync(CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Skills.Include(s => s.Ability).Include(s => s.Attributes).ThenInclude(ats => ats.Attribute).ToListAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting a list of skills.");
            }
        }

        public async Task UpdateSkillAsync(Guid id, Skill updatedSkill, CancellationToken cancellationToken = default)
        {
            try
            {
                Skill? existing = await this.GetSkillByIdAsync(id, cancellationToken);

                if (null == existing)
                {
                    throw new ObjectNotFoundException($"The Skill (id: {id}) you're trying to update does not exist.");
                }

                existing.Update(updatedSkill);

                foreach (AttributeSkill existingAttributeSkill in existing.Attributes.Where(ats => updatedSkill.Attributes.Select(x => (x.SkillId, x.AttributeId)).Contains((ats.SkillId, ats.AttributeId))))
                {
                    AttributeSkill updatedAttributeSkill = updatedSkill.Attributes.Single(ats => existingAttributeSkill.SkillId == ats.SkillId && existingAttributeSkill.AttributeId == ats.AttributeId);
                    existingAttributeSkill.Value = updatedAttributeSkill.Value;
                }

                existing.Attributes.RemoveAll(ats => !updatedSkill.Attributes.Select(x => (x.SkillId, x.AttributeId)).Contains((ats.SkillId, ats.AttributeId)));
                existing.Attributes.AddRange(updatedSkill.Attributes.Where(ats => !existing.Attributes.Select(x => (x.SkillId, x.AttributeId)).Contains((ats.SkillId, ats.AttributeId))));

                this.context.Skills.Update(existing);
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
                throw new HeroException("An error occured while updating the attribute.");
            }
        }
    }
}
