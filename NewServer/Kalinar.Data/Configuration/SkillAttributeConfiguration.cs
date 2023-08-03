using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class SkillAttributeConfiguration : IEntityTypeConfiguration<SkillAttributeEntity>
    {
        public void Configure(EntityTypeBuilder<SkillAttributeEntity> builder)
        {
            builder.ToTable("SkillAttributes");
            builder.HasKey(x => new {x.SkillId, x.AttributeId});

            builder.HasOne(x => x.Skill).WithMany().HasForeignKey(x => x.SkillId).OnDelete(DeleteBehavior.Cascade);
            builder.HasOne(x => x.Attribute).WithMany().HasForeignKey(x => x.AttributeId).OnDelete(DeleteBehavior.Cascade);
        }
    }
}
