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

        public async Task<Ability> GetAbilityByNameAsync(string name, CancellationToken cancellationToken = default)
        {
            return await this.context.Abilities.FirstOrDefaultAsync(g => EF.Functions.ILike(g.Name, name), cancellationToken) ?? throw new HeroException("The ability you are looking for is not there.");
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

        public async Task DeleteAbilityAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                Ability? existing = await this.context.Abilities.SingleAsync(a => a.Id == id, cancellationToken);
                if(null == existing)
                {
                    this.logger.LogAbilityDoesNotExist(id);
                    throw new ObjectNotFoundException("The ability you are looking for is not there.");
                }
                this.context.Abilities.Remove(existing);
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
                throw new HeroException("An error occured while deleting the ability.");
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

        public async Task UpdateAbilityAsync(Guid id, Ability updatedAbility, CancellationToken cancellationToken = default)
        {
            try
            {
                Ability? existing = await this.context.Abilities.SingleAsync(a => a.Id == id, cancellationToken);

                if (null == existing)
                {
                    throw new ObjectNotFoundException($"The Ability (id: {id}) you're trying to update does not exist.");
                }

                existing.Update(updatedAbility);

                this.context.Abilities.Update(existing);
                await this.context.SaveChangesAsync(cancellationToken);
            }catch (HeroException ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while updating the ability.");
            }
        }
    }
}
