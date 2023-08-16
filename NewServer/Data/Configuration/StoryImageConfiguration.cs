using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class StoryImageConfiguration : IEntityTypeConfiguration<StoryImageEntity>
    {
        public void Configure(EntityTypeBuilder<StoryImageEntity> builder)
        {
            builder.ToTable("StoryImages");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Title).HasMaxLength(128).IsRequired();
            builder.Property(x => x.ImageUrl).IsRequired();
            builder.Property(x => x.IsUnlocked).IsRequired();
            builder.Property(x => x.CreatedAt).IsRequired();

            builder.HasOne(x => x.Group).WithMany().HasForeignKey(x => x.GroupId).OnDelete(DeleteBehavior.Cascade);
        }
    }
}
