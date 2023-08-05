namespace Kalinar.Core.Exceptions
{
    public class RaceNotFoundException : Exception
    {
        public Guid Id { get; }

        public RaceNotFoundException(Guid id)
            : base($"A race with id '{id}' does not exist")
        {
            this.Id = id;
        }
    }
}
