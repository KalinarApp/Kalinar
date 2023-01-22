using Hero.Server.Core.Models;
using Hero.Server.Core.Models.Storyline;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.DataAccess.ModelConfigurations
{
    public class StoryEntryModelConfiguration : IEntityTypeConfiguration<StoryEntry>
    {
        public void Configure(EntityTypeBuilder<StoryEntry> builder)
        {
            builder.ToTable("StoryEntries");

            builder.HasKey(x => x.Id);

            builder.HasDiscriminator<string>("EntryType")
                .HasValue<StoryImage>("Image")
                .HasValue<StoryBook>("Book");

            builder.Property(image => image.Title)
                .IsRequired()
                .HasMaxLength(100);

            builder.Property(image => image.IsUnlocked)
                .HasDefaultValue(false);

            builder.Property(image => image.UpdatedAt)
                .HasDefaultValueSql("now()");


            builder.Property(image => image.Order);
        }
    }

    public class StoryImageModelConfiguration : IEntityTypeConfiguration<StoryImage>
    {
        public void Configure(EntityTypeBuilder<StoryImage> builder)
        {
            builder.Property(image => image.ImageUrl).IsRequired();
        }
    }

    public class StoryBookModelConfiguration : IEntityTypeConfiguration<StoryBook>
    {
        public void Configure(EntityTypeBuilder<StoryBook> builder)
        {
            builder.HasMany(book => book.Pages)
                .WithOne()
                .HasForeignKey(page => page.BookId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
