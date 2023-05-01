using Hero.Server.Core.Models.Inventory;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.DataAccess.Configurations
{
    public class ItemConfiguration : IEntityTypeConfiguration<Item>
    {
        public void Configure(EntityTypeBuilder<Item> builder)
        {
            builder.ToTable("Items");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Title).HasMaxLength(256).IsRequired();
            builder.Property(x => x.Description).HasMaxLength(2048);

            builder.HasDiscriminator<string>("Type")
                .HasValue<Item>("Item")
                .HasValue<Weapon>("Weapon");

            builder
                .HasOne(x => x.Group)
                .WithMany()
                .HasForeignKey(x => x.GroupId)
                .OnDelete(DeleteBehavior.Cascade);

            builder
                .HasOne(x => x.Creator)
                .WithMany()
                .HasForeignKey(x => x.CreatorId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
