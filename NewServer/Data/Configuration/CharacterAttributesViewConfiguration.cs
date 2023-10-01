using Kalinar.Core.Views;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class CharacterAttributesConfiguration : IEntityTypeConfiguration<CharacterAttributeView>
    {
        public void Configure(EntityTypeBuilder<CharacterAttributeView> builder)
        {
            builder.ToView("CharacterAttributes");
            builder.HasNoKey();

            builder.HasOne(e => e.Attribute)
                .WithMany()
                .HasForeignKey(e => e.AttributeId)
                .OnDelete(DeleteBehavior.NoAction);
        }
    }
}
