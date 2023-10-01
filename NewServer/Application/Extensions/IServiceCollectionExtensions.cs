using Kalinar.Application.Contracts;
using Kalinar.Application.Services;

using Microsoft.Extensions.DependencyInjection;

namespace Kalinar.Application.Extensions
{
    public static class IServiceCollectionExtensions
    {
        public static void AddApplicationLayer(this IServiceCollection services)
        {
            services.AddScoped<IUserService, UserService>();
            services.AddScoped<IGroupService, GroupService>();
            services.AddScoped<IGroupMemberService, GroupMemberService>();
            services.AddScoped<IAbilityService, AbilityService>();
            services.AddScoped<IAttributeService, AttributeService>();
            services.AddScoped<ISkillService, SkillService>();
            services.AddScoped<IRaceService, RaceService>();
            services.AddScoped<ICharacterService, CharacterService>();
            services.AddScoped<ICharacterSkillService, CharacterSkillsService>();
            services.AddScoped<ISkilltreeService, SkilltreeService>();
            services.AddScoped<IStoryBookService, StoryBookService>();
            services.AddScoped<IStoryEventService, StoryEventService>();
            services.AddScoped<IStoryImageService, StoryImageService>();
        }
    }
}
