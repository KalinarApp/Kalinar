using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class RaceAttributeConfiguration : IEntityTypeConfiguration<RaceAttributeEntity>
    {
        public void Configure(EntityTypeBuilder<RaceAttributeEntity> builder)
        {
            builder.ToTable("RaceAttributes");
            builder.HasKey(x => new {x.RaceId, x.AttributeId});

            builder.HasOne(x => x.Race).WithMany().HasForeignKey(x => x.RaceId).OnDelete(DeleteBehavior.Cascade);
            builder.HasOne(x => x.Attribute).WithMany().HasForeignKey(x => x.AttributeId).OnDelete(DeleteBehavior.Cascade);
        }
    }
}
