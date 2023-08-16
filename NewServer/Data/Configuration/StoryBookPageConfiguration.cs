using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class StoryBookPageConfiguration : IEntityTypeConfiguration<StoryBookPageEntity>
    {
        public void Configure(EntityTypeBuilder<StoryBookPageEntity> builder)
        {
            builder.ToTable("StoryBookPages");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Title).HasMaxLength(128).IsRequired();
            builder.Property(x => x.Content).IsRequired();
            builder.Property(x => x.IsUnlocked).IsRequired();
            builder.Property(x => x.PageNumber).HasDefaultValue(0);   

            builder.HasIndex(x => new { x.BookId, x.PageNumber }).IsUnique();
        }
    }
}
