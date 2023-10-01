using System.Security.Claims;

namespace Kalinar.Extensions
{
    public static class ClaimsPrincipalExtensions
    {
        public static string GetId(this ClaimsPrincipal principal)
        {
            Claim? userIdClaim = principal.FindFirst(ClaimTypes.NameIdentifier);
            if (userIdClaim is not null && !String.IsNullOrEmpty(userIdClaim.Value))
            {
                return new(userIdClaim.Value);
            }

            throw new ArgumentNullException("userId");
        }
    }
}
