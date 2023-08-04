namespace Kalinar.Core.Entities
{
    public class BaseEntityWithGroup : BaseEntity
    {
        public required Guid GroupId { get; init; }
        public required GroupEntity Group { get; init; }
    }
}
