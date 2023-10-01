using Kalinar.Core.Views;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class SkilltreePointsViewConfiguration : IEntityTypeConfiguration<SkilltreePointsView>
    {
        public void Configure(EntityTypeBuilder<SkilltreePointsView> builder)
        {
            builder.ToView("SkilltreePoints");
            builder.HasNoKey();
        }
    }
}
