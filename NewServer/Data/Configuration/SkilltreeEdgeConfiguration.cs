using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Kalinar.Data.Configuration
{
    internal class SkilltreeEdgeConfiguration : IEntityTypeConfiguration<SkilltreeEdgeEntity>
    {
        public void Configure(EntityTypeBuilder<SkilltreeEdgeEntity> builder)
        {
            builder.ToTable("SkilltreeEdges");
            builder.HasKey(x => new { x.StartId, x.EndId });

            builder.HasOne(x => x.Skilltree).WithMany(x => x.Edges).HasForeignKey(x => x.SkilltreeId).OnDelete(DeleteBehavior.Cascade);
            builder.HasOne(x => x.Start).WithMany().HasForeignKey(x => x.StartId).OnDelete(DeleteBehavior.Cascade);
            builder.HasOne(x => x.End).WithMany().HasForeignKey(x => x.EndId).OnDelete(DeleteBehavior.Cascade);
        }
    }
}
