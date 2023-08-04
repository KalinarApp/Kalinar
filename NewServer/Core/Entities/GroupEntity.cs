namespace Kalinar.Core.Entities
{
    public class GroupEntity
    {
        public required Guid Id { get; init; } 
        public required string Name { get; set; }
        public string? Description { get; set; }
        public required List<GroupMemberEntity> Members { get; init; }
    }
}
