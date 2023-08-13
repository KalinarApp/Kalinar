using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Core.Exceptions;
using Kalinar.Data.Database;
using Kalinar.Data.Extensions;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    internal class SkilltreeRepository : BaseGroupRepository<SkilltreeEntity>, ISkilltreeRepository
    {
        public SkilltreeRepository(Context context) : base(context) { }

        public async Task<IEnumerable<SkilltreeNodeEntity>> ListNodesAsync(Guid skilltreeId, CancellationToken cancellationToken = default)
        {
            return await this.context.SkilltreeNodes.Include(item => item.Skill).Where(item => item.SkilltreeId == skilltreeId).ToListAsync(cancellationToken);
        }

        public async Task<IEnumerable<SkilltreeEdgeEntity>> ListEdgesAsync(Guid skilltreeId, CancellationToken cancellationToken = default)
        {
            return await this.context.SkilltreeEdges.Where(item => item.SkilltreeId == skilltreeId).ToListAsync(cancellationToken);
        }

        public async Task<SkilltreeNodeEntity?> FindNodeByIdAsync(Guid id, CancellationToken cancellationToken = default)
        {
            return await this.context.SkilltreeNodes.Include(item => item.Skill).FirstOrDefaultAsync(item => item.Id == id, cancellationToken);
        }

        public async Task<SkilltreeEdgeEntity?> FindEdgeByStartAndEndIdAsync(Guid startId, Guid endId, CancellationToken cancellationToken = default)
        {
            return await this.context.SkilltreeEdges.FirstOrDefaultAsync(item => item.StartId == startId && item.EndId == endId, cancellationToken);
        }

        public async Task<SkilltreeNodeEntity> CreateNodeAsync(SkilltreeNodeEntity node, CancellationToken cancellationToken = default)
        {
            await this.context.SkilltreeNodes.AddAsync(node, cancellationToken);
            await this.context.SaveChangesAsync(cancellationToken);

            return node;
        }

        public async Task<SkilltreeEdgeEntity> CreateEdgeAsync(SkilltreeEdgeEntity edge, CancellationToken cancellationToken = default)
        {
            await this.context.SkilltreeEdges.AddAsync(edge, cancellationToken);
            await this.context.SaveChangesAsync(cancellationToken);
            return edge;
        }

        public async Task<SkilltreeNodeEntity> UpdateNodeAsync(SkilltreeNodeEntity node, CancellationToken cancellationToken = default)
        {
            this.context.SkilltreeNodes.Update(node);
            await this.context.SaveChangesAsync(cancellationToken);
            return node;
        }

        public async Task<SkilltreeEntity> CopyByIdAsync(Guid skilltreeId, CancellationToken cancellationToken = default)
        {
            SkilltreeEntity skilltree = await this.context.Skilltrees.Include(item => item.Nodes).Include(item => item.Edges).FirstOrDefaultAsync(item => item.Id == skilltreeId, cancellationToken) ?? throw new SkilltreeNotFoundException(skilltreeId);

            this.context.Entry(skilltree).State = EntityState.Detached;

            SkilltreeEntity newSkilltree = skilltree.Copy();

            await this.context.Skilltrees.AddAsync(newSkilltree, cancellationToken);
            await this.context.SaveChangesAsync(cancellationToken);

            return newSkilltree;
        }

        public async Task DeleteNodeAsync(SkilltreeNodeEntity node, CancellationToken cancellationToken = default)
        {
            this.context.SkilltreeNodes.Remove(node);
            await this.context.SaveChangesAsync(cancellationToken);
        }

        public async Task DeleteEdgeAsync(SkilltreeEdgeEntity edge, CancellationToken cancellationToken = default)
        {
            this.context.SkilltreeEdges.Remove(edge);
            await this.context.SaveChangesAsync(cancellationToken);
        }
    }
}
