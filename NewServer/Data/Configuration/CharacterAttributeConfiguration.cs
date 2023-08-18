using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class CharacterAttributesConfiguration : IEntityTypeConfiguration<CharacterAttributeEntity>
    {
        public void Configure(EntityTypeBuilder<CharacterAttributeEntity> builder)
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
