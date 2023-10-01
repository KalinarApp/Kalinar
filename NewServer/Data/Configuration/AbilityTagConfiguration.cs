using Kalinar.Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Configuration
{
    public class AbilityTagConfiguration : IEntityTypeConfiguration<AbilityTagEntity>
    {
        public void Configure(EntityTypeBuilder<AbilityTagEntity> builder)
        {
            builder.ToTable("AbilityTags");
            builder.HasKey(item => new { item.Tag, item.AbilityId });

            builder.Property(item => item.Tag).HasMaxLength(128).IsRequired();  
        }
    }
}
