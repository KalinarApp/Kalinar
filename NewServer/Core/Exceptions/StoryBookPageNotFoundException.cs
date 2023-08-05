namespace Kalinar.Core.Exceptions
{
    public class StoryBookPageNotFoundException : Exception
    {
        public Guid Id { get; }

        public StoryBookPageNotFoundException(Guid id)
            : base($"A story book page with id '{id}' does not exist")
        {
            this.Id = id;
        }
    }
}
