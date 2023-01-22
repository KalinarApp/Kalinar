using Hero.Server.Core.Models;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.DataAccess.ModelConfigurations
{
    public class SkillModelConfiguration : IEntityTypeConfiguration<Skill>
    {
        public void Configure(EntityTypeBuilder<Skill> builder)
        {
            builder.ToTable("Skills");
            builder.HasKey(x => x.Id);

            builder
                .HasOne(skill => skill.Ability)
                .WithMany()
                .HasForeignKey(skill => skill.AbilityId)
                .OnDelete(DeleteBehavior.SetNull);
        }
    }
}
