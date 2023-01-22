using System.IdentityModel.Tokens.Jwt;

namespace Hero.Server.Identity
{
    public class ClaimTypes
    {
        public const string Id = JwtRegisteredClaimNames.Sub;
        public const string Email = JwtRegisteredClaimNames.Email;
        public const string FamilyName = JwtRegisteredClaimNames.FamilyName;
        public const string GivenName = JwtRegisteredClaimNames.GivenName;
        public const string Name = JwtRegisteredClaimNames.Name;
        public const string Group = "group";
        public const string Role = "roles";
    }
}
