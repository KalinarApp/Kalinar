
using Hero.Server.DataAccess.Database;

using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace Hero.Server.DataAccess.Extensions
{
    public static class IApplicationBuilderExtensions
    {
        public static async Task<IApplicationBuilder> MigrateDatabaseAsync(this IApplicationBuilder builder)
        {
            HeroDbContext context = builder.ApplicationServices.CreateScope().ServiceProvider.GetRequiredService<HeroDbContext>();
            await context.Database.MigrateAsync();

            return builder;
        }
    }
}
