namespace Kalinar.Core.Exceptions
{
    public class AbilityNotFoundException : Exception
    {
        public Guid Id { get; }

        public AbilityNotFoundException(Guid id)
            : base($"A ability with id '{id}' does not exist")
        {
            this.Id = id;
        }
    }
}
