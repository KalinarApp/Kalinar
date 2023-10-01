using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class AbilityConfiguration : SuggestableConfiguration<AbilityEntity>
    {
        public override void Configure(EntityTypeBuilder<AbilityEntity> builder)
        {
            builder.ToTable("Abilities");

            builder.Property(x => x.Name).HasMaxLength(128).IsRequired();
            builder.Property(x => x.Description).HasMaxLength(2048);
            builder.Property(x => x.IsPassive).IsRequired();

            builder.HasMany(x => x.Tags).WithOne().HasForeignKey(tag => tag.AbilityId).OnDelete(DeleteBehavior.Cascade);
            
            base.Configure(builder);
        }
    }
}
