﻿using Hero.Server.Core;
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
                return await this.context.Abilities.Include(item => item.Group).Include(item => item.Creator).FirstOrDefaultAsync(item => item.Id == id, cancellationToken: cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while fetching this ability");
            }
        }

        public async Task<List<string>> FilterTagsAsync(string? query, CancellationToken cancellationToken = default)
        {
            try
            {
                List<Ability> queryable = await this.context.Abilities.Where(item => item.Tags != null).ToListAsync(cancellationToken);

                IEnumerable<string> tags = queryable.SelectMany(item => item.Tags);

                if (!String.IsNullOrEmpty(query))
                {
                    tags = tags.Where(item => item.ToLower().Contains(query.ToLower()));
                }

                return tags.Distinct().ToList();
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while fetching tags");
            }
        }

        public async Task<List<Ability>> FilterAbilitiesAsync(string? query, SuggestionState[] allowedStates, CancellationToken cancellationToken = default)
        {
            try
            {
                IQueryable<Ability> abilities = this.context.Abilities.Include(item => item.Creator).Where(a => a.GroupId == this.groupContext.Id);

                if (!String.IsNullOrEmpty(query))
                {
                    abilities = abilities.Where(item => item.Name.ToLower().Contains(query.ToLower()) || (null != item.Description && item.Description.ToLower().Contains(query.ToLower())));
                }
                if (allowedStates.Any() && allowedStates.Distinct().Count() != Enum.GetNames(typeof(SuggestionState)).Length)
                {
                    abilities = abilities.Where(item => allowedStates.Contains(item.State));
                }

                return await abilities.ToListAsync(cancellationToken);
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

        public async Task<Ability> TryUpdateAbilityAsync(Guid id, string userId, Ability updated, CancellationToken cancellationToken = default)
        {
            Ability existing = await this.EsureUserIsEnlightableForAction(id, userId, cancellationToken);

            try
            {
                existing.Update(updated);
                if (existing.Group.OwnerId == userId && SuggestionState.Pending == existing.State)
                {
                    existing.State = SuggestionState.Approved;
                    existing.ApprovedAt = DateTime.Now;
                }

                this.context.Abilities.Update(existing);
                await this.context.SaveChangesAsync(cancellationToken);

                return existing;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while updating the ability.");
            }
        }

        public async Task UpdateAbilityTagsAsync(Guid id, List<string> tags, CancellationToken cancellationToken = default)
        {
            Ability? existing = await this.GetAbilityByIdAsync(id, cancellationToken);

            if (null == existing)
            {
                throw new ObjectNotFoundException("Ability not found.");
            }

            try
            {
                existing.Tags = tags;

                this.context.Abilities.Update(existing);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException($"An error occured while updating tags for ability {id}.");
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

        public async Task RejectAbility(Guid id, string reason, CancellationToken cancellationToken = default)
        {
            Ability? ability = await this.GetAbilityByIdAsync(id, cancellationToken);

            if (null == ability)
            {
                throw new ObjectNotFoundException("Ability not found.");
            }
            else if (SuggestionState.Pending != ability.State)
            {
                throw new HeroException("This ability is already approved or rejected and therefore cannot be rejected again.");
            }

            try
            {
                ability.RejectedAt = DateTime.Now;
                ability.RejectionReason = reason;
                ability.State = SuggestionState.Rejected;

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
