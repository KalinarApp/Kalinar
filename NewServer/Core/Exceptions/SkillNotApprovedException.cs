namespace Kalinar.Core.Exceptions
{
    public class SkillNotApprovedException : Exception
    {
        public SkillNotApprovedException(string skillName)
            : base($"Skill '{skillName}' is not approved")
        { }
    }
}
