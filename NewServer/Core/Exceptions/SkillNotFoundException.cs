namespace Kalinar.Core.Exceptions
{
    public class SkillNotFoundException : Exception
    {
        public Guid Id { get; }

        public SkillNotFoundException(Guid id)
            : base($"A skill with id '{id}' does not exist")
        {
            this.Id = id;
        }
    }
}
