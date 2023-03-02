using Hero.Server.Core.Models;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.DataAccess.Configurations
{
    public class AttributeRaceConfiguration : IEntityTypeConfiguration<AttributeRace>
    {
        public void Configure(EntityTypeBuilder<AttributeRace> builder)
        {
            builder.ToTable("AttributeRaces");

            builder.HasKey(ac => new { ac.AttributeId, ac.RaceId });
            builder
                .HasOne(ats => ats.Attribute)
                .WithMany(at => at.AttributeRaces)
                .HasForeignKey(ats => ats.AttributeId)
                .OnDelete(DeleteBehavior.Cascade);
            builder
                .HasOne(ats => ats.Race)
                .WithMany(s => s.Attributes)
                .HasForeignKey(ats => ats.RaceId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}