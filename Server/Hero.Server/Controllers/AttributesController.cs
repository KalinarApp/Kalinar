using AutoMapper;
using Hero.Server.Core.Exceptions;
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

        [HttpGet("{id}"), IsGroupMember]
        public async Task<AttributeResponse> GetAttributeByIdAsync(Guid id)
        {
            Attribute? attribute = await this.repository.GetAttributeByIdAsync(id);

            if (attribute == null)
            {
                throw new ObjectNotFoundException("No Attribute found.");
            }

            return this.mapper.Map<AttributeResponse>(attribute);
        }

        [HttpGet, IsGroupMember]
        public async Task<List<AttributeResponse>> GetAllAttributesAsync()
        {
            List<Attribute> attributes = await this.repository.GetAllAttributesAsync();
            return attributes.Select(attribute => this.mapper.Map<AttributeResponse>(attribute)).ToList();
        }

        [HttpGet("global"), IsGroupMember]
        public async Task<List<AttributeResponse>> GetAllGlobalAttributesAsync()
        {
            List<Attribute> attributes = await this.repository.GetAllGlobalAttributesAsync();

            return attributes.Select(attribute => this.mapper.Map<AttributeResponse>(attribute)).ToList();
        }

        
        [HttpGet("categories"), IsGroupMember]
        public async Task<List<string>> GetAllExistingCategoriesAsync([FromQuery]string? query, CancellationToken cancellationToken)
        {
            return await this.repository.GetAllCategoriesAsync(query, cancellationToken);
        }

        [HttpDelete("{id}"), IsGroupMember]
        public async Task DeleteAttributeAsync(Guid id)
        {
            await this.repository.DeleteAttributeAsync(id);
        }

        [HttpPut("{id}"), IsGroupMember]
        public async Task<AttributeResponse> UpdateAttributeAsync(Guid id, [FromBody] AttributeRequest request)
        {
            Attribute attribute = this.mapper.Map<Attribute>(request);
            await this.repository.UpdateAttributeAsync(id, attribute);

            return this.mapper.Map<AttributeResponse>(attribute);
        }

        [HttpPost, IsGroupAdmin]
        public async Task<AttributeResponse> CreateAttributeAsync([FromBody] AttributeRequest request)
        {
            Attribute attribute = this.mapper.Map<Attribute>(request);
            await this.repository.CreateAttributeAsync(attribute);

            return this.mapper.Map<AttributeResponse>(attribute);
        }

        [HttpPost("{id}/approve"), IsGroupAdminAttribute]
        public async Task ApproveAttributeAsync(Guid id, CancellationToken cancellationToken)
        {
            await this.repository.ApproveAttribute(id, cancellationToken);
        }

        [HttpPost("{id}/reject"), IsGroupAdminAttribute]
        public async Task RejectAttributeAsync(Guid id, [FromBody] SuggestionRejectionRequest request, CancellationToken cancellationToken)
        {
            await this.repository.RejectAttribute(id, request.Reason, cancellationToken);
        }
    }
}
