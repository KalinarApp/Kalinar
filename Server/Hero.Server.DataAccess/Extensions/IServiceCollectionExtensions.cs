using Hero.Server.Core.Database;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Database;
using Hero.Server.DataAccess.Repositories;

using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace Hero.Server.DataAccess.Extensions
{
    public static class IServiceCollectionExtensions
    {
        public static IServiceCollection AddDataAccessLayer(this IServiceCollection services, string connectionString)
        {
            services.AddDbContext<HeroDbContext>(
                options => options.UseNpgsql(connectionString, pgOptions => pgOptions.MigrationsHistoryTable(HeroDbResources.MigrationsTable, HeroDbResources.Schema)));

            services.AddScoped<GroupContext>();
            services.AddScoped<IGroupContext>(factory => factory.GetRequiredService<GroupContext>());
            services.AddScoped<IGroupContextBuilder, GroupContextBuilder>();

            services.AddTransient<IUserRepository, UserRepository>();
            services.AddTransient<IAbilityRepository, AbilityRepository>();
            services.AddTransient<IAttributeRepository, AttributeRepository>();
            services.AddTransient<ICharacterRepository, CharacterRepository>();
            services.AddTransient<ISkilltreeRepository, SkilltreeRepository>();
            services.AddTransient<ISkillRepository, SkillRepository>();
            services.AddTransient<ICharacterRepository, CharacterRepository>();
            services.AddTransient<IGroupRepository, GroupRepository>();
            services.AddTransient<IRaceRepository, RaceRepository>();
            services.AddTransient<IBlueprintRepository, BlueprintRepository>();
            services.AddTransient<IStoryEntryRepository, StoryEntryRepository>();
            services.AddTransient<IStoryBookPageRepository, StoryBookPageRepository>();

            return services;
        }
    }
}
