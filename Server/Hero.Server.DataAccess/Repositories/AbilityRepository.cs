using Hero.Server.Core;
using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Logging;
using Hero.Server.Core.Models;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Database;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Hero.Server.DataAccess.Repositories
{
    public class AbilityRepository : IAbilityRepository
    {
        private readonly HeroDbContext context;
        private readonly IGroupContext groupContext;
        private readonly ILogger<AbilityRepository> logger;

        public AbilityRepository(HeroDbContext context, IGroupContext groupContext, ILogger<AbilityRepository> logger)
        {
            this.context = context;
            this.groupContext = groupContext;
            this.logger = logger;
        }

        private async Task<Ability> EsureUserIsEnlightableForAction(Guid id, string userId, CancellationToken cancellationToken = default)
        {
            Ability? existing = await this.GetAbilityByIdAsync(id, cancellationToken);

            if (existing == null)
            {
                throw new ObjectNotFoundException("The ability you are looking for does not exist.");
            }
            else if (null == existing || !existing.IsOwnerOrAdmin(userId))
            {
                throw new AccessForbiddenException("You are neither the creator of this ability nor an admin.");
            }

            return existing;
        }

        public async Task<Ability?> GetAbilityByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Abilities.Include(item => item.Group).FirstOrDefaultAsync(item => item.Id == id);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while fetching this ability");
            }
        }

        public async Task<Ability> GetAbilityByNameAsync(string name, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Abilities.FirstOrDefaultAsync(g => EF.Functions.ILike(g.Name, name), cancellationToken) ?? throw new HeroException("The ability you are looking for is not there.");
            }
            catch (Exception)
            {
                throw new HeroException("An error occured while fetching abilities");
            }
        }

        public async Task<List<Ability>> GetAllAbilitiesAsync(CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Abilities.Where(a => a.GroupId == this.groupContext.Id).ToListAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting a list of abilities.");
            }
        }

        public async Task CreateAbilityAsync(Ability ability, CancellationToken cancellationToken = default)
        {
            try
            {
                ability.GroupId = this.groupContext.Id;

                await this.context.Abilities.AddAsync(ability, cancellationToken);
                await this.context.SaveChangesAsync(cancellationToken);                
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while creating an ability.");
            }
        }

        public async Task TryUpdateAbilityAsync(Guid id, string userId, Ability updated, CancellationToken cancellationToken = default)
        {
            Ability existing = await this.EsureUserIsEnlightableForAction(id, userId, cancellationToken);

            try
            {
                existing.Update(updated);

                this.context.Abilities.Update(existing);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while updating the ability.");
            }
        }

        public async Task TryDeleteAbilityAsync(Guid id, string userId, CancellationToken cancellationToken = default)
        {
            Ability existing = await this.EsureUserIsEnlightableForAction(id, userId, cancellationToken);

            try
            {
                this.context.Abilities.Remove(existing);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while deleting the ability.");
            }
        }

        public async Task ApproveAbility(Guid id, CancellationToken cancellationToken = default)
        {
            Ability? ability = await this.GetAbilityByIdAsync(id, cancellationToken);

            if (null == ability)
            {
                throw new ObjectNotFoundException("Ability not found.");
            }

            try
            {
                ability.ApprovedAt = DateTime.Now;
                ability.State = SuggestionState.Approved;

                this.context.Abilities.Update(ability);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error ccoured while approving the ability.");
            }
        }

        public async Task RejectAbility(Guid id, string reason, CancellationToken cancellationToken = default)
        {
            Ability? ability = await this.GetAbilityByIdAsync(id, cancellationToken);

            if (null == ability)
            {
                throw new ObjectNotFoundException("Ability not found.");
            }

            try
            {
                ability.RejectedAt = DateTime.Now;
                ability.RejectionReason = reason;
                ability.State = SuggestionState.Approved;

                this.context.Abilities.Update(ability);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error ccoured while approving the ability.");
            }
        }
    }
}
