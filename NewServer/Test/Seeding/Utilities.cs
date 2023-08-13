using Kalinar.Core.Entities;
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
        public const string RejectedAbilityId = "9505a1b5-bcc6-41f2-a776-c5b8c2505538";
        public static readonly List<string> ApprovedAbilityTags = new() { "Test"};

        public const string ApprovedAttribute1Id = "9504a1b5-bcc6-41f2-a776-c5b8c2505539";
        public const string ApprovedAttribute2Id = "9514a1b5-bcc6-41f2-a776-c5b8c2505539";
        public const string PendingAttributeId = "9504a1b5-bcc6-41f2-a776-c5b8c2505540";
        public const string RejectedAttributeId = "9514a1b5-bcc6-41f2-a776-c5b8c2505540";

        public const string ApprovedSkillId = "9504a1b5-bcc6-41f2-a776-c5b8c2505541";
        public const string PendingSkillId = "9504a1b5-bcc6-41f2-a776-c5b8c2505542";
        public const string RejectedSkillId = "9504a1b5-bcc6-41f2-a776-c5b8c2505543";

        public const string ApprovedRaceId = "9504a1b5-bcc6-41f2-a776-c5b8c2505544";
        public const string PendingRaceId = "9504a1b5-bcc6-41f2-a776-c5b8c2505545";
        public const string RejectedRaceId = "9504a1b5-bcc6-41f2-a776-c5b8c2505546";

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
            AbilityEntity rejectedAbility = new() { Id = new Guid(RejectedAbilityId), CreatorId = groupMember1.Id, Creator = groupMember1, GroupId = group.Id, Group = group, CreatedAt = DateTimeOffset.UtcNow, IsPassive = false, Name = "Testability", State = SuggestionState.Rejected, RejectedAt = DateTimeOffset.UtcNow, RejectionReason = "", Tags = new List<AbilityTagEntity>() };
            context.Abilities.Add(approvedAbility);
            context.Abilities.Add(pendingAbility);
            context.Abilities.Add(rejectedAbility);

            //Attributes
            AttributeEntity approved1Attribute = new() { Id = new Guid(ApprovedAttribute1Id), CreatorId = groupMember1.Id, Creator = groupMember1, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, Name = "Testattribute", State = SuggestionState.Approved, MinValue = 0, MaxValue = Int32.MaxValue, StepSize = 1 };
            AttributeEntity approved2Attribute = new() { Id = new Guid(ApprovedAttribute2Id), CreatorId = groupMember1.Id, Creator = groupMember1, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, Name = "Testattribute", State = SuggestionState.Approved, MinValue = 0, MaxValue = Int32.MaxValue, StepSize = 1 };
            AttributeEntity pendingAttribute = new() { Id = new Guid(PendingAttributeId), CreatorId = groupMember1.Id, Creator = groupMember1, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, Name = "Testattribute", State = SuggestionState.Pending, MinValue = 0, MaxValue = Int32.MaxValue, StepSize = 1 };
            AttributeEntity rejectedAttribute = new() { Id = new Guid(RejectedAttributeId), CreatorId = groupMember1.Id, Creator = groupMember1, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, Name = "Testattribute", State = SuggestionState.Rejected, RejectedAt = DateTimeOffset.UtcNow, RejectionReason = "", MinValue = 0, MaxValue = Int32.MaxValue, StepSize = 1 };
            context.Attributes.Add(approved1Attribute);
            context.Attributes.Add(approved2Attribute);
            context.Attributes.Add(pendingAttribute);
            context.Attributes.Add(rejectedAttribute);

            //Skills
            SkillEntity approvedSkill = new() { Id = new Guid(ApprovedSkillId), CreatorId = groupMember1.Id, Creator = groupMember1, AbilityId = approvedAbility.Id, Ability = approvedAbility, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, IconUrl = "", Name = "Testskill", State = SuggestionState.Approved, Attributes = new List<SkillAttributeEntity>() };
            SkillEntity pendingSkill = new() { Id = new Guid(PendingSkillId), CreatorId = groupMember1.Id, Creator = groupMember1, AbilityId = pendingAbility.Id, Ability = pendingAbility, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, IconUrl = "", Name = "Testskill", State = SuggestionState.Pending, Attributes = new List<SkillAttributeEntity>() };
            SkillEntity rejectedSkill = new() { Id = new Guid(RejectedSkillId), CreatorId = groupMember1.Id, Creator = groupMember1, AbilityId = approvedAbility.Id, Ability = approvedAbility, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, IconUrl = "", Name = "Testskill", State = SuggestionState.Rejected, RejectedAt = DateTimeOffset.UtcNow, RejectionReason = "", Attributes = new List<SkillAttributeEntity>() };
            context.Skills.Add(approvedSkill);
            context.Skills.Add(pendingSkill);
            context.Skills.Add(rejectedSkill);

            //Races
            //Create approved, pending and rejected race objects here.
            RaceEntity approvedRace = new() { Id = new Guid(ApprovedRaceId), CreatorId = groupMember1.Id, Creator = groupMember1, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, Name = "Testrace", State = SuggestionState.Approved, Attributes = new List<RaceAttributeEntity>() };
            RaceEntity pendingRace = new() { Id = new Guid(PendingRaceId), CreatorId = groupMember1.Id, Creator = groupMember1, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, Name = "Testrace", State = SuggestionState.Pending, Attributes = new List<RaceAttributeEntity>() };
            RaceEntity rejectedRace = new() { Id = new Guid(RejectedRaceId), CreatorId = groupMember1.Id, Creator = groupMember1, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, Name = "Testrace", State = SuggestionState.Rejected, RejectedAt = DateTimeOffset.UtcNow, RejectionReason = "", Attributes = new List<RaceAttributeEntity>() };
            context.Races.Add(approvedRace);
            context.Races.Add(pendingRace);
            context.Races.Add(rejectedRace);

            //SkillAttributes
            SkillAttributeEntity approvedSkillAttribute = new() { SkillId = approvedSkill.Id, Skill = approvedSkill, AttributeId = approved1Attribute.Id, Attribute = approved1Attribute, Value = 1 };
            SkillAttributeEntity pendingSkillAttribute = new() { SkillId = pendingSkill.Id, Skill = pendingSkill, AttributeId = pendingAttribute.Id, Attribute = pendingAttribute, Value = 1 };
            context.SkillAttributes.Add(approvedSkillAttribute);
            context.SkillAttributes.Add(pendingSkillAttribute);

            //RaceAttributes
            RaceAttributeEntity approvedRaceAttribute = new() { RaceId = approvedRace.Id, Race = approvedRace, AttributeId = approved1Attribute.Id, Attribute = approved1Attribute, Value = 1 };
            RaceAttributeEntity pendingRaceAttribute = new() { RaceId = pendingRace.Id, Race = pendingRace, AttributeId = pendingAttribute.Id, Attribute = pendingAttribute, Value = 1 };
            context.RaceAttributes.Add(approvedRaceAttribute);
            context.RaceAttributes.Add(pendingRaceAttribute);

            context.SaveChanges();
        }
    }
}
