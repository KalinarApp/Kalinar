namespace Kalinar.Core.Entities
{
    public class GroupUsersEntity
    {
        public required string UserId { get; init; }
        public required Guid GroupId { get; init; }
        public required Role Role { get; set; }

        public UserEntity? User { get; set; }
        public GroupEntity? Group { get; set; }
    }
}
