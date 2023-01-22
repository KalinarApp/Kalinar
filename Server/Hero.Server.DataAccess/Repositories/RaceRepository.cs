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
        private readonly IUserRepository userRepository;
        private readonly IGroupContext group;
        private readonly ILogger<RaceRepository> logger;

        public RaceRepository(HeroDbContext context, IUserRepository userRepository, IGroupContext group, ILogger<RaceRepository> logger)
        {
            this.context = context;
            this.userRepository = userRepository;
            this.group = group;
            this.logger = logger;
        }

        public async Task<Race?> GetRaceByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Races.Include(r => r.Attributes).ThenInclude(ar => ar.Attribute).FirstOrDefaultAsync(g => g.Id == id, cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting race.");
            }
        }

        public async Task CreateRaceAsync(Race race, CancellationToken cancellationToken = default)
        {
            try
            {
                race.GroupId = group.Id;
                race.Id = Guid.NewGuid();
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

        public async Task DeleteRaceAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                Race? existing = await this.GetRaceByIdAsync(id, cancellationToken);
                if(null == existing)
                {
                    this.logger.LogRaceDoesNotExist(id);
                    throw new ObjectNotFoundException($"The race (id: {id}) you're trying to delete does not exist.");
                }
                this.context.Races.Remove(existing);
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
                throw new HeroException("An error occured while deleting race.");
            }
        }

        public async Task<List<Race>> GetAllRacesAsync(CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Races.Include(r => r.Attributes).ThenInclude(ar => ar.Attribute).ToListAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting a list of races.");
            }
        }

        public async Task UpdateRaceAsync(Guid id, Race updatedRace, CancellationToken cancellationToken = default)
        {
            try
            {
                Race? existing = await this.GetRaceByIdAsync(id, cancellationToken);

                if (null == existing)
                {
                    throw new ObjectNotFoundException($"The Race (id: {id}) you're trying to update does not exist.");
                }

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
            }
            catch (HeroException ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while updating race.");
            }
        }
    }
}
