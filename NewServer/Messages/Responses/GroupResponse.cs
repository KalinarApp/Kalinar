using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class GroupResponse
    {
        public required Guid Id { get; init; }
        public required string Name { get; init; }
        public string? Description { get; init; }
        public required string Code { get; set; }

        public static implicit operator GroupResponse(GroupEntity entity)
        {
            return new GroupResponse
            {
                Id = entity.Id,
                Name = entity.Name,
                Description = entity.Description,
                Code = $"https://kalinar.app/invite/{entity.Id}",
            };
        }
    }
}
