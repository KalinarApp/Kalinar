﻿using Kalinar.Core.Entities;

namespace Kalinar.Messages.Responses
{
    public class UserResponse
    {
        public required string Id { get; init; }
        public required string Username { get; init; }
        public required IEnumerable<string> DeviceIds { get; init; }

        public static implicit operator UserResponse(UserEntity user)
        {
            return new()
            {
                Id = user.Id,
                Username = user.Username,
                DeviceIds = user.Devices.Select(device => device.Id),
            };
        }
    }
}