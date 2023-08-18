using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class SkilltreePointsConfiguration : IEntityTypeConfiguration<SkilltreePointEntity>
    {
        public void Configure(EntityTypeBuilder<SkilltreePointEntity> builder)
        {
            builder.ToView("SkilltreePoints");
            builder.HasNoKey();
        }
    }
}
