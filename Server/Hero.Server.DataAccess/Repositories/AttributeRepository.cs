using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Logging;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Database;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

using Attribute = Hero.Server.Core.Models.Attribute;

namespace Hero.Server.DataAccess.Repositories
{
    public class AttributeRepository : IAttributeRepository
    {
        private readonly HeroDbContext context;
        private readonly IGroupContext group;
        private readonly ILogger<AttributeRepository> logger;

        public AttributeRepository(HeroDbContext context, IGroupContext group, ILogger<AttributeRepository> logger)
        {
            this.context = context;
            this.group = group;
            this.logger = logger;
        }

        public async Task<Attribute?> GetAttributeByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Attributes.FirstOrDefaultAsync(g => g.Id == id, cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting attribute.");
            }
        }

        public async Task<List<string>> GetAllCategoriesAsync(string? query, CancellationToken cancellationToken = default)
        {
            try
            {
                List<string> allCategories = await this.context.Attributes.Where(a => !string.IsNullOrEmpty(a.Category)).Select(a => a.Category).Distinct().ToListAsync();
                return string.IsNullOrEmpty(query) 
                    ? allCategories 
                    : allCategories.Where(c => c.Contains(query, StringComparison.InvariantCultureIgnoreCase)).ToList();
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting categories.");
            }
        }

        // This method should only be used for global attributes and never should be used inside a controller, because it ignores every group constraints.
        public async Task CreateIfNotExistsAsync(Attribute attribute, CancellationToken cancellationToken = default)
        {
            try
            {
                if (null == await this.GetAttributeByIdAsync(attribute.Id, cancellationToken))
                {
                    await this.context.Attributes.AddAsync(attribute, cancellationToken);
                    await this.context.SaveChangesAsync(cancellationToken);
                }
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while creating the attribute.");
            }
        }

        public async Task CreateAttributeAsync(Attribute attribute, CancellationToken cancellationToken = default)
        {
            try
            {
                    attribute.GroupId = this.group.Id;
                    await this.context.Attributes.AddAsync(attribute, cancellationToken);
                    await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while creating the attribute.");
            }
        }

        public async Task DeleteAttributeAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                Attribute? existing = await this.GetAttributeByIdAsync(id, cancellationToken);
                if(null == existing)
                {
                    this.logger.LogAttributeDoesNotExist(id);
                    throw new ObjectNotFoundException("The attribute you are looking for could not be found.");
                }
                this.context.Attributes.Remove(existing);
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
                throw new HeroException("An error occured while deleting the attribute.");
            }
        }

        public async Task<List<Attribute>> GetAllAttributesAsync(CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Attributes.ToListAsync(cancellationToken);
            }
            catch (Exception)
            {
                throw new HeroException("An error occured while getting a list of attributes.");
            }
        }

        public async Task<List<Attribute>> GetAllGlobalAttributesAsync(CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Attributes.Where(a => a.GroupId == new Guid()).ToListAsync(cancellationToken);
            }
            catch (Exception)
            {
                throw new HeroException("An error occured while getting a list of attributes.");
            }
        }

        public async Task UpdateAttributeAsync(Guid id, Attribute updatedAttribute, CancellationToken cancellationToken = default)
        {
            try
            {
                Attribute? existing = await this.GetAttributeByIdAsync(id, cancellationToken);

                if (null == existing)
                {
                    throw new ObjectNotFoundException($"The Attribute (id: {id}) you're trying to update does not exist.");
                }
                existing.Update(updatedAttribute);

                this.context.Attributes.Update(existing);
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
                throw new HeroException("An error occured while updating the attribute.");
            }
        }
    }
}
