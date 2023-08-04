using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class SkillConfiguration : SuggestableConfiguration<SkillEntity>
    {
        public override void Configure(EntityTypeBuilder<SkillEntity> builder)
        {
            builder.ToTable("Skills");

            builder.Property(x => x.Name).HasMaxLength(128).IsRequired();
            builder.HasOne(x => x.Ability).WithMany().HasForeignKey(x => x.AbilityId).OnDelete(DeleteBehavior.SetNull); 

            base.Configure(builder);
        }
    }
}
