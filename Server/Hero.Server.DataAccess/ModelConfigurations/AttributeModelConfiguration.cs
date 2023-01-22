using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

using Attribute = Hero.Server.Core.Models.Attribute;

namespace Hero.Server.DataAccess.ModelConfigurations
{
    public class AttributeModelConfiguration : IEntityTypeConfiguration<Attribute>
    {
        public void Configure(EntityTypeBuilder<Attribute> builder)
        {
            builder.ToTable("Attributes");
            builder.HasKey(x => x.Id);

            builder.Property(c => c.StepSize).IsRequired();
            builder.Property(c => c.MaxValue).IsRequired();
            builder.Property(c => c.MinValue).IsRequired();
            builder.Property(a => a.Category).HasMaxLength(128);
        }
    }
}
