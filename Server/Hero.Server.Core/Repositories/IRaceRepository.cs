using Hero.Server.Core.Models;

namespace Hero.Server.Core.Repositories
{
    public interface IRaceRepository
    {
        Task<Race?> GetRaceByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<List<Race>> GetAllRacesAsync(CancellationToken cancellationToken = default);
        Task CreateRaceAsync(Race race, CancellationToken cancellationToken = default);
        Task UpdateRaceAsync(Guid id, Race updatedRace, CancellationToken cancellationToken = default);
        Task DeleteRaceAsync(Guid id, CancellationToken cancellationToken = default);
    }
}
