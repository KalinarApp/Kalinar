using Kalinar.Core.Exceptions;

using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authorization.Policy;

namespace Kalinar.ErrorHandling
{
    public class CustomAuthorizationMiddlewareResultHandler : IAuthorizationMiddlewareResultHandler
    {
        private readonly AuthorizationMiddlewareResultHandler defaultHandler = new();

        public async Task HandleAsync(RequestDelegate next, HttpContext context, AuthorizationPolicy policy, PolicyAuthorizationResult authorizeResult)
        {
            if (authorizeResult.Forbidden)
            {
                throw new ForbiddenAccessException(authorizeResult.AuthorizationFailure?.FailureReasons.FirstOrDefault()?.Message);
            }

            await this.defaultHandler.HandleAsync(next, context, policy, authorizeResult);
        }
    }
}
