using Hero.Server.Core.Models;

namespace Hero.Server.Core.Repositories
{
    public interface ICharacterRepository
    {
        Task EnsureIsOwner(Guid id, string userId, CancellationToken cancellationToken = default);
        Task<List<Character>> GetCharactersAsync(string? userId, CancellationToken cancellationToken = default);
        Task CreateCharacterAsync(Character character, string userId, CancellationToken cancellationToken = default);
        Task UpdateCharacterAsync(Guid id, Character updatedCharacter, CancellationToken cancellationToken = default);
        Task DeleteCharacterAsync(Guid id, CancellationToken cancellationToken = default);
        Task<Character?> GetCharacterByIdAsync(Guid id, CancellationToken cancellationToken = default);
        Task<Character?> GetCharacterWithNestedByIdAsync(Guid id, CancellationToken? cancellationToken = null);
    }
}
