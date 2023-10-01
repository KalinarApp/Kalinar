namespace Kalinar.Core.Exceptions
{
    public class StoryImageNotFoundException : Exception
    {
        public Guid Id { get; }

        public StoryImageNotFoundException(Guid id)
            : base($"A story image with id '{id}' does not exist")
        {
            this.Id = id;
        }
    }
}
