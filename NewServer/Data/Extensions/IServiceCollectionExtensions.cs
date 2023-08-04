using Kalinar.Application.Contracts;
using Kalinar.Data.Database;
using Kalinar.Data.Repositories;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace Kalinar.Data.Extensions
{
    public static class IServiceCollectionExtensions
    {
        public static void AddDataLayer(this IServiceCollection services, string connectionString)
        {
            services.AddDbContext<Context>(options => options.UseNpgsql(connectionString, pgOptions => pgOptions.MigrationsHistoryTable(Resources.MigrationsTable, Resources.Schema)));

            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<IGroupRepository, GroupRepository>();
            services.AddScoped<IGroupMemberRepository, GroupMemberRepository>();
            services.AddScoped<IAbilityRepository, AbilityRepository>();
            services.AddScoped<IAttributeRepository, AttributeRepository>();
            services.AddScoped<ISkillRepository, SkillRepository>();
        }
    }
}
