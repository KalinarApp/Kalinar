using Hero.Server.Core.Models;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.Core.ModelConfigurations
{
    public class CharacterModelConfiguration : IEntityTypeConfiguration<Character>
    {
        public void Configure(EntityTypeBuilder<Character> builder)
        {
            builder.ToTable("Characters");
            builder.HasKey(x => x.Id);

            builder.Property(c => c.Name).IsRequired();
            builder.Property(c => c.Name).HasMaxLength(100);

            builder.Property(c => c.Profession).HasMaxLength(100);
            builder.Property(c => c.Religion).HasMaxLength(100);
            builder.Property(c => c.Relationship).HasMaxLength(100);

            builder.Property(c => c.IsPublic).HasDefaultValue(false);

            builder
                .HasMany(charakter => charakter.Skilltrees)
                .WithOne(tree => tree.Character)
                .HasForeignKey(nodeTree => nodeTree.CharacterId)
                .OnDelete(DeleteBehavior.SetNull);
            builder
                .HasOne(character => character.Race)
                .WithMany()
                .HasForeignKey(character => character.RaceId)
                .OnDelete(DeleteBehavior.SetNull);
        }
    }
}
