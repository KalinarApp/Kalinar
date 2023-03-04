using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Logging;
using Hero.Server.Core.Models;
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

        private async Task<Attribute> EsureUserIsEnlightableForAction(Guid id, string userId, CancellationToken cancellationToken = default)
        {
            Attribute? existing = await this.GetAttributeByIdAsync(id, cancellationToken);

            if (existing == null)
            {
                throw new ObjectNotFoundException("The attribute you are looking for does not exist.");
            }
            else if (null == existing || !existing.IsOwnerOrAdmin(userId))
            {
                throw new AccessForbiddenException("You are neither the creator of this attribute nor an admin.");
            }

            return existing;
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
                return String.IsNullOrEmpty(query) 
                    ? allCategories 
                    : allCategories.Where(c => c.Contains(query, StringComparison.InvariantCultureIgnoreCase)).ToList();
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting categories.");
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

        public async Task TryUpdateAttributeAsync(Guid id, string userId, Attribute updatedAttribute, CancellationToken cancellationToken = default)
        {
            Attribute existing = await this.EsureUserIsEnlightableForAction(id, userId, cancellationToken);

            try
            {
                existing.Update(updatedAttribute);

                this.context.Attributes.Update(existing);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while updating the attribute.");
            }
        }

        public async Task TryDeleteAttributeAsync(Guid id, string userId, CancellationToken cancellationToken = default)
        {
            Attribute existing = await this.EsureUserIsEnlightableForAction(id, userId, cancellationToken);

            try
            {
                this.context.Attributes.Remove(existing);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while deleting the attribute.");
            }
        }

        public async Task ApproveAttribute(Guid id, CancellationToken cancellationToken = default)
        {
            Attribute? attribute = await this.GetAttributeByIdAsync(id, cancellationToken);

            if (null == attribute)
            {
                throw new ObjectNotFoundException("Attribute not found.");
            }

            try
            {
                attribute.ApprovedAt = DateTime.Now;
                attribute.State = SuggestionState.Approved;

                this.context.Attributes.Update(attribute);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error ccoured while approving the attribute.");
            }
        }

        public async Task RejectAttribute(Guid id, string reason, CancellationToken cancellationToken = default)
        {
            Attribute? attribute = await this.GetAttributeByIdAsync(id, cancellationToken);

            if (null == attribute)
            {
                throw new ObjectNotFoundException("Attribute not found.");
            }

            try
            {
                attribute.RejectedAt = DateTime.Now;
                attribute.RejectionReason = reason;
                attribute.State = SuggestionState.Approved;

                this.context.Attributes.Update(attribute);
                await this.context.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error ccoured while approving the attribute.");
            }
        }
    }
}
