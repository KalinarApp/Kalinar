namespace Kalinar.Core.Exceptions
{
    public class SkilltreeNotFoundException : Exception
    {
        public Guid Id { get; }

        public SkilltreeNotFoundException(Guid id)
            : base($"A skilltree with id '{id}' does not exist")
        {
            this.Id = id;
        }
    }
}
