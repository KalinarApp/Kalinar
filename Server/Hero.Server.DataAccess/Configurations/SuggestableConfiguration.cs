using Hero.Server.Core.Models;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.DataAccess.Configurations
{
    public class SuggestableConfiguration<T> : IEntityTypeConfiguration<T>
        where T : Suggestable
    {
        public virtual void Configure(EntityTypeBuilder<T> builder)
        {
            builder.HasKey(x => x.Id);

            builder.Property(x => x.State)
                .IsRequired()
                .HasConversion(x => x.ToString(), x => (SuggestionState)Enum.Parse(typeof(SuggestionState), x));

            builder.Property(x => x.CreatedAt)
                .IsRequired()
                .HasDefaultValueSql("now()");

            builder.Property(x => x.RejectionReason).HasMaxLength(2000);

            builder.Property(x => x.CreatorId).HasDefaultValue("qmMgPtrCXXgvpT6oYYxZE8IA1Aw1");

            builder
                .HasOne(x => x.Creator)
                .WithMany()
                .HasForeignKey(x => x.CreatorId)
                .OnDelete(DeleteBehavior.Cascade);

            // Attributes can currently not have an real relation because of the global attributes which are in an non existing group with the id Guid.Empty
            if (typeof(T) != typeof(Core.Models.Attribute))
            {
                builder
                .HasOne(x => x.Group)
                .WithMany()
                .HasForeignKey(builder => builder.GroupId)
                .OnDelete(DeleteBehavior.Cascade);
            }
        }
    }
}
