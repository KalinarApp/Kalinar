using Kalinar.Core.Exceptions;

using Microsoft.AspNetCore.Authorization;

using System.Security.Claims;

namespace Kalinar.Extensions
{
    public static class IAuthorizationServiceExtension
    {
        public static async Task AuthorizeOrThrowAsync(this IAuthorizationService service, ClaimsPrincipal user, string policyName)
        {
            AuthorizationResult result = await service.AuthorizeAsync(user, policyName);
            if (!result.Succeeded)
            {
                throw new ForbiddenAccessException(result.Failure?.FailureReasons.FirstOrDefault()?.Message);
            }
        }

        public static async Task AuthorizeOrThrowAsync(this IAuthorizationService service, ClaimsPrincipal user, object? resource, string policyName)
        {
            AuthorizationResult result = await service.AuthorizeAsync(user, resource, policyName);
            if (!result.Succeeded)
            {
                throw new ForbiddenAccessException(result.Failure?.FailureReasons.FirstOrDefault()?.Message);
            }
        }
    }
}
