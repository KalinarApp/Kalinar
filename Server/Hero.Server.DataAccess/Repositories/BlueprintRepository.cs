using Hero.Server.Core.Exceptions;
using Hero.Server.Core.Logging;
using Hero.Server.Core.Models;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Database;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace Hero.Server.DataAccess.Repositories
{
    public class BlueprintRepository : IBlueprintRepository
    {
        private readonly HeroDbContext context;
        private readonly IGroupContext group;
        private readonly ILogger<BlueprintRepository> logger;

        public BlueprintRepository(HeroDbContext context, IGroupContext group, ILogger<BlueprintRepository> logger)
        {
            this.context = context;
            this.group = group;
            this.logger = logger;
        }

        private void CleanupNodeIds(Blueprint blueprint)
        {
            foreach (Node node in blueprint.Nodes)
            {
                Guid newId = Guid.NewGuid();
                Guid oldId = node.Id;

                foreach (Guid precessorId in node.Precessors)
                {
                    Node precessor = blueprint.Nodes.Single(node => node.Id == precessorId);
                    precessor.Successors.Remove(oldId);
                    precessor.Successors.Add(newId);
                }
                foreach (Guid successorId in node.Successors)
                {
                    Node successor = blueprint.Nodes.Single(node => node.Id == successorId);
                    successor.Precessors.Remove(oldId);
                    successor.Precessors.Add(newId);
                }

                node.Id = newId;
            }
        }

        public async Task CreateBlueprintAsync(Blueprint blueprint, CancellationToken cancellationToken = default)
        {
            try
            {
                this.CleanupNodeIds(blueprint);

                blueprint.GroupId = this.group.Id;
                await this.context.Blueprints.AddAsync(blueprint, cancellationToken);
                await this.context.SaveChangesAsync(cancellationToken);
                this.logger.LogBlueprintCreated(blueprint.Id);
            }
            catch (Exception ex)
            {
                this.logger.LogBlueprintCreateFailed(blueprint.Id, ex);
                throw new HeroException("An error occured while creating the blueprint.");
            }
        }

        public async Task DeleteBlueprintAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                Blueprint? existing = await this.context.Blueprints.FindAsync(new object[] { id }, cancellationToken);

                if (null == existing)
                {
                    this.logger.LogSkilltreeDoesNotExist(id);
                    throw new ObjectNotFoundException("The blueprint you are looking for could not be found.");
                }

                this.context.Blueprints.Remove(existing);
                await this.context.SaveChangesAsync(cancellationToken);
                this.logger.LogBlueprintDeleted(id);
            }
            catch(HeroException)
            {
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogBlueprintDeleteFailed(id, ex);
                throw new HeroException("An error occured while deleting the blueprint.");
            }
        }

        public Task<List<Blueprint>> GetAllBlueprintsAsync(CancellationToken cancellationToken = default)
        {
            try
            {
                return this.context.Blueprints.Include(print => print.Nodes).ToListAsync(cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting a list of blueprints.");
            }
        }

        public async Task<Blueprint?> GetBlueprintByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                return await this.context.Blueprints
                    .Include(c => c.Nodes).ThenInclude(n => n.Skill).ThenInclude(s => s.Ability)
                    .Include(s => s.Nodes).ThenInclude(n => n.Skill).ThenInclude(s => s.Attributes).ThenInclude(a => a.Attribute)
                    .SingleOrDefaultAsync(print => print.Id == id, cancellationToken);
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting the blueprint.");
            }
        }

        public async Task<Blueprint?> LoadBlueprintByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            try
            {
                Blueprint? blueprint = await this.context.Blueprints
                    .Include(c => c.Nodes).ThenInclude(n => n.Skill).ThenInclude(s => s.Ability)
                    .Include(s => s.Nodes).ThenInclude(n => n.Skill).ThenInclude(s => s.Attributes).ThenInclude(a => a.Attribute)
                    .SingleOrDefaultAsync(print => print.Id == id, cancellationToken);

                if (null == blueprint)
                {
                    this.logger.LogBlueprintNotFound(id);
                    throw new ObjectNotFoundException($"The blueprint (id: {id}) you're trying to load does not exist.");
                }

                this.CleanupNodeIds(blueprint);

                return blueprint;
            }
            catch (HeroException ex)
            {
                throw;
            }
            catch (Exception ex)
            {
                this.logger.LogUnknownErrorOccured(ex);
                throw new HeroException("An error occured while getting the attribute.");
            }
        }

        public async Task UpdateBlueprintAsync(Guid id, Blueprint updatedBlueprint, CancellationToken cancellationToken = default)
        {
            try
            {
                Blueprint? existing = await this.context.Blueprints.Include(print => print.Nodes).SingleOrDefaultAsync(tree => tree.Id == id, cancellationToken);

                if (null == existing)
                {
                    existing = new()
                    {
                        GroupId = group.Id,
                    };
                    this.context.Blueprints.Add(existing);
                }

                existing.Name = updatedBlueprint.Name;

                foreach (Node existingNode in existing.Nodes.Where(node => updatedBlueprint.Nodes.Select(x => x.Id).Contains(node.Id)))
                {
                    Node updatedNode = updatedBlueprint.Nodes.Single(node => existingNode.Id == node.Id);
                    existingNode.Successors = updatedNode.Successors;
                    existingNode.Precessors = updatedNode.Precessors;
                    existingNode.Color = updatedNode.Color;
                    existingNode.Cost = updatedNode.Cost;
                    existingNode.XPos = updatedNode.XPos;
                    existingNode.YPos = updatedNode.YPos;
                    existingNode.Importance = updatedNode.Importance;
                    existingNode.IsEasyReachable = updatedNode.IsEasyReachable;
                    existingNode.SkillId = updatedNode.SkillId;
                }

                existing.Nodes.RemoveAll(node => !updatedBlueprint.Nodes.Select(x => x.Id).Contains(node.Id));
                existing.Nodes.AddRange(updatedBlueprint.Nodes.Where(node => !existing.Nodes.Select(x => x.Id).Contains(node.Id)));

                await this.context.SaveChangesAsync(cancellationToken);
                this.logger.LogBlueprintUpdated(id);
            }
            catch (Exception ex)
            {
                this.logger.LogBlueprintUpdateFailed(id, ex);
                throw new HeroException("An error occured while updating the blueprint.");
            }
        }
    }
}
