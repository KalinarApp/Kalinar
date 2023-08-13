using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class SkilltreeEdgeResponse
    {
        public required Guid StartId { get; init; }
        public required Guid EndId { get; init; }

        public static implicit operator SkilltreeEdgeResponse(SkilltreeEdgeEntity entity)
        {
            return new SkilltreeEdgeResponse
            {
                StartId = entity.StartId,
                EndId = entity.EndId
            };
        }
    }
}
