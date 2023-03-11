using Hero.Server.Core.Models;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.DataAccess.Configurations
{
    public class UserConfiguration : IEntityTypeConfiguration<User>
    {
        public void Configure(EntityTypeBuilder<User> builder)
        {
            builder.ToTable("Users");
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Email).HasMaxLength(256);
            builder.Property(x => x.Username).HasMaxLength(256);

            builder
                .HasMany(user => user.Characters)
                .WithOne()
                .HasForeignKey(character => character.UserId)
                .OnDelete(DeleteBehavior.SetNull);
        }
    }
}
