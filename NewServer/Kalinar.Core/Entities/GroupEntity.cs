namespace Kalinar.Core.Entities
{
    public class GroupEntity
    {
        public required Guid Id { get; init; } 
        public required string Name { get; init; }
        public string? Description { get; init; }
        public required List<GroupUsersEntity> Members { get; init; }
    }
}
