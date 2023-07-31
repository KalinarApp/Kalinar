using Kalinar.Authorization.Requirements;

using Microsoft.AspNetCore.Authorization;

using System.Security.Claims;

namespace Kalinar.Authorization.Handlers
{
    public class IsUserValidHandler : AuthorizationHandler<IsUserValidRequirement>
    {
        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, IsUserValidRequirement requirement)
        {
            string? userId = context.User.FindFirstValue("sub");
            if (userId is null)
            {
                context.Fail(new AuthorizationFailureReason(this, $"Invalid access token - claim 'sub' is missing"));
                return Task.CompletedTask;
            }

            string? email = context.User.FindFirstValue(ClaimTypes.Email);
            if (email is null)
            {
                context.Fail(new AuthorizationFailureReason(this, $"Invalid access token - claim '{ClaimTypes.Email}' is missing"));
                return Task.CompletedTask;
            }

            string? name = context.User.FindFirstValue(ClaimTypes.Name);
            if (name is null)
            {
                context.Fail(new AuthorizationFailureReason(this, $"Invalid access token - claim '{ClaimTypes.Name}' is missing"));
                return Task.CompletedTask;
            }

            context.Succeed(requirement);
            return Task.CompletedTask;
        }
    }
}
