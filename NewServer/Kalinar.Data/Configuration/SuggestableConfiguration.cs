using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class SuggestableConfiguration<T> : IEntityTypeConfiguration<T>
        where T : SuggestableEntity
    {
        public virtual void Configure(EntityTypeBuilder<T> builder)
        {
            builder.HasKey(x => x.Id);

            builder.Property(x => x.State).HasConversion(state => state.ToString(), state => Enum.Parse<SuggestionState>(state)).IsRequired();
            builder.Property(x => x.CreatedAt).IsRequired();
            builder.Property(x => x.RejectionReason).HasMaxLength(2048);
            builder.HasOne(x => x.Creator).WithMany().HasForeignKey(x => x.CreatorId).OnDelete(DeleteBehavior.Cascade);
            builder.HasOne(x => x.Group).WithMany().HasForeignKey(x => x.GroupId).OnDelete(DeleteBehavior.Cascade);
        }
    }
}
