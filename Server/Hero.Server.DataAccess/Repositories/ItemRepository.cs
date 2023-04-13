using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Logging;
using Hero.Server.Core.Models.Inventory;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Database;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Hero.Server.DataAccess.Repositories
{
    public class ItemRepository : IItemRepository
    {
        private readonly HeroDbContext context;
        private readonly IGroupContext group;
        private readonly ILogger<ItemRepository> logger;

        public ItemRepository(HeroDbContext context, IGroupContext group, ILogger<ItemRepository> logger)
        {
            this.context = context;
            this.group = group;
            this.logger = logger;
        }

        private async Task<T> ExecuteAsync<T>(Func<Task<T>> action, string error)
        {
            try
            {
                return await action.Invoke();
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException(error);
            }
        } 

        public async Task<List<Item>> GetFilteredItemsAsync(string? queryString, bool? isLocked)
        {
            return await this.ExecuteAsync(async () => 
            {
                IQueryable<Item> query = this.context.Items;

                if (null != isLocked)
                {
                    query = query.Where(item => item.IsLocked == isLocked);
                }

                if (null != queryString)
                {
                    query = query.Where(item => item.Title.ToLower().Contains(queryString.ToLower()) || (null != item.Description && item.Description.ToLower().Contains(queryString.ToLower())));
                }

                return await query.ToListAsync();
            }, "An error occured while getting items.");
        }

        public async Task<List<CharacterItem>> GetInventoryByCharacterIdAsync(Guid charcterId, CancellationToken cancellationToken = default)
        {
            return await this.ExecuteAsync(
                async () => await this.context.CharacterItems
                    .Where(item => item.CharacterId == charcterId)
                    .ToListAsync(cancellationToken),
                "An error occured while getting the inventory."
            );
        }

        public async Task CreateItemAsync(Item item, Guid? characterId, CancellationToken cancellationToken = default)
        {
            await this.ExecuteAsync(async () =>
            {
                item.Id = Guid.NewGuid();
                item.GroupId = this.group.Id;

                this.context.Items.Add(item);

                if (null != characterId)
                {
                    CharacterItem characterItem = new();
                    characterItem.ItemId = item.Id;
                    characterItem.CharacterId = (Guid)characterId;

                    this.context.CharacterItems.Add(characterItem);
                }

                await this.context.SaveChangesAsync(cancellationToken);

                return item;
            }, "An error occured while creating a new item.");
        }
    }
}
