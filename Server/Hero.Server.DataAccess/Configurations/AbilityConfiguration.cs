using Hero.Server.Core.Models;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Hero.Server.DataAccess.Configurations
{
    public class AbilityConfiguration : SuggestableConfiguration<Ability>
    {
        public override void Configure(EntityTypeBuilder<Ability> builder)
        {
            builder.ToTable("Abilities");
            base.Configure(builder);

            builder.Property(x => x.Name).IsRequired();
            builder.Property(c => c.Name).HasMaxLength(100);

            builder.Property(a => a.Description).HasMaxLength(2048);

            builder.Property(c => c.IsPassive).IsRequired();
        }
    }
}
