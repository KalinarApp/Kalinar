using Hero.Server.DataAccess.Database;
using Hero.Server.Identity.Attributes;

using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Any;
using Microsoft.OpenApi.Models;

using Swashbuckle.AspNetCore.SwaggerGen;

using System.Reflection;
using System.Text.Json;

namespace Hero.Server.Identity
{
    public class GroupFilter : IOperationFilter
    {
        public void Apply(OpenApiOperation operation, OperationFilterContext context)
        {
            if (context.MethodInfo.GetCustomAttribute(typeof(IsGroupMemberAttribute)) is IsGroupMemberAttribute isGroupMember 
                || context.MethodInfo.GetCustomAttribute(typeof(IsGroupAdminAttribute)) is IsGroupAdminAttribute isGroupAdmin)
            {
                OpenApiParameter? existingParam = operation.Parameters.FirstOrDefault(p =>
                p.In == ParameterLocation.Header && p.Name == IGroupContext.Header);
                if (existingParam != null) // remove description from [FromHeader] argument attribute
                {
                    operation.Parameters.Remove(existingParam);
                }

                operation.Parameters.Add(new OpenApiParameter
                {
                    Name = IGroupContext.Header,
                    In = ParameterLocation.Header,
                    Required = true
                });
            }
        }
    }

    public static class IServiceCollectionExtension
    {

        public static void AddSwaggerForAuthentication(this IServiceCollection services)
        {
            services.AddSwaggerGen(options =>
            {
                options.SwaggerDoc("v1", new OpenApiInfo { Title = "Hero API", Version = "v1" });   
                options.AddSecurityDefinition(JwtBearerDefaults.AuthenticationScheme, new OpenApiSecurityScheme
                {
                    Name = "Authorization",
                    Type = SecuritySchemeType.Http,
                    Scheme = JwtBearerDefaults.AuthenticationScheme,
                    BearerFormat = "JWT",
                    In = ParameterLocation.Header
                });
                options.AddSecurityRequirement(new OpenApiSecurityRequirement
                {
                    {
                        new OpenApiSecurityScheme
                        {
                            Reference = new OpenApiReference
                            {
                                Type = ReferenceType.SecurityScheme,
                                Id = JwtBearerDefaults.AuthenticationScheme
                            }
                        },
                        Array.Empty<string>()
                    }
                });

                options.OperationFilter<GroupFilter>();
            });
        }

        public static AuthenticationBuilder AddJwtBearerAuthentication(this IServiceCollection services, Action<JwtBearerOptions>? configureOptions = default)
        {
            return services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
            {
                options.Authority = "https://securetoken.google.com/kalinar-app";
                options.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidIssuer = "https://securetoken.google.com/kalinar-app",
                    ValidateAudience = true,
                    ValidAudience = "kalinar-app",
                    ValidateLifetime = true,
                };
                configureOptions?.Invoke(options);
            });
        }
    }
}
