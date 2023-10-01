using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class CharacterSkillsConfiguration : IEntityTypeConfiguration<CharacterSkillEntity>
    {
        public void Configure(EntityTypeBuilder<CharacterSkillEntity> builder)
        {
            builder.ToTable("CharacterSkills");
            builder.HasKey(x => new { x.CharacterId, x.SkillId});

            builder.Property(x => x.IsFavorite).HasDefaultValue(false).IsRequired();

            builder.HasOne(x => x.Skill).WithMany().HasForeignKey(x => x.SkillId).OnDelete(DeleteBehavior.Cascade);
            builder.HasOne(x => x.Character).WithMany().HasForeignKey(x => x.CharacterId).OnDelete(DeleteBehavior.Cascade);
        }
    }
}
