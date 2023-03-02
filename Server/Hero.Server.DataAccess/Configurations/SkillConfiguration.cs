using Hero.Server.Core.Models;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.DataAccess.Configurations
{
    public class SkillConfiguration : SuggestableConfiguration<Skill>
    {
        public override void Configure(EntityTypeBuilder<Skill> builder)
        {
            builder.ToTable("Skills");
            builder.HasKey(x => x.Id);

            builder
                .HasOne(skill => skill.Ability)
                .WithMany()
                .HasForeignKey(skill => skill.AbilityId)
                .OnDelete(DeleteBehavior.SetNull);

            base.Configure(builder);
        }
    }
}
