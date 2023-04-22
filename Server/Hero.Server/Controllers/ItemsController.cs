using AutoMapper;

using Hero.Server.Core.Models.Inventory;
using Hero.Server.Core.Repositories;
using Hero.Server.Identity;
using Hero.Server.Identity.Attributes;
using Hero.Server.Messages.Requests;
using Hero.Server.Messages.Responses;

using Microsoft.AspNetCore.Mvc;

namespace Hero.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ItemsController : ControllerBase
    {
        private readonly IItemRepository repository;
        private readonly IMapper mapper;
        private readonly ILogger<ItemsController> logger;

        public ItemsController(IItemRepository repository, IMapper mapper, ILogger<ItemsController> logger)
        {
            this.repository = repository;
            this.mapper = mapper;
            this.logger = logger;
        }

        private Item GetItem(ItemRequest request)
        {
            switch (request.Type)
            {
                case nameof(Weapon):
                    return this.mapper.Map<Weapon>(request);
                case nameof(Item):
                default:
                    return this.mapper.Map<Item>(request);
            }
        }

        [HttpGet, IsGroupMember]
        public async Task<List<ItemResponse>> GetFilteredItemsAsync([FromQuery] string? query, [FromQuery] bool? isLocked)
        {
            List<Item> items =  await this.repository.GetFilteredItemsAsync(query, isLocked);

            return items.Select(item => this.mapper.Map<ItemResponse>(item)).ToList();
        }

        [HttpPost, IsGroupMember]
        public async Task<ItemResponse> CreateItemAsync([FromBody] ItemRequest request, CancellationToken cancellationToken)
        {
            Item item = this.GetItem(request);
            item.CreatorId = this.HttpContext.User.GetUserId();

            await this.repository.CreateItemAsync(item, request.CharacterId, cancellationToken);

            return this.mapper.Map<ItemResponse>(item);
        }
    }
}
