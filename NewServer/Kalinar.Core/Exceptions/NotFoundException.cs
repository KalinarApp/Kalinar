namespace Kalinar.Core.Exceptions
{
    public class GroupNotFoundException : Exception
    {
        public Guid Id { get; }

        public GroupNotFoundException(Guid id)
            : base($"A group with id '{id}' does not exist")
        {
            this.Id = id;
        }
    }
}
