using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

namespace Kalinar.Data.Repositories
{
    internal class StoryEventRepository : BaseGroupRepository<StoryEventEntity>, IStoryEventRepository
    {
        public StoryEventRepository(Context context) : base(context) { }
    }
}
