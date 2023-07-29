using Hero.Server.Core.Models;

namespace Hero.Server.Messages.Responses
{
    public class GroupResponse
    {
        public required Guid Id { get; set; }
        public required string OwnerId { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }


        public static implicit operator GroupResponse(Group group)
        {
            return new()
            {
                Id = group.Id,
                OwnerId = group.OwnerId,
                Name = group.Name,
                Description = group.Description,
            };
        }
    }
}