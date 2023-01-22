using Hero.Server.Core.Models;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.DataAccess.ModelConfigurations
{
    public class GroupModelConfiguration : IEntityTypeConfiguration<Group>
    {
        public void Configure(EntityTypeBuilder<Group> builder)
        {
            builder.ToTable("Groups");
            builder.HasKey(g => g.Id);

            builder.Property(g => g.Name).IsRequired();
            builder.Property(g => g.Name).HasMaxLength(100);

            builder.Property(g => g.InviteCode).IsRequired();
            builder.Property(g => g.InviteCode).HasMaxLength(12);

            builder
                .HasMany(g => g.Members)
                .WithOne(u => u.Group)
                .HasForeignKey(u => u.GroupId)
                .OnDelete(DeleteBehavior.SetNull);

            builder
                .HasOne(g => g.Owner)
                .WithOne(u => u.OwnedGroup)
                .HasForeignKey<Group>(g => g.OwnerId)
                .OnDelete(DeleteBehavior.SetNull);

            builder
                .HasMany(g => g.Abilities)
                .WithOne()
                .HasForeignKey(ability => ability.GroupId)
                .OnDelete(DeleteBehavior.Cascade);

            builder
                .HasMany(g => g.Skills)
                .WithOne()
                .HasForeignKey(skill => skill.GroupId)
                .OnDelete(DeleteBehavior.Cascade);

            builder
                .HasMany(g => g.Characters)
                .WithOne()
                .HasForeignKey(character => character.GroupId)
                .OnDelete(DeleteBehavior.Cascade);

            builder
                .HasMany(g => g.Skilltrees)
                .WithOne()
                .HasForeignKey(tree => tree.GroupId)
                .OnDelete(DeleteBehavior.Cascade);

            builder
                .HasMany(g => g.StoryEntries)
                .WithOne()
                .HasForeignKey(storyEntry => storyEntry.GroupId)
                .OnDelete(DeleteBehavior.Cascade);

        }
    }
}
