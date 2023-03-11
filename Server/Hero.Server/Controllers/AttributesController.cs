using AutoMapper;
using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Models;
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
        [ProducesErrorResponseType(typeof(HeroException))]
        public async Task<List<AttributeResponse>> FilterAttributesAsync([FromQuery] string? query, [FromQuery] bool? onlyGlobal, [FromQuery] SuggestionState[]? allowedStates, CancellationToken token)
        {
            List<Attribute> attributes = await this.repository.FilterAttributesAsync(query, onlyGlobal, allowedStates ?? Array.Empty<SuggestionState>(), token);
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
            await this.repository.TryDeleteAttributeAsync(id, this.HttpContext.User.GetUserId());
        }

        [HttpPut("{id}"), IsGroupMember]
        public async Task<AttributeResponse> UpdateAttributeAsync(Guid id, [FromBody] AttributeRequest request, CancellationToken cancellationToken)
        {
            Attribute attribute = this.mapper.Map<Attribute>(request);
            attribute = await this.repository.TryUpdateAttributeAsync(id, this.HttpContext.User.GetUserId(), attribute, cancellationToken);

            return this.mapper.Map<AttributeResponse>(attribute);
        }

        [HttpPost, IsGroupMember]
        public async Task<AttributeResponse> CreateAttributeAsync([FromBody] AttributeRequest request, CancellationToken cancellationToken)
        {
            string userId = this.HttpContext.User.GetUserId();
            Attribute attribute = this.mapper.Map<Attribute>(request);

            attribute.CreatorId = userId;
            if (await userRepository.IsOwner(userId, cancellationToken))
            {
                attribute.State = SuggestionState.Approved;
                attribute.ApprovedAt = DateTime.Now;
            }

            await this.repository.CreateAttributeAsync(attribute, cancellationToken);

            return this.mapper.Map<AttributeResponse>(attribute);
        }

        [HttpPost("{id}/reject"), IsGroupAdmin]
        public async Task RejectAttributeAsync(Guid id, [FromBody] SuggestionRejectionRequest request, CancellationToken cancellationToken)
        {
            await this.repository.RejectAttribute(id, request.Reason, cancellationToken);
        }
    }
}
