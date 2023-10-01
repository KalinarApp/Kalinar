using Kalinar.Messages.Attributes;

using System.ComponentModel.DataAnnotations;

namespace Kalinar.Messages.Requests
{
    [Unequal(nameof(StartId), nameof(EndId), ErrorMessage = "Start and end of the edge must be different")]
    public class SkilltreeEdgeRequest
    {
        [Required]
        public required Guid StartId { get; init; }
        [Required]
        public required Guid EndId { get; init; }


    }
}
