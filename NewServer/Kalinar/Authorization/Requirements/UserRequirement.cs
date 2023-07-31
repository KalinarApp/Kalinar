using Kalinar.Authorization.Actions;

using Microsoft.AspNetCore.Authorization;

namespace Kalinar.Authorization.Requirements
{
    public class UserRequirement : IAuthorizationRequirement 
    {
        public UserAction Action { get; }

        public UserRequirement(UserAction action)
        {
            this.Action = action;
        }
    }
}
