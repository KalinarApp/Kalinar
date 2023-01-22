using Hero.Server.Core;
using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Logging;
using Hero.Server.Core.Models;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Database;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Hero.Server.DataAccess.Repositories
{
    public class CharacterRepository : ICharacterRepository
    {
        private readonly HeroDbContext context;
        private readonly IGroupContext group;
        private readonly IUserRepository userRepository;
        private readonly ILogger<CharacterRepository> logger;

        public CharacterRepository(HeroDbContext context, IGroupContext group, IUserRepository userRepository, ILogger<CharacterRepository> logger)
        {
            this.context = context;
            this.group = group;
            this.userRepository = userRepository;
            this.logger = logger;
        }

        public async Task EnsureIsOwner(Guid id, string userId, CancellationToken cancellationToken = default)
        {
            Character? character = await this.context.Characters.SingleOrDefaultAsync(c => c.Id == id);
            if (null == character || character.UserId != userId)
            {
                throw new CharacterAccessViolationException("You are not the owner of this character and therefore cannot edit it in any way.");
            }
        }

        public async Task<Character?> GetCharacterByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Characters.FindAsync(new object[] { id }, cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting the blueprint.");
            }
        }

        public async Task<List<Character>> GetCharactersAsync(string? userId, CancellationToken cancellationToken = default)
        {
            try
            {
                if (null == userId)
                {
                    return await this.context.Characters.ToListAsync(cancellationToken);
                }

                return await this.context
                    .Characters
                    .Where(c => c.UserId == userId || c.IsPublic)
                    .ToListAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting a list of characters.");
            }
        }

        public async Task<Character?> GetCharacterWithNestedByIdAsync(Guid id, CancellationToken? cancellationToken = default)
        {
            try
            {
                return await this.context.Characters
                    .Include(c => c.Skilltrees).ThenInclude(c => c.Nodes).ThenInclude(n => n.Skill).ThenInclude(s => s.Ability)
                    .Include(c => c.Skilltrees).ThenInclude(s => s.Nodes).ThenInclude(n => n.Skill).ThenInclude(s => s.Attributes).ThenInclude(a => a.Attribute)
                    .Include(c => c.Race).ThenInclude(r => r.Attributes).ThenInclude(ar => ar.Attribute)
                    .FirstOrDefaultAsync(c => c.Id == id);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting a list of blueprints.");
            }
        }

        public async Task CreateCharacterAsync(Character character, string userId, CancellationToken cancellationToken = default)
        {
            try
            {
                character.UserId = userId;
                character.GroupId = this.group.Id;

                await this.context.Characters.AddAsync(character, cancellationToken);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while creating the character");
            }
        }

        public async Task DeleteCharacterAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                Character? existing = await this.GetCharacterByIdAsync(id, cancellationToken);

                if(null == existing)
                {
                    this.logger.LogCharacterDoesNotExist(id);
                    return;
                }
                this.context.Characters.Remove(existing);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while deleting the character");
            }
        }

        public async Task UpdateCharacterAsync(Guid id, Character updatedCharacter, CancellationToken cancellationToken = default)
        {
            try
            {
                Character? existing = await this.GetCharacterByIdAsync(id, cancellationToken);

                if (null == existing)
                {
                    throw new ObjectNotFoundException($"The character (id: {id}) you're trying to update does not exist.");
                }

                existing.Update(updatedCharacter);

                this.context.Characters.Update(existing);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (HeroException ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while updating the character.");
            }
        }
    }
}
