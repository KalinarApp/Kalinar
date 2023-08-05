namespace Kalinar.Core.Exceptions
{
    public class StoryEventNotFoundException : Exception
    {
        public Guid Id { get; }

        public StoryEventNotFoundException(Guid id)
            : base($"A story event with id '{id}' does not exist")
        {
            this.Id = id;
        }
    }
}
