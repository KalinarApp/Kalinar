using Kalinar.Authorization;
using Kalinar.Authorization.Actions;
using Kalinar.Authorization.Handlers;
using Kalinar.Authorization.Requirements;
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
            serviceCollection.AddSingleton<IAuthorizationHandler, AbilityHandler>();
            serviceCollection.AddSingleton<IAuthorizationHandler, SkillHandler>();
            serviceCollection.AddSingleton<IAuthorizationHandler, RaceHandler>();
            serviceCollection.AddSingleton<IAuthorizationHandler, CharacterHandler>();
            serviceCollection.AddSingleton<IAuthorizationHandler, SkilltreeHandler>();
            serviceCollection.AddSingleton<IAuthorizationHandler, StoryHandler>();
            serviceCollection.AddSingleton<IAuthorizationHandler, ReadStoryHandler>();

            serviceCollection.AddSingleton<IAuthorizationMiddlewareResultHandler, CustomAuthorizationMiddlewareResultHandler>();
            serviceCollection.AddAuthorization(options =>
            {
                options.AddPolicy(PolicyNames.IsValidUser, policy => policy.AddRequirements(new IsUserValidRequirement()));

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

                options.AddPolicy(PolicyNames.CanListSuggestables, policy => policy.AddRequirements(new IsInGroupRequirement()));
                options.AddPolicy(PolicyNames.CanReadSuggestable, policy => policy.AddRequirements(new SuggestableRequirement(SuggestableAction.Read)));
                options.AddPolicy(PolicyNames.CanCreateSuggestable, policy => policy.AddRequirements(new IsInGroupRequirement()));
                options.AddPolicy(PolicyNames.CanUpdateSuggestable, policy => policy.AddRequirements(new SuggestableRequirement(SuggestableAction.Update)));
                options.AddPolicy(PolicyNames.CanApproveSuggestable, policy => policy.AddRequirements(new SuggestableRequirement(SuggestableAction.Approve)));
                options.AddPolicy(PolicyNames.CanDeleteSuggestable, policy => policy.AddRequirements(new SuggestableRequirement(SuggestableAction.Delete)));

                options.AddPolicy(PolicyNames.CanSetAbilityTags, policy => policy.AddRequirements(new AbilityRequirement(AbilityAction.SetTags)));
                options.AddPolicy(PolicyNames.CanSetSkillAttributes, policy => policy.AddRequirements(new SkillRequirement(SkillAction.SetAttributes)));
                options.AddPolicy(PolicyNames.CanSetRaceAttributes, policy => policy.AddRequirements(new RaceRequirement(RaceAction.SetAttributes)));

                options.AddPolicy(PolicyNames.CanListCharacters, policy => policy.AddRequirements(new IsInGroupRequirement()));
                options.AddPolicy(PolicyNames.CanCreateCharacter, policy => policy.AddRequirements(new IsInGroupRequirement()));
                options.AddPolicy(PolicyNames.CanReadCharacter, policy => policy.AddRequirements(new CharacterRequirement(CharacterAction.Read)));
                options.AddPolicy(PolicyNames.CanUpdateCharacter, policy => policy.AddRequirements(new CharacterRequirement(CharacterAction.Update)));
                options.AddPolicy(PolicyNames.CanDeleteCharacter, policy => policy.AddRequirements(new CharacterRequirement(CharacterAction.Delete)));

                options.AddPolicy(PolicyNames.CanListSkilltrees, policy => policy.AddRequirements(new SkilltreeRequirement(SkilltreeAction.List)));
                options.AddPolicy(PolicyNames.CanReadSkilltree, policy => policy.AddRequirements(new SkilltreeRequirement(SkilltreeAction.Read)));
                options.AddPolicy(PolicyNames.CanCreateSkilltree, policy => policy.AddRequirements(new SkilltreeRequirement(SkilltreeAction.Create)));
                options.AddPolicy(PolicyNames.CanUpdateSkilltree, policy => policy.AddRequirements(new SkilltreeRequirement(SkilltreeAction.Update)));
                options.AddPolicy(PolicyNames.CanDeleteSkilltree, policy => policy.AddRequirements(new SkilltreeRequirement(SkilltreeAction.Delete)));

                options.AddPolicy(PolicyNames.CanListStoryItems, policy => policy.AddRequirements(new ReadStoryRequirement(StoryAction.List)));
                options.AddPolicy(PolicyNames.CanReadStoryItem, policy => policy.AddRequirements(new ReadStoryRequirement(StoryAction.Read)));
                options.AddPolicy(PolicyNames.CanCreateStoryItem, policy => policy.AddRequirements(new StoryRequirement(StoryAction.Create)));
                options.AddPolicy(PolicyNames.CanUpdateStoryItem, policy => policy.AddRequirements(new StoryRequirement(StoryAction.Update)));
                options.AddPolicy(PolicyNames.CanDeleteStoryItem, policy => policy.AddRequirements(new StoryRequirement(StoryAction.Delete)));
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
