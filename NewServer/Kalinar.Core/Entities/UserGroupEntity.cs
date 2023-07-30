namespace Kalinar.Core.Entities
{
    public class UserGroupEntity
    {
        public required string UserId { get; init; }
        public required Guid GroupId { get; init; }
        public required RoleEntity Role { get; set; }

        public UserEntity? User { get; set; }
        public GroupEntity? Group { get; set; }
    }
}
