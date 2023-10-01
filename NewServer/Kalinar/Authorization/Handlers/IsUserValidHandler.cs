using Kalinar.Authorization.Requirements;

using Microsoft.AspNetCore.Authorization;

using System.Security.Claims;

namespace Kalinar.Authorization.Handlers
{
    public class IsUserValidHandler : AuthorizationHandler<IsUserValidRequirement>
    {
        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, IsUserValidRequirement requirement)
        {
            string? userId = context.User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (userId is null)
            {
                context.Fail(new AuthorizationFailureReason(this, $"Invalid access token - claim 'sub' is missing"));
                return Task.CompletedTask;
            }

            context.Succeed(requirement);
            return Task.CompletedTask;
        }
    }
}
