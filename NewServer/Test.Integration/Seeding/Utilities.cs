using Kalinar.Core.Entities;
using Kalinar.Data.Database;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Kalinar.Test.Integration.Seeding
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
        public static readonly List<string> ApprovedAbilityTags = new() { "Test" };

        public const string ApprovedAttribute1Id = "9504a1b5-bcc6-41f2-a776-c5b8c2505539";
        public const string ApprovedAttribute2Id = "9514a1b5-bcc6-41f2-a776-c5b8c2505539";
        public const string PendingAttributeId = "9504a1b5-bcc6-41f2-a776-c5b8c2505540";
        public const string RejectedAttributeId = "9514a1b5-bcc6-41f2-a776-c5b8c2505540";

        public const string ApprovedSkillId = "9504a1b5-bcc6-41f2-a776-c5b8c2505541";
        public const string ApprovedSkillNotInSkilltreeId = "9514a1b5-bcc6-41f2-a776-c5b8c2505541";
        public const string PendingSkillId = "9504a1b5-bcc6-41f2-a776-c5b8c2505542";
        public const string RejectedSkillId = "9504a1b5-bcc6-41f2-a776-c5b8c2505543";

        public const string ApprovedRaceId = "9504a1b5-bcc6-41f2-a776-c5b8c2505544";
        public const string ApprovedRaceNotInSkilltreeId = "9514a1b5-bcc6-41f2-a776-c5b8c2505544";
        public const string PendingRaceId = "9504a1b5-bcc6-41f2-a776-c5b8c2505545";
        public const string RejectedRaceId = "9504a1b5-bcc6-41f2-a776-c5b8c2505546";

        public const string CharacterId = "9504a1b5-bcc6-41f2-a776-c5b8c2505547";

        public const string SkilltreeId = "9504a1b5-bcc6-41f2-a776-c5b8c2505548";
        public const string SkilltreeNode1Id = "9504a1b5-bcc6-41f2-a776-c5b8c2505549";
        public const string SkilltreeNode2Id = "9504a1b5-bcc6-41f2-a776-c5b8c2505550";
        public const string SkilltreeNode3Id = "9504a1b5-bcc6-41f2-a776-c5b8c2505551";

        public const string StoryEventId = "9504a1b5-bcc6-41f2-a776-c5b8c2505552";
        public const string StoryImageId = "9504a1b5-bcc6-41f2-a776-c5b8c2505553";
        public const string StoryBookId = "9504a1b5-bcc6-41f2-a776-c5b8c2505554";
        public const string StoryBookPageId = "9504a1b5-bcc6-41f2-a776-c5b8c2505555";

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
            SkillEntity approvedSkillNotInSkilltree = new() { Id = new Guid(ApprovedRaceNotInSkilltreeId), CreatorId = groupMember1.Id, Creator = groupMember1, AbilityId = approvedAbility.Id, Ability = approvedAbility, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, IconUrl = "", Name = "Testskill", State = SuggestionState.Approved, Attributes = new List<SkillAttributeEntity>() };
            SkillEntity pendingSkill = new() { Id = new Guid(PendingSkillId), CreatorId = groupMember1.Id, Creator = groupMember1, AbilityId = pendingAbility.Id, Ability = pendingAbility, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, IconUrl = "", Name = "Testskill", State = SuggestionState.Pending, Attributes = new List<SkillAttributeEntity>() };
            SkillEntity rejectedSkill = new() { Id = new Guid(RejectedSkillId), CreatorId = groupMember1.Id, Creator = groupMember1, AbilityId = approvedAbility.Id, Ability = approvedAbility, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, IconUrl = "", Name = "Testskill", State = SuggestionState.Rejected, RejectedAt = DateTimeOffset.UtcNow, RejectionReason = "", Attributes = new List<SkillAttributeEntity>() };
            context.Skills.Add(approvedSkill);
            context.Skills.Add(approvedSkillNotInSkilltree);
            context.Skills.Add(pendingSkill);
            context.Skills.Add(rejectedSkill);

            //Races
            //Create approved, pending and rejected race objects here.
            RaceEntity approvedRace = new() { Id = new Guid(ApprovedRaceId), CreatorId = groupMember1.Id, Creator = groupMember1, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, Name = "Testrace", State = SuggestionState.Approved, Attributes = new List<RaceAttributeEntity>() };
            RaceEntity approvedRaceNotInSkilltree = new() { Id = new Guid(ApprovedRaceNotInSkilltreeId), CreatorId = groupMember1.Id, Creator = groupMember1, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, Name = "Testrace", State = SuggestionState.Approved, Attributes = new List<RaceAttributeEntity>() };
            RaceEntity pendingRace = new() { Id = new Guid(PendingRaceId), CreatorId = groupMember1.Id, Creator = groupMember1, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, Name = "Testrace", State = SuggestionState.Pending, Attributes = new List<RaceAttributeEntity>() };
            RaceEntity rejectedRace = new() { Id = new Guid(RejectedRaceId), CreatorId = groupMember1.Id, Creator = groupMember1, CreatedAt = DateTimeOffset.UtcNow, GroupId = group.Id, Group = group, Name = "Testrace", State = SuggestionState.Rejected, RejectedAt = DateTimeOffset.UtcNow, RejectionReason = "", Attributes = new List<RaceAttributeEntity>() };
            context.Races.Add(approvedRace);
            context.Races.Add(approvedRaceNotInSkilltree);
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

            //Characters
            CharacterEntity character = new() { Id = new Guid(CharacterId), Name = "Testcharacter", GroupId = group.Id, Group = group, UserId = groupMember1.Id, RaceId = approvedRace.Id, Race = approvedRace, CreatedAt = DateTimeOffset.UtcNow, Skilltrees = new List<SkilltreeEntity>() };
            context.Characters.Add(character);

            //Skilltrees
            SkilltreeEntity skilltree = new() { Id = new Guid(SkilltreeId), CharacterId = character.Id, Character = character, CreatedAt = DateTimeOffset.UtcNow, Points = 0, Name = "Testskilltree", GroupId = group.Id, Group = group, IsActive = true, Edges = new List<SkilltreeEdgeEntity>(), Nodes = new List<SkilltreeNodeEntity>() };
            context.Skilltrees.Add(skilltree);

            SkilltreeNodeEntity node1 = new() { Id = new Guid(SkilltreeNode1Id), SkilltreeId = skilltree.Id, Skilltree = skilltree, SkillId = approvedSkill.Id, Skill = approvedSkill, XPos = 0, YPos = 0, IsUnlocked = false, Color = "#000000", Cost = 0, Importance = 1, IsEasyReachable = false };
            SkilltreeNodeEntity node2 = new() { Id = new Guid(SkilltreeNode2Id), SkilltreeId = skilltree.Id, Skilltree = skilltree, SkillId = approvedSkill.Id, Skill = approvedSkill, XPos = 0, YPos = 0, IsUnlocked = false, Color = "#000000", Cost = 0, Importance = 1, IsEasyReachable = false };
            SkilltreeNodeEntity node3 = new() { Id = new Guid(SkilltreeNode3Id), SkilltreeId = skilltree.Id, Skilltree = skilltree, SkillId = approvedSkill.Id, Skill = approvedSkill, XPos = 0, YPos = 0, IsUnlocked = true, UnlockedAt = DateTimeOffset.UtcNow.AddMinutes(-6), Color = "#000000", Cost = 0, Importance = 1, IsEasyReachable = false };
            context.SkilltreeNodes.Add(node1);
            context.SkilltreeNodes.Add(node2);
            context.SkilltreeNodes.Add(node3);

            SkilltreeEdgeEntity skilltreeEdgeEntity = new() { SkilltreeId = skilltree.Id, Skilltree = skilltree, StartId = node1.Id, Start= node1, EndId = node2.Id, End = node2 };
            context.SkilltreeEdges.Add(skilltreeEdgeEntity);

            //Story
            StoryEventEntity storyEvent = new() { Id = new Guid(StoryEventId), GroupId = group.Id, Group = group, Title = "Event", Order = 0, CreatedAt = DateTimeOffset.UtcNow, IsUnlocked = true };
            StoryImageEntity storyImage= new() { Id = new Guid(StoryImageId), GroupId = group.Id, Group = group, Title = "Image", CreatedAt = DateTimeOffset.UtcNow, ImageUrl = "", IsUnlocked = true };
            StoryBookEntity storyBook= new() { Id = new Guid(StoryBookId), GroupId = group.Id, Group = group, Title = "Book", CreatedAt = DateTimeOffset.UtcNow, Pages = new List<StoryBookPageEntity>(), IsUnlocked = true };
            StoryBookPageEntity storyBookPage = new() { Id = new Guid(StoryBookPageId), BookId = storyBook.Id, Title = "Page", Content = "Content", PageNumber = 1, IsUnlocked = true };

            context.StoryEvents.Add(storyEvent);
            context.StoryImages.Add(storyImage);
            context.StoryBooks.Add(storyBook);
            context.StoryBookPages.Add(storyBookPage);

            context.Database.ExecuteSqlRaw(@"
            CREATE VIEW CharacterSkills AS  
                SELECT DISTINCT st.CharacterId,
                   s.Id AS SkillId
                  FROM SkilltreeNodes n
                    JOIN Skills s ON n.SkillId = s.Id
                    JOIN Skilltrees st ON n.SkilltreeId = st.Id
                 WHERE n.IsUnlocked = true AND st.CharacterId IS NOT NULL;       
            ");

            context.Database.ExecuteSqlRaw(@"
            CREATE VIEW SkilltreePoints AS 
             SELECT st.Id as SkilltreeId,
                st.Points AS Available,
                COALESCE(sum(n.Cost), 0) AS Spent,
                st.Points - COALESCE(sum(n.Cost), 0) AS Remaining
               FROM Skilltrees st
                 LEFT JOIN SkilltreeNodes n ON st.Id = n.SkilltreeId AND n.IsUnlocked = true
              GROUP BY st.Id, st.Name, st.Points;
            ");

            context.Database.ExecuteSqlRaw(@"
            CREATE VIEW CharacterAttributes AS  
                 SELECT c.Id AS CharacterId,
                    c.Name AS CharacterName,
                    a.Id AS AttributeId,
                    a.Name AS AttributeName,
                    COALESCE(sum(
                        CASE
                            WHEN n.IsUnlocked THEN sa.Value
                            ELSE 0
                        END), 0) + COALESCE(ra.Value, 0) AS Value
                   FROM Characters c
                     JOIN Groups g ON c.GroupId = g.Id
                     CROSS JOIN Attributes a
                     LEFT JOIN RaceAttributes ra ON c.RaceId = ra.RaceId AND a.Id = ra.AttributeId
                     LEFT JOIN Skilltrees st ON c.Id = st.CharacterId
                     LEFT JOIN SkilltreeNodes n ON st.Id = n.SkilltreeId
                     LEFT JOIN Skills s ON n.SkillId = s.Id
                     LEFT JOIN SkillAttributes sa ON s.Id = sa.SkillId AND n.IsUnlocked = true AND a.Id = sa.AttributeId
                  WHERE n.IsUnlocked OR ra.Value IS NOT NULL OR sa.Value IS NOT NULL
                  GROUP BY c.Id, a.Id, ra.Value
                 HAVING (COALESCE(sum(
                        CASE
                            WHEN n.IsUnlocked THEN sa.Value
                            ELSE 0
                        END), 0) + COALESCE(ra.Value, 0)) <> 0;     
            ");

            context.SaveChanges();
        }
    }
}
