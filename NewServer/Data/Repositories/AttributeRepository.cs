using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Repositories
{
    internal class AttributeRepository : BaseGroupRepository<AttributeEntity>, IAttributeRepository
    {
        public AttributeRepository(Context context) : base(context) { }

        public async Task<IEnumerable<string>> ListCategoriesAsync(Guid groupId, CancellationToken cancellationToken = default)
        {
            return await context.Attributes
                .Where(item => item.GroupId == groupId && item.Category != null)
                .Select(item => item.Category)
                .Distinct()
                .Cast<string>()
                .ToListAsync(cancellationToken);
        }
    }
}
