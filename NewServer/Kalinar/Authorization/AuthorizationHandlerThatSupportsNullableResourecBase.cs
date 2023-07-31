using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization
{
    /// <summary>
    /// The default handler does not support nullable resource types, so we implemented our own for those situations.
    /// </summary>
    public abstract class AuthorizationHandlerThatSupportsNullableResourceBase<TRequirement, TResource> : IAuthorizationHandler
        where TRequirement : IAuthorizationRequirement
        where TResource : class?
    {
        public virtual async Task HandleAsync(AuthorizationHandlerContext context)
        {
            TResource? resource;
            switch (context.Resource)
            {
                case null:
                    resource = null;
                    break;
                case TResource contextResource:
                    resource = contextResource;
                    break;
                default:
                    return;
            }

            foreach (TRequirement req in context.Requirements.OfType<TRequirement>())
            {
                await this.HandleRequirementAsync(context, req, resource);
            }
        }

        protected abstract Task HandleRequirementAsync(AuthorizationHandlerContext context, TRequirement requirement, TResource? resource);
    }
}
