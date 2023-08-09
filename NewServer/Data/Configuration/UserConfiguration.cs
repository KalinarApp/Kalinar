using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    public class UserConfiguration : IEntityTypeConfiguration<UserEntity>
    {
        public void Configure(EntityTypeBuilder<UserEntity> builder)
        {
            builder.ToTable("Users");
            builder.HasKey(user => user.Id);

            builder.Property(user => user.Username).HasMaxLength(256).IsRequired();
            builder.HasMany(user => user.Devices).WithOne().HasForeignKey(device => device.UserId).OnDelete(DeleteBehavior.Cascade);
        }
    }
}
