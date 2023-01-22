using System.ComponentModel.DataAnnotations;

namespace Hero.Server.Messages.Requests
{
    public class AttributeRequest
    {
        [Required]
        public string Name { get; set; }
        public string? Description { get; set; }
        public string? Category { get; set; }
        [Required]
        public double MaxValue { get; set; }
        [Required]
        public double MinValue { get; set; }
        [Required]
        public double StepSize { get; set; }
        public string? IconData { get; set; }

    }
}
