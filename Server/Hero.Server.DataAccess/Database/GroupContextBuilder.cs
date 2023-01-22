using Hero.Server.Core.Database;

namespace Hero.Server.DataAccess.Database
{
    public class GroupContextBuilder : IGroupContextBuilder
    {
        private readonly GroupContext context;

        public GroupContextBuilder(GroupContext context)
        {
            this.context = context;
        }

        public void Apply(Guid groupId)
        {
            this.context.Id = groupId;
        }
    }
}
