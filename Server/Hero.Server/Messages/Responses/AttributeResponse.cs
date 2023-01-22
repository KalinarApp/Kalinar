namespace Hero.Server.Messages.Responses
{
    public class AttributeResponse
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string? Description { get; set; }
        public string? Category { get; set; }
        public string? IconData{ get; set; }
        public double StepSize { get; set; }
        public double MinValue { get; set; }
        public double MaxValue { get; set; }
        public bool IsGlobal { get; set; }
    }
}