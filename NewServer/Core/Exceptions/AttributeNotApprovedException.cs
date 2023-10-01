namespace Kalinar.Core.Exceptions
{
    public class AttributeNotApprovedException : Exception
    {
        public AttributeNotApprovedException(string attributeName)
            : base($"Attribute '{attributeName}' is not approved")
        { }
    }
}
