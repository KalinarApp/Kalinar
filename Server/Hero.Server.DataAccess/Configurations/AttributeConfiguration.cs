using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using Attribute = Hero.Server.Core.Models.Attribute;

namespace Hero.Server.DataAccess.Configurations
{
    public class AttributeConfiguration : SuggestableConfiguration<Attribute>
    {
        public override void Configure(EntityTypeBuilder<Attribute> builder)
        {
            builder.ToTable("Attributes");

            builder.Property(c => c.StepSize).IsRequired();
            builder.Property(c => c.MaxValue).IsRequired();
            builder.Property(c => c.MinValue).IsRequired();
            builder.Property(a => a.Category).HasMaxLength(128);

            base.Configure(builder);
        }
    }
}
