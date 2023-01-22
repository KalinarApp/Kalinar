namespace Hero.Server.Core.Database
{
    public interface IGroupContextBuilder
    {
        void Apply(Guid groupId);
    }
}
