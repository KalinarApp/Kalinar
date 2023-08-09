using Kalinar.Core.Entities;
using Kalinar.Data.Database;

namespace Kalinar.Test.Seeding
{
    internal class Utilities
    {
        public const string GroupId = "50a9b8ff-37e5-4f64-b18b-b413db321d07";
        public const string GroupOwnerUserId = "TestingOwner";
        public const string GroupMemberUserId = "TestingMember";
        public const string GrouplessUserId = "TestingGroupless";

        public const string AbilityId = "9504a1b5-bcc6-41f2-a776-c5b8c2505537";

        public static void SeedDatabase(Context context)
        {
            // Groups
            GroupEntity group = new() { Id = new Guid(GroupId), Name = "Testgroup", Description = "", Members = new() };
            context.Groups.Add(group);

            // Users

            UserEntity groupOwner = new() { Id = GroupOwnerUserId, Username = "Owner", Devices = new(), Groups = new() };
            UserEntity groupMember = new() { Id = GroupMemberUserId, Username = "Member", Devices = new(), Groups = new() };         
            UserEntity grouplessUser = new() { Id = GrouplessUserId, Username = "Groupless", Devices = new(), Groups = new() };         
            context.Users.Add(groupOwner);
            context.Users.Add(groupMember);
            context.Users.Add(grouplessUser);

            // GroupMembers
            GroupMemberEntity ownerMember = new() { GroupId = group.Id, UserId = groupOwner.Id, Group = group, User = groupOwner, Role = Role.Owner };
            GroupMemberEntity memberMember = new() { GroupId = group.Id, UserId = groupMember.Id, Group = group, User = groupMember, Role = Role.Member };
            context.GroupMembers.Add(ownerMember);
            context.GroupMembers.Add(memberMember);

            // Abilities
            AbilityEntity ability = new() { Id = new Guid(AbilityId), CreatorId = groupOwner.Id, Creator = groupOwner, GroupId = group.Id, Group = group, CreatedAt = DateTimeOffset.UtcNow, IsPassive = false, Name = "Testability", State = SuggestionState.Pending, Tags = new List<AbilityTagEntity>() };
            context.Abilities.Add(ability);

            context.SaveChanges();
        }
    }
}
