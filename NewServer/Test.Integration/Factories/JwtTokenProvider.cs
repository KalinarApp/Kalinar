using Microsoft.IdentityModel.Tokens;

using System.IdentityModel.Tokens.Jwt;

namespace Kalinar.Test.Integration.Factories
{
    internal class JwtTokenProvider
    {
        public static string Issuer { get; } = "Testing";
        public static SecurityKey SecurityKey { get; } = new SymmetricSecurityKey(Guid.NewGuid().ToByteArray());
        public static SigningCredentials SigningCredentials { get; } = new SigningCredentials(SecurityKey, SecurityAlgorithms.HmacSha256);
        public static readonly JwtSecurityTokenHandler JwtSecurityTokenHandler = new();
    }
}
