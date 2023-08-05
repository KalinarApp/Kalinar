using Kalinar.Application.Contracts;
using Kalinar.Core.Entities;
using Kalinar.Data.Database;

namespace Kalinar.Data.Repositories
{
    internal class StoryImageRepository : BaseGroupRepository<StoryImageEntity>, IStoryImageRepository
    {
        public StoryImageRepository(Context context) : base(context) { }
    }
}
