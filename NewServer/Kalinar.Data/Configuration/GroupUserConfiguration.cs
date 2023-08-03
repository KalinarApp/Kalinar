using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    public class GroupUserConfiguration : IEntityTypeConfiguration<GroupUsersEntity>
    {
        public void Configure(EntityTypeBuilder<GroupUsersEntity> builder)
        {
            builder.ToTable("GroupUsers");
            builder.HasKey(group => new { group.UserId, group.GroupId});

            builder
                .Property(group => group.Role)
                .IsRequired()
                .HasConversion(role => role.ToString(), role => Enum.Parse<Role>(role));

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
