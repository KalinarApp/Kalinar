using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class AttributeResponse : SuggestableResponse
    {
        public required string Name { get; init; }
        public string? IconData { get; init; }
        public string? Description { get; init; }
        public string? Category { get; init; }
        public required double StepSize { get; init; }
        public required double MinValue { get; init; }
        public required double MaxValue { get; init; }

        public static implicit operator AttributeResponse(AttributeEntity attribute)
        {
            return new()
            {
                Id = attribute.Id,
                GroupId = attribute.GroupId,
                CreatorId = attribute.CreatorId,
                Name = attribute.Name,
                Description = attribute.Description,
                Category = attribute.Category,
                IconData = attribute.IconData,
                StepSize = attribute.StepSize,
                MinValue = attribute.MinValue,
                MaxValue = attribute.MaxValue,
                State = attribute.State.ToString(),
                ApprovedAt = attribute.ApprovedAt,
                ModifiedAt = attribute.ModifiedAt,
                RejectedAt = attribute.RejectedAt,
                RejectionReason = attribute.RejectionReason,
            };
        }
    }
}
