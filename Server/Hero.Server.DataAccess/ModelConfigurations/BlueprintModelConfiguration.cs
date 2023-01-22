using Hero.Server.Core.Models;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace Hero.Server.DataAccess.ModelConfigurations
{
    internal class BlueprintModelConfiguration : IEntityTypeConfiguration<Blueprint>
    {
        public void Configure(EntityTypeBuilder<Blueprint> builder)
        {
            builder.ToTable("Blueprints");
            builder.HasKey(x => x.Id);
            
            builder.Property(c => c.Name).IsRequired();
            builder.Property(c => c.Name).HasMaxLength(100);

            builder
                .HasMany(print => print.Nodes)
                .WithOne()
                .HasForeignKey(node => node.ParentId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
