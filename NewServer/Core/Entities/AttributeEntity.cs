namespace Kalinar.Core.Entities
{
    public class AttributeEntity : SuggestableEntity
    {
        public required string Name { get; set; }
        public string? IconData { get; set; }
        public string? Description { get; set; }
        public string? Category { get; set; }
        public required double StepSize { get; set; }
        public required double MinValue { get; set; }
        public required double MaxValue { get; set; }
        public bool IsDefault { get; init; } = false;
    }
}
