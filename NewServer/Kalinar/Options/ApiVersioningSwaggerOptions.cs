using Microsoft.AspNetCore.Mvc.ApiExplorer;
using Microsoft.Extensions.Options;
using Microsoft.OpenApi.Models;

using Swashbuckle.AspNetCore.SwaggerGen;

namespace Kalinar.Options
{
    public class ApiVersioningSwaggerOptions : IConfigureNamedOptions<SwaggerGenOptions>
    {
        private readonly IApiVersionDescriptionProvider provider;

        public ApiVersioningSwaggerOptions(IApiVersionDescriptionProvider provider)
        {
            this.provider = provider;
        }

        public void Configure(string? name, SwaggerGenOptions options)
        {
            foreach (ApiVersionDescription description in this.provider.ApiVersionDescriptions) 
            {
                options.SwaggerDoc(description.GroupName, this.CreateVersionInfo(description));
            }
        }

        public void Configure(SwaggerGenOptions options)
        {
            this.Configure(options);
        }

        private OpenApiInfo CreateVersionInfo(ApiVersionDescription description)
        {
            OpenApiInfo info = new()
            {
                Title = "API",
                Version = description.ApiVersion.ToString()
            };

            if(description.IsDeprecated)
            {
                info.Description += " This API version has been deprecated. Please use one of the new APIs available from the explorer.";
            }

            return info;
        }

    }
}
