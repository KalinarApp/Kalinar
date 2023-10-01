namespace Kalinar.Core.Entities
{
    public class BaseEntity
    {
        public required Guid Id { get; init; }
        public required DateTimeOffset CreatedAt { get; init; }
        public DateTimeOffset? ModifiedAt { get; set; }
    }
}
