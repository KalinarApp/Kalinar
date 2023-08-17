using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class CharacterSkillsConfiguration : IEntityTypeConfiguration<CharacterSkillEntity>
    {
        public void Configure(EntityTypeBuilder<CharacterSkillEntity> builder)
        {
            builder.ToView("CharacterSkills");
            builder.HasNoKey();

            builder.HasOne(x => x.Skill).WithMany().HasForeignKey(x => x.SkillId).OnDelete(DeleteBehavior.NoAction);
        }
    }
}
