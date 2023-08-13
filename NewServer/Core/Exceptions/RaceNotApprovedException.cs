namespace Kalinar.Core.Exceptions
{
    public class RaceNotApprovedException : Exception
    {
        public RaceNotApprovedException(string raceName)
            : base($"Race '{raceName}' is not approved")
        { }
    }
}
