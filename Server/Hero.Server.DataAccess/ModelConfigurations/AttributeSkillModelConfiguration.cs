using Hero.Server.Core.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.DataAccess.ModelConfigurations
{
    public class AttributeSkillModelConfiguration : IEntityTypeConfiguration<AttributeSkill>
    {
        public void Configure(EntityTypeBuilder<AttributeSkill> builder)
        {
            builder.ToTable("AttributeSkills");

            builder.HasKey(ac => new { ac.AttributeId, ac.SkillId });
            builder
                .HasOne(ats => ats.Attribute)
                .WithMany(at => at.AttributeSkills)
                .HasForeignKey(ats => ats.AttributeId)
                .OnDelete(DeleteBehavior.Cascade);
            builder
                .HasOne(ats => ats.Skill)
                .WithMany(s => s.Attributes)
                .HasForeignKey(ats => ats.SkillId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
