using Kalinar.Data.Database;

using Microsoft.AspNetCore.Mvc.ApiExplorer;
using Microsoft.EntityFrameworkCore;

namespace Kalinar.Extensions
{
    public static class IApplicationBuilderExtensions
    {
        public static void UseSwaggerUIWithVersioning(this IApplicationBuilder builder)
        {
            builder.UseSwaggerUI(options =>
            {
                IApiVersionDescriptionProvider provider = builder.ApplicationServices.GetRequiredService<IApiVersionDescriptionProvider>();
                foreach (ApiVersionDescription description in provider.ApiVersionDescriptions.Reverse())
                {
                    options.SwaggerEndpoint($"/swagger/{description.GroupName}/swagger.json", description.GroupName.ToUpperInvariant());
                }
            });
        }

        public static async Task UseDatabaseMigrations(this WebApplication builder)
        {
            using AsyncServiceScope serviceScope = builder.Services.CreateAsyncScope();
            Context context = serviceScope.ServiceProvider.GetRequiredService<Context>();

            if (context.Database.IsRelational() && !builder.Environment.IsStaging()) await context.Database.MigrateAsync();
        }
    }
}
