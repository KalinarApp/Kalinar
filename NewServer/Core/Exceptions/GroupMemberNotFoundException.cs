namespace Kalinar.Core.Exceptions
{
    public class GroupMemberNotFoundException : Exception
    {
        public GroupMemberNotFoundException(string userId, Guid groupId) 
            : base($"There is no user with the id '{userId}' in the group with the id '{groupId}'") 
        { }
    }
}
