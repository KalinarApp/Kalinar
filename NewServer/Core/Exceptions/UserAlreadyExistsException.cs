namespace Kalinar.Core.Exceptions
{
    public class UserAlreadyExistsException : Exception
    {
        public string Id { get; }

        public UserAlreadyExistsException(string id)
            : base($"A user with id '{id}' already exists")
        {
            this.Id = id;
        }
    }
}
