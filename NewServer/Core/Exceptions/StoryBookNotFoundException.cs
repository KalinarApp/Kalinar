namespace Kalinar.Core.Exceptions
{
    public class StoryBookNotFoundException : Exception
    {
        public Guid Id { get; }

        public StoryBookNotFoundException(Guid id)
            : base($"A story book with id '{id}' does not exist")
        {
            this.Id = id;
        }
    }
}
