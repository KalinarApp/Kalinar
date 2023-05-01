using Hero.Server.Core.Models.Inventory;

namespace Hero.Server.Core.Repositories
{
    public interface IItemRepository
    {
        Task CreateItemAsync(Item item, Guid? characterId, CancellationToken cancellationToken = default);
        Task<List<Item>> GetFilteredItemsAsync(string? queryString, bool? isLocked);
        Task<List<CharacterItem>> GetInventoryByCharacterIdAsync(Guid charcterId, CancellationToken cancellationToken = default);
    }
}
