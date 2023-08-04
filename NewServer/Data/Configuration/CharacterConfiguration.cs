using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class CharacterConfiguration : IEntityTypeConfiguration<CharacterEntity>
    {
        public void Configure(EntityTypeBuilder<CharacterEntity> builder)
        {
            builder.ToTable("Characters");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Name).HasMaxLength(128).IsRequired();
            builder.Property(x => x.Profession).HasMaxLength(128);
            builder.Property(x => x.Religion).HasMaxLength(128);
            builder.Property(x => x.Relationship).HasMaxLength(128);
            
            builder.HasMany(x => x.Skilltrees).WithOne(x => x.Character).HasForeignKey(x => x.CharacterId).OnDelete(DeleteBehavior.SetNull);
            builder.HasOne(x => x.Race).WithMany().HasForeignKey(x => x.RaceId).OnDelete(DeleteBehavior.Restrict);
        }
    }
}
