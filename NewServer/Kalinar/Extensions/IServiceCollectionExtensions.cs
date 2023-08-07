using Kalinar.Authorization;
using Kalinar.Authorization.Actions;
using Kalinar.Authorization.Handlers;
using Kalinar.Authorization.Requirements;
using Kalinar.Core.Entities;
using Kalinar.ErrorHandling;
using Kalinar.Options;

using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Versioning;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;

namespace Kalinar.Application.Extensions
{
    public static class IServiceCollectionExtensions
    {
        public static void AddApplicationPolicies(this IServiceCollection serviceCollection)
        {
            serviceCollection.AddSingleton<IAuthorizationHandler, IsUserValidHandler>();
            serviceCollection.AddSingleton<IAuthorizationHandler, IsInGroupHandler>();
            serviceCollection.AddSingleton<IAuthorizationHandler, UserHandler>();
            serviceCollection.AddSingleton<IAuthorizationHandler, GroupHandler>();
            serviceCollection.AddSingleton<IAuthorizationHandler, SuggestableHandler>();

            serviceCollection.AddSingleton<IAuthorizationMiddlewareResultHandler, CustomAuthorizationMiddlewareResultHandler>();
            serviceCollection.AddAuthorization(options =>
            {
                options.AddPolicy(PolicyNames.IsValidUser, policy => policy.AddRequirements(new IsUserValidRequirement()));

                options.AddPolicy(PolicyNames.IsAdminInGroup, policy => policy.AddRequirements(new IsInGroupRequirement(new[] { Role.Owner, Role.Administrator })));
                options.AddPolicy(PolicyNames.IsMemberInGroup, policy => policy.AddRequirements(new IsInGroupRequirement(new[] { Role.Member })));

                options.AddPolicy(PolicyNames.CanListUsers, policy => policy.AddRequirements(new UserRequirement(UserAction.List)));
                options.AddPolicy(PolicyNames.CanReadUsers, policy => policy.AddRequirements(new UserRequirement(UserAction.Read)));
                options.AddPolicy(PolicyNames.CanCreateUsers, policy => policy.AddRequirements(new UserRequirement(UserAction.Create)));
                options.AddPolicy(PolicyNames.CanUpdateUsers, policy => policy.AddRequirements(new UserRequirement(UserAction.Update)));
                options.AddPolicy(PolicyNames.CanDeleteUsers, policy => policy.AddRequirements(new UserRequirement(UserAction.Delete)));

                options.AddPolicy(PolicyNames.CanListGroups, policy => policy.AddRequirements(new GroupRequirement(GroupAction.List)));
                options.AddPolicy(PolicyNames.CanReadGroups, policy => policy.AddRequirements(new GroupRequirement(GroupAction.Read)));
                options.AddPolicy(PolicyNames.CanCreateGroups, policy => policy.AddRequirements(new GroupRequirement(GroupAction.Create)));
                options.AddPolicy(PolicyNames.CanUpdateGroups, policy => policy.AddRequirements(new GroupRequirement(GroupAction.Update)));
                options.AddPolicy(PolicyNames.CanDeleteGroups, policy => policy.AddRequirements(new GroupRequirement(GroupAction.Delete)));

                options.AddPolicy(PolicyNames.CanListSuggestables, policy => policy.AddRequirements(new SuggestableRequirement(SuggestableAction.List)));
                options.AddPolicy(PolicyNames.CanReadSuggestable, policy => policy.AddRequirements(new SuggestableRequirement(SuggestableAction.Read)));
                options.AddPolicy(PolicyNames.CanCreateSuggestable, policy => policy.AddRequirements(new SuggestableRequirement(SuggestableAction.Create)));
                options.AddPolicy(PolicyNames.CanUpdateSuggestable, policy => policy.AddRequirements(new SuggestableRequirement(SuggestableAction.Update)));
                options.AddPolicy(PolicyNames.CanApproveSuggestable, policy => policy.AddRequirements(new SuggestableRequirement(SuggestableAction.Approve)));
                options.AddPolicy(PolicyNames.CanDeleteSuggestable, policy => policy.AddRequirements(new SuggestableRequirement(SuggestableAction.Delete)));
            });
        }

        public static void AddFirebaseAuthentication(this IServiceCollection services, Action<JwtBearerOptions>? configureOptions = default)
        {
            services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
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

            services.AddSwaggerGen(options =>
            {
                options.AddSecurityDefinition(JwtBearerDefaults.AuthenticationScheme, new OpenApiSecurityScheme
                {
                    Name = "Authorization",
                    Type = SecuritySchemeType.Http,
                    Scheme = JwtBearerDefaults.AuthenticationScheme,
                    BearerFormat = "JWT",
                    In = ParameterLocation.Header,
                });
                options.AddSecurityRequirement(new OpenApiSecurityRequirement
                {
                    {
                        new OpenApiSecurityScheme
                        {
                            Reference = new OpenApiReference
                            {
                                Type = ReferenceType.SecurityScheme,
                                Id = JwtBearerDefaults.AuthenticationScheme,
                            }
                        },
                        Array.Empty<string>()
                    }
                    
                });
            });
        }

        public static void AddAndConfigureVersioning(this IServiceCollection services, IErrorResponseProvider provider)
        {
            services.AddApiVersioning(options =>
            {
                options.AssumeDefaultVersionWhenUnspecified = true;
                options.DefaultApiVersion = ApiVersion.Default;
                options.ReportApiVersions = true;
                options.ApiVersionReader = new UrlSegmentApiVersionReader();
                options.ErrorResponses = provider;
            });

            services.AddVersionedApiExplorer(setup =>
            {
                setup.GroupNameFormat = "'v'VVV";
                setup.SubstituteApiVersionInUrl = true;
            });

            services.ConfigureOptions<ApiVersioningSwaggerOptions>();
        }
    }
}
