﻿using Kalinar.Core.Views;

namespace Kalinar.Messages.Responses
{
    public class SkilltreePointsResponse
    {
        public required Guid SkilltreeId { get; init; }
        public required int Available { get; init; }
        public required int Spent { get; init; }
        public required int Remaining { get; init; }

        public static implicit operator SkilltreePointsResponse(SkilltreePointsView entity)
        {
            return new SkilltreePointsResponse
            {
                SkilltreeId = entity.SkilltreeId,
                Available = entity.Available,
                Spent = entity.Spent,
                Remaining = entity.Remaining
            };
        }
    }
}
