using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class SkilltreeNodeConfiguration : IEntityTypeConfiguration<SkilltreeNodeEntity>
    {
        public void Configure(EntityTypeBuilder<SkilltreeNodeEntity> builder)
        {
            builder.ToTable("SkilltreeNodes");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Id).ValueGeneratedNever().IsRequired();
            builder.Property(x => x.Importance).IsRequired();
            builder.Property(x => x.Cost).IsRequired();
            builder.Property(x => x.XPos).IsRequired();
            builder.Property(x => x.YPos).IsRequired();
            builder.Property(x => x.Color).IsRequired();
            builder.Property(x => x.IsUnlocked).IsRequired();
            builder.Property(x => x.IsEasyReachable).IsRequired();

            builder.HasOne(x => x.Skilltree).WithMany(x => x.Nodes).HasForeignKey(x => x.SkilltreeId).OnDelete(DeleteBehavior.Cascade);
            builder.HasOne(x => x.Skill).WithMany().HasForeignKey(x => x.SkillId).OnDelete(DeleteBehavior.Restrict);
        }
    }
}
