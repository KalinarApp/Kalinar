using Kalinar.Authorization.Actions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Requirements
{
    public class CharacterRequirement : IAuthorizationRequirement
    {
        public CharacterAction Action { get; }

        public CharacterRequirement(CharacterAction action)
        {
            this.Action = action;
        }
    }
}
