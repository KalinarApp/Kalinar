using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class RaceResponse : SuggestableResponse
    {
        public required string Name { get; set; }
        public string? Description { get; set; }

        public static implicit operator RaceResponse(RaceEntity race)
        {
            return new()
            {
                Id = race.Id,
                CreatorId = race.CreatorId,
                GroupId = race.GroupId,
                Name = race.Name,
                Description = race.Description,
                State = race.State.ToString(),
                ApprovedAt = race.ApprovedAt,
                ModifiedAt = race.ModifiedAt,
                RejectedAt = race.RejectedAt,
                RejectionReason = race.RejectionReason,
            };
        }
    }
}
