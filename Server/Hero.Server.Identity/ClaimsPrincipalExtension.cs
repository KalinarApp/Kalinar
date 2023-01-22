using System.Security.Claims;
using System.Text.Json;

namespace Hero.Server.Identity
{
    public static class ClaimsPrincipalExtension
    {
        public static TValue? FindFirstValue<TValue>(this ClaimsPrincipal principal, string claimType)
        {
            TValue? result = default;
            string? value = principal.FindFirstValue(claimType);
            if (null != value)
            {
                result = Core.Extensions.Convert.To<TValue>(value);
            }

            return result;
        }

        public static string GetUserId(this ClaimsPrincipal principal)
        {
            Claim userIdClaim = principal.FindFirst(c => c.Type == System.Security.Claims.ClaimTypes.NameIdentifier) ?? principal.FindFirst(c => c.Type == "sub");
            if (userIdClaim != null && !String.IsNullOrEmpty(userIdClaim.Value))
            {
                return new(userIdClaim.Value);
            }

            throw new ArgumentNullException("userId");
        }
    }
}
