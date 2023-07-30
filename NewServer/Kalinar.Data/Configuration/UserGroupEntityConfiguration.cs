using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    public class UserGroupEntityConfiguration : IEntityTypeConfiguration<UserGroupEntity>
    {
        public void Configure(EntityTypeBuilder<UserGroupEntity> builder)
        {
            builder.ToTable("UserGroups");
            builder.HasKey(group => new { group.UserId, group.GroupId});

            builder
                .Property(group => group.Role)
                .IsRequired()
                .HasConversion(role => role.ToString(), role => Enum.Parse<RoleEntity>(role));

            builder
                .HasOne(group => group.User)
                .WithMany(user => user.Groups)
                .HasForeignKey(group => group.UserId)
                .OnDelete(DeleteBehavior.Cascade);

            builder
                .HasOne(group => group.Group)
                .WithMany(group => group.Members)
                .HasForeignKey(group => group.GroupId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
