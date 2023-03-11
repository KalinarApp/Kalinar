using Hero.Server.Core.Models;

namespace Hero.Server.Core.Repositories
{
    public interface IRaceRepository
    {
        Task<Race?> GetRaceByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<List<Race>> FilterRacesAsync(string? query, SuggestionState[] suggestionStates, CancellationToken token);
        Task CreateRaceAsync(Race race, CancellationToken cancellationToken = default);
        Task TryUpdateRaceAsync(Guid id, string userId, Race updatedRace, CancellationToken cancellationToken = default);
        Task TryDeleteRaceAsync(Guid id, string v, CancellationToken cancellationToken);

        Task RejectRaceAsync(Guid id, string reason, CancellationToken cancellationToken);
    }
}
