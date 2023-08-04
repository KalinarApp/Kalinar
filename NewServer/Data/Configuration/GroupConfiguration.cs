using Kalinar.Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    public class GroupConfiguration : IEntityTypeConfiguration<GroupEntity>
    {
        public void Configure(EntityTypeBuilder<GroupEntity> builder)
        {
            builder.ToTable("Groups");
            builder.HasKey(group => group.Id);

            builder.Property(group => group.Name).HasMaxLength(256).IsRequired();
            builder.Property(group => group.Description).HasMaxLength(2048);
        }
    }
}
