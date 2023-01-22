using Hero.Server.Core.Models;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.DataAccess.ModelConfigurations
{
    public class BlueprintNodeModelConfiguration : IEntityTypeConfiguration<BlueprintNode>
    {
        public void Configure(EntityTypeBuilder<BlueprintNode> builder)
        {
            builder.ToTable("BlueprintNodes");
            builder.HasKey(x => x.Id);

            builder
                .HasOne(node => node.Skill)
                .WithMany()
                .HasForeignKey(node => node.SkillId)
                .OnDelete(DeleteBehavior.Restrict);

            builder.Property(n => n.Id).IsRequired().ValueGeneratedNever();
            builder.Property(n => n.Importance).IsRequired();
            builder.Property(n => n.Cost).IsRequired();
            builder.Property(n => n.XPos).IsRequired();
            builder.Property(n => n.YPos).IsRequired();
            builder.Property(n => n.Color).IsRequired();
            builder.Property(n => n.IsEasyReachable).IsRequired();
            builder.Property(n => n.Precessors).IsRequired();
            builder.Property(n => n.Successors).IsRequired();
        }
    }
}
