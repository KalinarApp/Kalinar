using Hero.Server.Core.Database;
using Hero.Server.Core.Repositories;
using Hero.Server.DataAccess.Database;
using Hero.Server.Identity;

using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Primitives;
using Microsoft.IdentityModel.Tokens;

namespace Hero.Server.Identity.Attributes
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
    public class IsGroupMemberAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            if (context.HttpContext.Request.Headers.TryGetValue(IGroupContext.Header, out StringValues value))
            {
                string? groupString = value.FirstOrDefault();
                if (!groupString.IsNullOrEmpty() && Guid.TryParse(value.FirstOrDefault(), out Guid groupId))
                {
                    IGroupContextBuilder groupContext = context.HttpContext.RequestServices.GetRequiredService<IGroupContextBuilder>();
                    IGroupRepository repo = context.HttpContext.RequestServices.GetRequiredService<IGroupRepository>();

                    groupContext.Apply(groupId);

                    repo.EnsureIsMemberOrOwner(context.HttpContext.User.GetUserId());
                }
                else
                {
                    throw new ArgumentException("Group is not valid");
                }
            }
            else
            {
                throw new ArgumentException("Group is missing");
            }
        }
    }
}
