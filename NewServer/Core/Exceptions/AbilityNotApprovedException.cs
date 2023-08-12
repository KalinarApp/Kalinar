namespace Kalinar.Core.Exceptions
{
    public class AbilityNotApprovedException : Exception
    {
        public AbilityNotApprovedException(string abilityName)
            : base($"Ability '{abilityName}' is not approved")
        { }
    }
}
