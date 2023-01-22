namespace Hero.Server.DataAccess.Database
{
    public interface IGroupContext
    {
        public const string Header = "x-kalinar-group";
        Guid Id { get; }
    }
}