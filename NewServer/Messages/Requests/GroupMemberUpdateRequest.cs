using Kalinar.Core.Entities;
using Kalinar.Messages.Attributes;

using System.ComponentModel.DataAnnotations;

using RoleEntity = Kalinar.Core.Entities.Role;

namespace Kalinar.Messages.Requests
{
    public class GroupMemberUpdateRequest
    {
        [Required]
        [AllowedValues(RoleEntity.Owner, RoleEntity.Administrator, RoleEntity.Member)]
        public required string Role { get; init; }
    }
}
