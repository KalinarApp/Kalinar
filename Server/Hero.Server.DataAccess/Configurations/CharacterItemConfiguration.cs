using Hero.Server.Core.Models.Inventory;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.DataAccess.Configurations
{
    public class CharacterItemConfiguration : IEntityTypeConfiguration<CharacterItem>
    {
        public void Configure(EntityTypeBuilder<CharacterItem> builder)
        {
            builder.ToTable("CharacterItems");
            builder.HasKey(x => new { x.CharacterId, x.ItemId });

            builder.Property(x => x.Count).HasDefaultValue(1);

            builder
                .HasOne(x => x.Character)
                .WithMany(x => x.Items)
                .HasForeignKey(x => x.CharacterId)
                .OnDelete(DeleteBehavior.Cascade);
            builder
                .HasOne(x => x.Item)
                .WithMany(x => x.Characters)
                .HasForeignKey(x => x.ItemId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
