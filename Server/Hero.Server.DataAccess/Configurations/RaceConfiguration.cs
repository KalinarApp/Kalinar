using Hero.Server.Core.Models;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.DataAccess.Configurations
{
    public class RaceConfiguration : SuggestableConfiguration<Race>
    {
        public override void Configure(EntityTypeBuilder<Race> builder)
        {
            builder.ToTable("Races");
            builder.HasKey(x => x.Id);

            builder.Property(c => c.Name).IsRequired().HasMaxLength(100);

            base.Configure(builder);
        }
    }
}
