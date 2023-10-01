namespace Kalinar.Core.Exceptions
{
    public class SkilltreeNodeNotFoundException : Exception
    {
        public Guid Id { get; }

        public SkilltreeNodeNotFoundException(Guid id)
            : base($"A skilltree node with id '{id}' does not exist")
        {
            this.Id = id;
        }
    }
}
