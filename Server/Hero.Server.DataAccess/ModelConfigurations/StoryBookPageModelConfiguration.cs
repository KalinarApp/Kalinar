using Hero.Server.Core.Models.Storyline;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.DataAccess.ModelConfigurations
{
    public class StoryBookPageModelConfiguration : IEntityTypeConfiguration<StoryBookPage>
    {
        public virtual void Configure(EntityTypeBuilder<StoryBookPage> builder)
        {
            builder.ToTable("StoryBookPage");

            builder.HasKey(x => x.Id);

            builder.Property(page => page.PageNumber);

            builder.Property(page => page.Title).IsRequired().HasMaxLength(256);

            builder.Property(page => page.Content).IsRequired();

            builder.Property(image => image.Title)
                .IsRequired()
                .HasMaxLength(100);

            builder.Property(image => image.IsWritten)
                .HasDefaultValue(false);

            builder.Property(image => image.UpdatedAt)
                .HasDefaultValueSql("now()");

            builder.HasOne(page => page.Group)
                .WithMany()
                .HasForeignKey(page => page.GroupId)
                .OnDelete(DeleteBehavior.Cascade);

            builder
                .HasOne<StoryBook>()
                .WithMany(book => book.Pages)
                .HasForeignKey(page => page.BookId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
