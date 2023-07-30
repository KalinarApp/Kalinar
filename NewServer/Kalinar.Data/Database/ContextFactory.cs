using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore.Query;

namespace Kalinar.Data.Database
{
    internal class ContextFactory : IDesignTimeDbContextFactory<Context>
    {
        public Context CreateDbContext(string[] args)
        {
            string connectionString;
            if (0 == args.Length)
            {
                connectionString = Environment.GetEnvironmentVariable("ConnectionStrings__Database")!;
            }
            else
            {
                connectionString = args[0];
            }

            if (null == connectionString)
            {
                throw new ArgumentNullException("Connection string has to be passed as the first argument.");
            }

            DbContextOptionsBuilder<Context> builder = new();
            builder.EnableSensitiveDataLogging();
            builder.UseNpgsql(connectionString, options => options.MigrationsHistoryTable(Resources.MigrationsTable, Resources.Schema));

            return new Context(builder.Options);
        }
    }
}
