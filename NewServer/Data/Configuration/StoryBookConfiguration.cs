using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class StoryBookConfiguration : IEntityTypeConfiguration<StoryBookEntity>
    {
        public void Configure(EntityTypeBuilder<StoryBookEntity> builder)
        {
            builder.ToTable("StoryBooks");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Title).HasMaxLength(128).IsRequired();
            builder.Property(x => x.IsUnlocked).IsRequired();
            builder.Property(x => x.CreatedAt).IsRequired();

            builder.HasOne(x => x.Group).WithMany().HasForeignKey(x => x.GroupId).OnDelete(DeleteBehavior.Cascade);
            builder.HasMany(x => x.Pages).WithOne().HasForeignKey(x => x.BookId).OnDelete(DeleteBehavior.Cascade);
        }
    }
}
