namespace Kalinar.Core.Entities
{
    public class UserEntity
    {
        public required string Id { get; set; }
        public required string Username { get; set; }
        public required List<string> DeviceIds { get; init; }
        public required List<GroupMemberEntity> Groups { get; init; }
    }
}
