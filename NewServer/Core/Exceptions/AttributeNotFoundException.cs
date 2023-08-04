namespace Kalinar.Core.Exceptions
{
    public class AttributeNotFoundException : Exception
    {
        public Guid Id { get; }

        public AttributeNotFoundException(Guid id)
            : base($"A attribute with id '{id}' does not exist")
        {
            this.Id = id;
        }
    }
}
