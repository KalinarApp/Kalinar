using System.ComponentModel.DataAnnotations;

namespace Hero.Server.Messages.Requests
{
    public class AttributeValueRequest
    {
        [Required]
        public Guid AttributeId { get; set; }
        [Required]
        public double Value { get; set; }
    }
}
