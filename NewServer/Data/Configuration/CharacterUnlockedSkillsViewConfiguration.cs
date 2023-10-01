using Kalinar.Core.Views;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class CharacterUnlockedSkillsViewConfiguration : IEntityTypeConfiguration<CharacterUnlockedSkillView>
    {
        public void Configure(EntityTypeBuilder<CharacterUnlockedSkillView> builder)
        {
            builder.ToView("CharacterUnlockedSkills");
            builder.HasNoKey();

            builder.HasOne(x => x.Skill).WithMany().HasForeignKey(x => x.SkillId).OnDelete(DeleteBehavior.NoAction);
        }
    }
}
