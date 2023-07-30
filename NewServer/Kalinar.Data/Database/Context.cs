using Kalinar.Core.Entities;

using Microsoft.EntityFrameworkCore;

namespace Kalinar.Data.Database
{
    public class Context : DbContext
    {
        public Context(DbContextOptions<Context> options) : base(options) { }

        public DbSet<UserEntity> Users { get; set; }
        public DbSet<UserGroupEntity> UserGroups { get; set; }
        public DbSet<GroupEntity> Groups { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.HasDefaultSchema(Resources.Schema);
            builder.ApplyConfigurationsFromAssembly(typeof(Context).Assembly);
        }
    }
}
