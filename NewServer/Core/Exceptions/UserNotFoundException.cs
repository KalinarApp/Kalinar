namespace Kalinar.Core.Exceptions
{
    public class UserNotFoundException : Exception
    {
        public string Id { get; }

        public UserNotFoundException(string id)
            : base($"A user with id '{id}' does not exist")
        {
            this.Id = id;
        }
    }
}
