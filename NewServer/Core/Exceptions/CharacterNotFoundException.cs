namespace Kalinar.Core.Exceptions
{
    public class CharacterNotFoundException : Exception
    {
        public Guid Id { get; }

        public CharacterNotFoundException(Guid id)
            : base($"A character with id '{id}' does not exist")
        {
            this.Id = id;
        }
    }
}
