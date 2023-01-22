using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace Hero.Server.DataAccess.Database
{
    internal class HeroDbContextFactory : IDesignTimeDbContextFactory<HeroDbContext>
    {
        public HeroDbContext CreateDbContext(string[] args)
        {
            string connectionString;
            if (0 == args.Length)
            {
                connectionString = Environment.GetEnvironmentVariable("ConnectionStrings__Default");
            }
            else
            {
                connectionString = args[0];
            }

            if (null == connectionString)
            {
                throw new ArgumentNullException("Connection string has to be passed as the first argument.");
            }

            DbContextOptionsBuilder<HeroDbContext> builder = new ();
            builder.EnableSensitiveDataLogging();
            builder.UseNpgsql(connectionString, options => options.MigrationsHistoryTable(HeroDbResources.MigrationsTable, HeroDbResources.Schema));

            return new HeroDbContext(builder.Options);
        }
    }
}
