namespace Kalinar.Core.Entities
{
    public class UserEntity
    {
        public required string Id { get; set; }
        public required string Username { get; set; }
        public bool IsMigrated { get; init; } = false;
        public required List<GroupMemberEntity> Groups { get; init; }
        public required List<DeviceEntity> Devices { get; init; }
    }
}
