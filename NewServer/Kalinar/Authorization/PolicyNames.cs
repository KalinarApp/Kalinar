﻿namespace Kalinar.Authorization
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

        public const string CanListSuggestables = "CanListSuggestablesPolicy";
        public const string CanReadSuggestable = "CanReadSuggestablePolicy";
        public const string CanCreateSuggestable = "CanCreateSuggestablePolicy";
        public const string CanUpdateSuggestable = "CanUpdateSuggestablePolicy";
        public const string CanApproveSuggestable = "CanApproveSuggestablePolicy";
        public const string CanDeleteSuggestable = "CanDeleteSuggestablePolicy";

        public const string CanSetAbilityTags = "CanSetAbilityTagsPolicy";
        public const string CanSetSkillAttributes = "CanSetSkillAttributesPolicy";
        public const string CanSetRaceAttributes = "CanSetRaceAttributesPolicy";

        public const string CanListCharacters = "CanListCharactersPolicy";
        public const string CanReadCharacter = "CanReadCharacterPolicy";
        public const string CanCreateCharacter = "CanCreateCharacterPolicy";
        public const string CanUpdateCharacter = "CanUpdateCharacterPolicy";
        public const string CanDeleteCharacter = "CanDeleteCharacterPolicy";

        public const string CanListSkilltrees = "CanListSkilltreesPolicy";
        public const string CanReadSkilltree = "CanReadSkilltreePolicy";
        public const string CanCreateSkilltree = "CanCreateSkilltreePolicy";
        public const string CanUpdateSkilltree = "CanUpdateSkilltreePolicy";
        public const string CanDeleteSkilltree = "CanDeleteSkilltreePolicy";

        public const string CanListStoryItems = "CanListStoryItemsPolicy";
        public const string CanReadStoryItem = "CanReadStoryItemPolicy";
        public const string CanCreateStoryItem = "CanCreateStoryItemPolicy";
        public const string CanUpdateStoryItem = "CanUpdateStoryItemPolicy";
        public const string CanDeleteStoryItem = "CanDeleteStoryItemPolicy";

        public const string CanUnlockSkilltreeNode = "CanUnlockSkilltreeNodePolicy";
        public const string CanResetSkilltreeNode = "CanResetSkilltreeNodePolicy";
    }
}
