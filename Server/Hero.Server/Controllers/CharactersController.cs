﻿using AutoMapper;

using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Models;
using Hero.Server.Core.Models.Inventory;
using Hero.Server.Core.Repositories;
using Hero.Server.Identity;
using Hero.Server.Identity.Attributes;
using Hero.Server.Messages.Requests;
using Hero.Server.Messages.Responses;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Hero.Server.Controllers
{
    [ApiController, Authorize, Route("api/[controller]")]
    public class CharactersController : HeroControllerBase
    {
        private readonly ICharacterRepository repository;
        private readonly IItemRepository itemRepository;
        private readonly IUserRepository userRepository;
        private readonly IMapper mapper;

        public CharactersController(ICharacterRepository repository, IItemRepository itemRepository, IUserRepository userRepository, IMapper mapper, ILogger<CharactersController> logger)
            : base(logger)
        {
            this.repository = repository;
            this.itemRepository = itemRepository;
            this.userRepository = userRepository;
            this.mapper = mapper;
        }

        [ApiExplorerSettings(IgnoreApi = true), NonAction, Route("/error")]
        public IActionResult HandleError() => this.HandleErrors();

        [HttpGet("{id}"), IsGroupMember]
        public async Task<IActionResult> GetCharacterDetailByIdAsync(Guid id, CancellationToken token)
        {
            Character? character = await this.repository.GetCharacterWithNestedByIdAsync(id, token);

            if (character != null)
            {
                CharacterDetailResponse response = this.HttpContext.User.GetUserId() == character.UserId 
                    || await this.userRepository.IsOwner(this.HttpContext.User.GetUserId())
                        ? this.mapper.Map<CharacterDetailResponse>(character) 
                        : this.mapper.Map<SharedCharacterDetailResponse>(character);

                return this.Ok(response);
            }

            return this.NotFound();
        }

        [HttpGet, IsGroupMember]
        public async Task<List<CharacterOverviewResponse>> GetCharacterOverviewsAsync([FromQuery] bool? isOwner, CancellationToken token)
        {
            List<Character> characters;
            string userId = this.HttpContext.User.GetUserId();


            characters = await this.repository.GetCharactersAsync(userId, await this.userRepository.IsOwner(userId, token), isOwner, token);

            return characters.Select(character => this.mapper.Map<CharacterOverviewResponse>(character)).ToList();
        }

        [HttpGet("{id}/inventory"), IsGroupMember] 
        public async Task<List<CharacterItemResponse>> GetInventoryAsync(Guid id, CancellationToken cancellationToken)
        {
            string userId = this.HttpContext.User.GetUserId();
            Character? character = await this.repository.GetCharacterByIdAsync(id, cancellationToken);

            if (null == character || userId != character.UserId || await this.userRepository.IsOwner(userId, cancellationToken) || !character.IsPublic || character.ShareInventory == false)
            {
                throw new ObjectNotFoundException("The inventory for this character could not be found.");
            }

            List<CharacterItem> inventory = await this.itemRepository.GetInventoryByCharacterIdAsync(id, cancellationToken);

            return inventory.Select(item => this.mapper.Map<CharacterItemResponse>(item)).ToList();
        }

        [HttpDelete("{id}"), IsGroupMember]
        public async Task<IActionResult> DeleteCharacterAsync(Guid id, CancellationToken token)
        {
            await this.repository.EnsureIsOwner(id, this.HttpContext.User.GetUserId());
            await this.repository.DeleteCharacterAsync(id, token);

            return this.Ok();
        }

        [HttpPut("{id}"), IsGroupMember]
        public async Task<CharacterDetailResponse> UpdateCharacterAsync(Guid id, [FromBody] CharacterRequest request, CancellationToken token)
        {
            Character character = this.mapper.Map<Character>(request);

            await this.repository.EnsureIsOwner(id, this.HttpContext.User.GetUserId());
            character = await this.repository.UpdateCharacterAsync(id, character, token);

            return this.mapper.Map<CharacterDetailResponse>(character);
        }

        [HttpPost, IsGroupMember]
        public async Task<CharacterOverviewResponse> CreateCharacterAsync([FromBody] CharacterRequest request, CancellationToken token)
        {
            Character character = this.mapper.Map<Character>(request);

            await this.repository.CreateCharacterAsync(character, this.HttpContext.User.GetUserId(), token);

            return this.mapper.Map<CharacterOverviewResponse>(character);
        }

        [HttpPatch("{id}"), IsGroupMember]
        public async Task<CharacterDetailResponse> UpdateInventoryAsync(Guid id, [FromBody] CharacterUpdateRequest request, CancellationToken token)
        {
            await this.repository.EnsureIsOwner(id, this.HttpContext.User.GetUserId());

            Character? character = await this.repository.GetCharacterByIdAsync(id, token);

            if (null == character)
            {
                throw new ObjectNotFoundException("The character you are looking for could not be found.");
            }

            character.Name = request.Name ?? character.Name;
            character.Description = request.Description ?? character.Description;
            character.Age = request.Age ?? character.Age;
            character.Inventory = request.Inventory ?? character.Inventory;
            character.Religion = request.Religion ?? character.Religion;
            character.Religion = request.Religion ?? character.Religion;
            character.Relationship = request.Relationship ?? character.Relationship;
            character.Notes = request.Notes ?? character.Notes;
            character.Profession = request.Profession ?? character.Profession;
            character.IconUrl = request.IconUrl ?? character.IconUrl;

            character.IsPublic = request.IsPublic ?? character.IsPublic;
            character.ShareAbilities = request.ShareAbilities ?? character.ShareAbilities;
            character.ShareAttributes = request.ShareAttributes ?? character.ShareAttributes;
            character.ShareSkilltree = request.ShareSkilltree ?? character.ShareSkilltree;
            character.ShareNotes = request.ShareNotes ?? character.ShareNotes;
            character.ShareInventory = request.ShareInventory ?? character.ShareInventory;

            character = await this.repository.UpdateCharacterAsync(id, character, token);

            return this.mapper.Map<CharacterDetailResponse>(character);
        }
    }
}
