using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class SkilltreeConfiguration : IEntityTypeConfiguration<SkilltreeEntity>
    {
        public void Configure(EntityTypeBuilder<SkilltreeEntity> builder)
        {
            builder.ToTable("Skilltrees");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Name).HasMaxLength(128).IsRequired();
            builder.Property(x => x.Points).IsRequired();
            builder.Property(x => x.IsActive).IsRequired();
        }
    }
}
