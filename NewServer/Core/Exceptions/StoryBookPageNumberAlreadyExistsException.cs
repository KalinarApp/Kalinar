namespace Kalinar.Core.Exceptions
{
    public class StoryBookPageNumberAlreadyExistsException : Exception
    {
        public StoryBookPageNumberAlreadyExistsException(Guid bookId, int pageNumber)
            : base($"A book page with the number '{pageNumber}' already exist in book '{bookId}'")
        { }
    }
}
