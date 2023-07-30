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
        }
    }
}
