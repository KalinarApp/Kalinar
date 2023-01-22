using AutoMapper;

using Hero.Server.Core.Repositories;
using Hero.Server.Identity;
using Hero.Server.Identity.Attributes;
using Hero.Server.Messages.Requests;
using Hero.Server.Messages.Responses;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

using Attribute = Hero.Server.Core.Models.Attribute;

namespace Hero.Server.Controllers
{
    [ApiController, Authorize, Route("api/[controller]")]
    public class AttributesController : HeroControllerBase
    {
        private readonly IAttributeRepository repository;
        private readonly IUserRepository userRepository;
        private readonly IMapper mapper;

        public AttributesController(IAttributeRepository repository, IUserRepository userRepository, IMapper mapper, ILogger<AttributesController> logger)
            : base(logger)
        {
            this.repository = repository;
            this.userRepository = userRepository;
            this.mapper = mapper;
        }

        [ApiExplorerSettings(IgnoreApi = true), NonAction, Route("/error")]
        public IActionResult HandleError() => this.HandleErrors();

        [HttpGet("{id}"), IsGroupAdmin]
        public async Task<IActionResult> GetAttributeByIdAsync(Guid id)
        {
            Attribute? attribute = await this.repository.GetAttributeByIdAsync(id);

            if (attribute != null)
            {
                return this.Ok(this.mapper.Map<AttributeResponse>(attribute));
            }

            return this.NotFound();
        }

        [HttpGet, IsGroupAdmin]
        public async Task<IActionResult> GetAllAttributesAsync()
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId());

            List<Attribute> attributes = await this.repository.GetAllAttributesAsync();

            return this.Ok(attributes.Select(attribute => this.mapper.Map<AttributeResponse>(attribute)).ToList());
        }

        [HttpGet("global"), IsGroupAdmin]
        public async Task<IActionResult> GetAllGlobalAttributesAsync()
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId());

            List<Attribute> attributes = await this.repository.GetAllGlobalAttributesAsync();

            return this.Ok(attributes.Select(attribute => this.mapper.Map<AttributeResponse>(attribute)).ToList());
        }

        
        [HttpGet("categories"), IsGroupAdmin]
        public async Task<IActionResult> GetAllExistingCategoriesAsync([FromQuery]string? query, CancellationToken cancellationToken)
        {
            List<string> categories = await this.repository.GetAllCategoriesAsync(query, cancellationToken);

            return this.Ok(categories);
        }

        [HttpDelete("{id}"), IsGroupAdmin]
        public async Task<IActionResult> DeleteAttributeAsync(Guid id)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId());

            await this.repository.DeleteAttributeAsync(id);

            return this.Ok();
        }

        [HttpPut("{id}"), IsGroupAdmin]
        public async Task<IActionResult> UpdateAttributeAsync(Guid id, [FromBody] AttributeRequest request)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId());

            Attribute attribute = this.mapper.Map<Attribute>(request);
            await this.repository.UpdateAttributeAsync(id, attribute);

            return this.Ok(this.mapper.Map<AttributeResponse>(attribute));
        }

        [HttpPost, IsGroupAdmin]
        public async Task<IActionResult> CreateAttributeAsync([FromBody] AttributeRequest request)
        {
            await userRepository.IsOwner(this.HttpContext.User.GetUserId());

            Attribute attribute = this.mapper.Map<Attribute>(request);
            await this.repository.CreateAttributeAsync(attribute);

            return this.Ok(this.mapper.Map<AttributeResponse>(attribute));
        }

    }
}
