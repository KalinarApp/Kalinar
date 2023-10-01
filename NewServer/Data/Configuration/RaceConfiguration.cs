using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class RaceConfiguration : SuggestableConfiguration<RaceEntity>
    {
        public override void Configure(EntityTypeBuilder<RaceEntity> builder)
        {
            builder.ToTable("Races");

            builder.Property(x => x.Name).HasMaxLength(128).IsRequired();

            base.Configure(builder);
        }
    }
}
