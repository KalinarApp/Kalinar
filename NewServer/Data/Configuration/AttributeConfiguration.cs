using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class AttributeConfiguration : SuggestableConfiguration<AttributeEntity>
    {
        public override void Configure(EntityTypeBuilder<AttributeEntity> builder)
        {
            builder.ToTable("Attributes");

            builder.Property(x => x.StepSize).IsRequired();
            builder.Property(x => x.MinValue).IsRequired();
            builder.Property(x => x.MaxValue).IsRequired();
            builder.Property(x => x.Category).HasMaxLength(128);

            base.Configure(builder);
        }
    }
}
