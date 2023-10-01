using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;
using Kalinar.Test.Integration.Seeding;

using System.Net;

using Xunit;

namespace Kalinar.Test.Integration
{
    public class GroupTests : TestBase
    {
        [Fact]
        public async Task CanCreateGroup()
        {
            string accessToken = GetToken(Utilities.GroupOwnerUserId)!;
            GroupResponse? groupResponse = await this.PostAsync<GroupRequest, GroupResponse>($"/api/{ApiVersion}/groups", new() { Name = "Test", Description = "Testgroup" }, accessToken);

            Assert.NotNull(groupResponse);
            Assert.Equal("Test", groupResponse!.Name);
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        [InlineData(Utilities.GrouplessUserId, false)]
        public async Task CanUpdatesGroup(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;
            GroupResponse? groupResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => groupResponse = await this.PutAsync<GroupRequest, GroupResponse>($"/api/{ApiVersion}/groups/{Utilities.GroupId}", new() { Name = "Test2", Description = "Testgroup2" }, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(groupResponse);
                Assert.Equal("Test2", groupResponse!.Name);
                Assert.Equal("Testgroup2", groupResponse!.Description);
            }
            else
            {
                Assert.IsType<HttpErrorException>(ex);
                Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
                Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
            }
        }


        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        [InlineData(Utilities.GrouplessUserId, false)]
        public async Task CanDeleteGroup(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            GroupResponse? groupResponse = default;
            Exception? deleteException = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/groups/{Utilities.GroupId}", accessToken));
            Exception? getException = await Record.ExceptionAsync(async () => groupResponse = await this.GetAsync<GroupResponse>($"/api/{ApiVersion}/groups/{Utilities.GroupId}", accessToken));

            if (hasPermissions)
            {
                Assert.IsType<HttpErrorException>(getException);
                Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)getException!).StatusCode);
                Assert.Equal(nameof(GroupNotFoundException), ((HttpErrorException)getException!).Type);
            }
            else
            {
                Assert.IsType<HttpErrorException>(deleteException);
                Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)deleteException!).StatusCode);
                Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)deleteException!).Type);
            }
        }


        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, false)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        [InlineData(Utilities.GrouplessUserId, true)]
        public async Task CanJoinGroup(string userId, bool canJoin)
        {
            string accessToken = GetToken(userId)!;

            Exception? joinException = await Record.ExceptionAsync(async () => await this.PostAsync<object>($"/api/{ApiVersion}/groups/{Utilities.GroupId}/join", accessToken: accessToken));
            IEnumerable<GroupMemberResponse> groups = await this.GetAsync<IEnumerable<GroupMemberResponse>>($"/api/{ApiVersion}/users/{userId}/groups", accessToken: accessToken);

            if (!canJoin)
            {
                Assert.IsType<HttpErrorException>(joinException);
                Assert.Equal(HttpStatusCode.Conflict, ((HttpErrorException)joinException!).StatusCode);
                Assert.Equal(nameof(UserAlreadyInGroupException), ((HttpErrorException)joinException!).Type);
                Assert.Collection(groups, item => Assert.Equal(new Guid(Utilities.GroupId), item.Group.Id));
            }

            Assert.Collection(groups, item => Assert.Equal(new Guid(Utilities.GroupId), item.Group.Id));
        }


        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, true)]
        [InlineData(Utilities.GroupMember2UserId, true)]
        [InlineData(Utilities.GrouplessUserId, false)]
        public async Task CanLeaveGroup(string userId, bool canLeave)
        {
            string accessToken = GetToken(userId)!;

            Exception? leaveException = await Record.ExceptionAsync(async () => await this.PostAsync<object>($"/api/{ApiVersion}/groups/{Utilities.GroupId}/leave", accessToken: accessToken));
            IEnumerable<GroupMemberResponse> groups = await this.GetAsync<IEnumerable<GroupMemberResponse>>($"/api/{ApiVersion}/users/{userId}/groups", accessToken: accessToken);

            if (!canLeave)
            {
                Assert.IsType<HttpErrorException>(leaveException);
                Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)leaveException!).StatusCode);
                Assert.Equal(nameof(GroupMemberNotFoundException), ((HttpErrorException)leaveException!).Type);
            }

            Assert.Empty(groups);
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        [InlineData(Utilities.GrouplessUserId, false)]
        public async Task TestOwnerCanDeleteGroup(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            Exception? deleteException = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/groups/{Utilities.GroupId}", accessToken));
            Exception? getException = await Record.ExceptionAsync(async () => await this.GetAsync<GroupResponse>($"/api/{ApiVersion}/groups/{Utilities.GroupId}", accessToken));

            if (hasPermissions)
            {
                Assert.IsType<HttpErrorException>(getException);
                Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)getException!).StatusCode);
                Assert.Equal(nameof(GroupNotFoundException), ((HttpErrorException)getException!).Type);
            }
            else
            {
                Assert.IsType<HttpErrorException>(deleteException);
                Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)deleteException!).StatusCode);
                Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)deleteException!).Type);
            }
        }
    }
}
