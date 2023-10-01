namespace Kalinar.Core.Entities
{
    public class GroupMemberEntity
    {
        public required string UserId { get; init; }
        public required Guid GroupId { get; init; }
        public required Role Role { get; set; }

        public required UserEntity User { get; init; }
        public required GroupEntity Group { get; init; }
    }
}
