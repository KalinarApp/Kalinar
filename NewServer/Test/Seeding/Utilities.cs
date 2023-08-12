﻿using Kalinar.Core.Entities;
using Kalinar.Data.Database;

namespace Kalinar.Test.Seeding
{
    internal class Utilities
    {
        public const string GroupId = "50a9b8ff-37e5-4f64-b18b-b413db321d07";
        public const string GroupOwnerUserId = "TestingOwner";
        public const string GroupMember1UserId = "TestingMember1";
        public const string GroupMember2UserId = "TestingMember2";
        public const string GrouplessUserId = "TestingGroupless";

        public const string ApprovedAbilityId = "9504a1b5-bcc6-41f2-a776-c5b8c2505537";
        public const string PendingAbilityId = "9504a1b5-bcc6-41f2-a776-c5b8c2505538";
        public static readonly List<string> ApprovedAbilityTags = new() { "Test"};

        public const string ApprovedAttributeId = "9504a1b5-bcc6-41f2-a776-c5b8c2505539";
        public const string PendingAttributeId = "9504a1b5-bcc6-41f2-a776-c5b8c2505540";

        public const string ApprovedSkillId = "9504a1b5-bcc6-41f2-a776-c5b8c2505541";
        public const string PendingSkillId = "9504a1b5-bcc6-41f2-a776-c5b8c2505542";

        public static void SeedDatabase(Context context)
        {
            // Groups
            GroupEntity group = new() { Id = new Guid(GroupId), Name = "Testgroup", Description = "", Members = new() };
            context.Groups.Add(group);

            // Users

            UserEntity groupOwner = new() { Id = GroupOwnerUserId, Username = "Owner", Devices = new(), Groups = new() };
            UserEntity groupMember1 = new() { Id = GroupMember1UserId, Username = "Member", Devices = new(), Groups = new() };         
            UserEntity groupMember2 = new() { Id = GroupMember2UserId, Username = "Member", Devices = new(), Groups = new() };         
            UserEntity grouplessUser = new() { Id = GrouplessUserId, Username = "Groupless", Devices = new(), Groups = new() };         
            context.Users.Add(groupOwner);
            context.Users.Add(groupMember1);
            context.Users.Add(groupMember2);
            context.Users.Add(grouplessUser);

            // GroupMembers
            GroupMemberEntity ownerMember = new() { GroupId = group.Id, UserId = groupOwner.Id, Group = group, User = groupOwner, Role = Role.Owner };
            GroupMemberEntity member1Member = new() { GroupId = group.Id, UserId = groupMember1.Id, Group = group, User = groupMember1, Role = Role.Member };
            GroupMemberEntity member2Member = new() { GroupId = group.Id, UserId = groupMember2.Id, Group = group, User = groupMember2, Role = Role.Member };
            context.GroupMembers.Add(ownerMember);
            context.GroupMembers.Add(member1Member);
            context.GroupMembers.Add(member2Member);

            // Abilities
            AbilityEntity approvedAbility = new() { Id = new Guid(ApprovedAbilityId), CreatorId = groupMember1.Id, Creator = groupMember1, GroupId = group.Id, Group = group, CreatedAt = DateTimeOffset.UtcNow, IsPassive = false, Name = "Testability", State = SuggestionState.Approved, Tags = ApprovedAbilityTags.Select(tag => new AbilityTagEntity() { Tag = tag, AbilityId = new Guid(ApprovedAbilityId) }).ToList() };
            AbilityEntity pendingAbility = new() { Id = new Guid(PendingAbilityId), CreatorId = groupMember1.Id, Creator = groupMember1, GroupId = group.Id, Group = group, CreatedAt = DateTimeOffset.UtcNow, IsPassive = false, Name = "Testability", State = SuggestionState.Pending, Tags = new List<AbilityTagEntity>() };
            context.Abilities.Add(approvedAbility);
            context.Abilities.Add(pendingAbility);

            //Attributes
            AttributeEntity approvedAttribute = new() { Id = new Guid(ApprovedAttributeId), CreatorId = groupMember1.Id, Creator = groupMember1, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, Name = "Testattribute", State = SuggestionState.Approved, MinValue = 0, MaxValue = Int32.MaxValue, StepSize = 1 };
            AttributeEntity pendingAttribute = new() { Id = new Guid(PendingAttributeId), CreatorId = groupMember1.Id, Creator = groupMember1, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, Name = "Testattribute", State = SuggestionState.Pending, MinValue = 0, MaxValue = Int32.MaxValue, StepSize = 1 };
            context.Attributes.Add(approvedAttribute);
            context.Attributes.Add(pendingAttribute);

            //Skills
            SkillEntity approvedSkill = new() { Id = new Guid(ApprovedSkillId), CreatorId = groupMember1.Id, Creator = groupMember1, AbilityId = approvedAbility.Id, Ability = approvedAbility, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, IconUrl = "", Name = "Testskill", State = SuggestionState.Approved, Attributes = new List<SkillAttributeEntity>() };
            SkillEntity pendingSkill = new() { Id = new Guid(PendingSkillId), CreatorId = groupMember1.Id, Creator = groupMember1, AbilityId = pendingAbility.Id, Ability = pendingAbility, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, IconUrl = "", Name = "Testskill", State = SuggestionState.Pending, Attributes = new List<SkillAttributeEntity>() };
            context.Skills.Add(approvedSkill);
            context.Skills.Add(pendingSkill);

            //SkillAttributes
            SkillAttributeEntity approvedSkillAttribute = new() { SkillId = approvedSkill.Id, Skill = approvedSkill, AttributeId = approvedAttribute.Id, Attribute = approvedAttribute, Value = 1 };
            context.SkillAttributes.Add(approvedSkillAttribute);

            context.SaveChanges();
        }
    }
}
