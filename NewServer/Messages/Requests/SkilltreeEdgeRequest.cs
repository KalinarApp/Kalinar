using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Requests
{
    public class SkilltreeEdgeRequest
    {
        [Required]
        public required Guid SkilltreeId { get; init; }
        [Required]
        public required Guid StartId { get; init; }
        [Required]
        public required Guid EndId { get; init; }


    }
}
