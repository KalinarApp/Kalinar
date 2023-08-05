using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class StoryEventConfiguration : IEntityTypeConfiguration<StoryEventEntity>
    {
        public void Configure(EntityTypeBuilder<StoryEventEntity> builder)
        {
            builder.ToTable("StoryEvents");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Title).HasMaxLength(128).IsRequired();
            builder.Property(x => x.Description).HasMaxLength(2048);
            builder.Property(x => x.IsUnlocked).IsRequired();
            builder.Property(x => x.Order).IsRequired();
            builder.Property(x => x.CreatedAt).IsRequired();
            builder.Property(x => x.Date).HasMaxLength(128);

            builder.HasIndex(x => new { x.GroupId, x.Order }).IsUnique();

            builder.HasOne(x => x.Group).WithMany().HasForeignKey(x => x.GroupId).OnDelete(DeleteBehavior.Cascade);
        }
    }
}
