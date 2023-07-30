﻿namespace Kalinar.Core.Entities
{
    public class UserEntity
    {
        public required string Id { get; init; }
        public required string Email { get; init; }
        public required string Username { get; init; }
        public required List<UserGroupEntity> Groups { get; init; }
    }
}
