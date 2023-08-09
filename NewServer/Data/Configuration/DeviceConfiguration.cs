using Kalinar.Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Configuration
{
    public class DeviceConfiguration : IEntityTypeConfiguration<DeviceEntity>
    {
        public void Configure(EntityTypeBuilder<DeviceEntity> builder)
        {
            builder.ToTable("Devices");
            builder.HasKey(device => device.Id);
        }
    }
}
