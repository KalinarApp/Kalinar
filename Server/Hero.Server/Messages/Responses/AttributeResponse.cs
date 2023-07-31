using Attribute = Hero.Server.Core.Models.Attribute;

namespace Hero.Server.Messages.Responses
{
    public class AttributeResponse : SuggestableResponse
    {
        public required Guid Id { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }
        public string? Category { get; set; }
        public string? IconData{ get; set; }
        public required double StepSize { get; set; }
        public required double MinValue { get; set; }
        public required double MaxValue { get; set; }
        public required bool IsGlobal { get; set; }


        public static implicit operator AttributeResponse(Attribute attribute)
        {
            return new()
            {
                Id = attribute.Id,
                Creator = attribute.Creator,
                Name = attribute.Name,
                Description = attribute.Description,
                Category = attribute.Category,
                IconData = attribute.IconData,
                StepSize = attribute.StepSize,
                MinValue = attribute.MinValue,
                MaxValue = attribute.MaxValue,
                IsGlobal = attribute.Id == Guid.Empty,
                ApprovedAt = attribute.ApprovedAt,
                CreatedAt = attribute.CreatedAt,
                LastUpdatedAt = attribute.LastUpdatedAt,
                RejectedAt = attribute.RejectedAt,
                RejectionReason = attribute.RejectionReason,
                State = attribute.State,
            };
        }
    }
}