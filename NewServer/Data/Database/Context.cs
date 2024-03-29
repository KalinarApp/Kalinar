﻿using Kalinar.Core.Entities;
using Kalinar.Core.Views;
using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Database
{
    public class Context : DbContext
    {
        public Context(DbContextOptions<Context> options) : base(options) { }

        public DbSet<AbilityEntity> Abilities { get; set; }
        public DbSet<AttributeEntity> Attributes { get; set; }
        public DbSet<CharacterEntity> Characters { get; set; }
        public DbSet<CharacterSkillEntity> CharacterSkills { get; set; }
        public DbSet<CharacterUnlockedSkillView> CharacterUnlockedSkillsView { get; set; }
        public DbSet<CharacterAttributeView> CharacterAttributesView { get; set; }
        public DbSet<GroupEntity> Groups { get; set; }
        public DbSet<GroupMemberEntity> GroupMembers { get; set; }
        public DbSet<RaceEntity> Races { get; set; }
        public DbSet<RaceAttributeEntity> RaceAttributes { get; set; }
        public DbSet<SkillEntity> Skills { get; set; }
        public DbSet<SkillAttributeEntity> SkillAttributes { get; set; }
        public DbSet<SkilltreeEntity> Skilltrees { get; set; }
        public DbSet<SkilltreePointsView> SkilltreesPointsView { get; set; }
        public DbSet<SkilltreeEdgeEntity> SkilltreeEdges { get; set; }
        public DbSet<SkilltreeNodeEntity> SkilltreeNodes { get; set; }
        public DbSet<UserEntity> Users { get; set; }
        public DbSet<StoryBookEntity> StoryBooks { get; set; }
        public DbSet<StoryBookPageEntity> StoryBookPages { get; set; }
        public DbSet<StoryEventEntity> StoryEvents { get; set; }
        public DbSet<StoryImageEntity> StoryImages { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.HasDefaultSchema(Resources.Schema);
            builder.ApplyConfigurationsFromAssembly(typeof(Context).Assembly);
        }
    }
}
