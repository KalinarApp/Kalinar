using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Logging;
using Hero.Server.Core.Models;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Database;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Hero.Server.DataAccess.Repositories
{
    public class RaceRepository : IRaceRepository
    {
        private readonly HeroDbContext context;
        private readonly IGroupContext group;
        private readonly ILogger<RaceRepository> logger;

        public RaceRepository(HeroDbContext context, IGroupContext group, ILogger<RaceRepository> logger)
        {
            this.context = context;
            this.group = group;
            this.logger = logger;
        }

        private async Task<Race> EsureUserIsEnlightableForAction(Guid id, string userId, CancellationToken cancellationToken = default)
        {
            Race? existing = await this.GetRaceByIdAsync(id, cancellationToken);

            if (existing == null)
            {
                throw new ObjectNotFoundException("The race you are looking for does not exist.");
            }
            else if (null == existing || !existing.IsOwnerOrAdmin(userId))
            {
                throw new AccessForbiddenException("You are neither the creator of this race nor an admin.");
            }

            return existing;
        }

        public async Task<Race?> GetRaceByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Races
                    .Include(r => r.Creator)
                    .Include(r => r.Attributes)
                        .ThenInclude(ar => ar.Attribute)
                        .ThenInclude(a => a.Creator)
                    .FirstOrDefaultAsync(g => g.Id == id, cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting race.");
            }
        }

        public async Task<List<Race>> FilterRacesAsync(string? query, SuggestionState[] allowedStates, CancellationToken cancellationToken = default)
        {
            try
            {
                IQueryable<Race> races = this.context.Races.Include(item => item.Creator).Where(a => a.GroupId == this.group.Id);

                if (!String.IsNullOrEmpty(query))
                {
                    races = races.Where(item => item.Name.ToLower().Contains(query.ToLower()) || (null != item.Description && item.Description.ToLower().Contains(query.ToLower())));
                }
                if (allowedStates.Any() && allowedStates.Distinct().Count() != Enum.GetNames(typeof(SuggestionState)).Length)
                {
                    races = races.Where(item => allowedStates.Contains(item.State));
                }

                return await races.ToListAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting a list of races.");
            }
        }

        public async Task CreateRaceAsync(Race race, CancellationToken cancellationToken = default)
        {
            try
            {
                race.GroupId = group.Id;

                race.Attributes.ForEach(ats => ats.RaceId = race.Id);

                await this.context.Races.AddAsync(race, cancellationToken);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while creating race.");
            }
        }

        public async Task TryDeleteRaceAsync(Guid id, string userId, CancellationToken cancellationToken = default)
        {
            Race existing = await this.EsureUserIsEnlightableForAction(id, userId, cancellationToken);

            try
            {
                this.context.Races.Remove(existing);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while deleting race.");
            }
        }

        public async Task TryUpdateRaceAsync(Guid id, string userId, Race updatedRace, CancellationToken cancellationToken = default)
        {
            Race existing = await this.EsureUserIsEnlightableForAction(id, userId, cancellationToken);

            try
            {
                existing.Update(updatedRace);

                foreach (AttributeRace existingAttributeRace in existing.Attributes.Where(ats => updatedRace.Attributes.Select(x => (x.RaceId, x.AttributeId)).Contains((ats.RaceId, ats.AttributeId))))
                {
                    AttributeRace updatedAttributeRace = updatedRace.Attributes.Single(ats => existingAttributeRace.RaceId == ats.RaceId && existingAttributeRace.AttributeId == ats.AttributeId);
                    existingAttributeRace.Value = updatedAttributeRace.Value;
                }

                existing.Attributes.RemoveAll(ats => !updatedRace.Attributes.Select(x => (x.RaceId, x.AttributeId)).Contains((ats.RaceId, ats.AttributeId)));
                existing.Attributes.AddRange(updatedRace.Attributes.Where(ats => !existing.Attributes.Select(x => (x.RaceId, x.AttributeId)).Contains((ats.RaceId, ats.AttributeId))));

                this.context.Races.Update(existing);
                await this.context.SaveChangesAsync(cancellationToken);

                if (existing.Group.OwnerId == userId && SuggestionState.Pending == existing.State)
                {
                    existing.State = SuggestionState.Approved;
                    existing.ApprovedAt = DateTime.Now;

                    foreach (AttributeRace item in existing.Attributes.Where(item => item.Attribute.State != SuggestionState.Approved))
                    {
                        item.Attribute.State = SuggestionState.Approved;
                        item.Attribute.ApprovedAt = existing.ApprovedAt;
                    }
                }

                this.context.Races.Update(existing);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while updating race.");
            }
        }

        public async Task RejectRaceAsync(Guid id, string reason, CancellationToken cancellationToken = default)
        {
            Race? race = await this.GetRaceByIdAsync(id, cancellationToken);

            if (null == race)
            {
                throw new ObjectNotFoundException("Race not found.");
            }
            else if (SuggestionState.Pending != race.State)
            {
                throw new HeroException("This race is already approved or rejected and therefore cannot be rejected again.");
            }

            try
            {
                race.RejectedAt = DateTime.Now;
                race.RejectionReason = reason;
                race.State = SuggestionState.Rejected;

                this.context.Races.Update(race);
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
