namespace Kalinar.Authorization
{
    public class PolicyNames
    {
        public const string IsValidUser = "IsValidUserPolicy";
        public const string IsMemberInGroup = "IsMemberInGroupPolicy";
        public const string IsAdminInGroup = "IsAdminInGroupPolicy";

        public const string CanListUsers = "CanListUsersPolicy";
        public const string CanReadUsers = "CanReadUsersPolicy";
        public const string CanCreateUsers = "CanCreateUsersPolicy";
        public const string CanUpdateUsers = "CanUpdateUsersPolicy";
        public const string CanDeleteUsers = "CanDeleteUsersPolicy";
        
        public const string CanListGroups = "CanListGroupsPolicy";
        public const string CanReadGroups = "CanReadGroupsPolicy";
        public const string CanCreateGroups = "CanCreateGroupsPolicy";
        public const string CanUpdateGroups = "CanUpdateGroupsPolicy";
        public const string CanDeleteGroups = "CanDeleteGroupsPolicy";
    }
}
