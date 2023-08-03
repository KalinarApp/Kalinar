﻿namespace Kalinar.Core.Entities
{
    public class SkilltreeEntity
    {
        public required Guid Id { get; init; }
        public required Guid GroupId { get; init; }
        public required string Name { get; set; }
        public required bool IsActive { get; set; }
        public required int Points { get; set; }
        public required List<SkilltreeNodeEntity> Nodes { get; init; }
        public required List<SkilltreeEdgeEntity> Edges { get; init; }

        public Guid? CharacterId { get; set; }
        public CharacterEntity? Character { get; set; }

    }
}
