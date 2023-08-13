using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class SkilltreeResponse
    {
        public required Guid Id { get; init; }
        public required string Name { get; init; }
        public required bool IsActive { get; init; }
        public required int Points { get; init; }
        public Guid? CharacterId { get; init; }

        public static implicit operator SkilltreeResponse(SkilltreeEntity entity)
        {
            return new SkilltreeResponse
            {
                Id = entity.Id,
                Name = entity.Name,
                IsActive = entity.IsActive,
                Points = entity.Points,
                CharacterId = entity.CharacterId
            };
        }
    }
}
