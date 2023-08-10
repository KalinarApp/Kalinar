using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;
using Kalinar.Test.Seeding;

using System.Net;

using Xunit;

namespace Kalinar.Test
{
    public class GroupTests : TestBase
    {
        [Fact]
        public async Task TestCreateGroup()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;
            GroupResponse? groupResponse = await this.PostAsync<GroupRequest, GroupResponse>($"/api/{ApiVersion}/groups", new() { Name = "Test", Description = "Testgroup" }, accessToken);

            Assert.NotNull(groupResponse);
            Assert.Equal("Test", groupResponse!.Name);
        }

        [Fact]
        public async Task TestOwnerUpdatesGroup()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;
            GroupResponse? groupResponse = await this.PutAsync<GroupRequest, GroupResponse>($"/api/{ApiVersion}/groups/{Utilities.GroupId}", new() { Name = "Test2", Description = "Testgroup2" }, accessToken);

            Assert.NotNull(groupResponse);
            Assert.Equal("Test2", groupResponse!.Name);
            Assert.Equal("Testgroup2", groupResponse!.Description);
        }

        [Fact]
        public async Task TestMemberShouldNotUpdateGroup()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            GroupResponse? groupResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => groupResponse = await this.PutAsync<GroupRequest, GroupResponse>($"/api/{ApiVersion}/groups/{Utilities.GroupId}", new() { Name = "Test2", Description = "Testgroup2" }, accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task TestOwnerDeleteGroup()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;
            await this.DeleteAsync($"/api/{ApiVersion}/groups/{Utilities.GroupId}", accessToken);
            GroupResponse? groupResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => groupResponse = await this.GetAsync<GroupResponse>($"/api/{ApiVersion}/groups/{Utilities.GroupId}", accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(GroupNotFoundException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task TestMemberDeleteGroup()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;
            Exception? ex = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/groups/{Utilities.GroupId}", accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task TestUserCanJoinGroup()
        {
            string accessToken = this.GetToken(Utilities.GrouplessUserId)!;

            await this.PostAsync<object>($"/api/{ApiVersion}/groups/{Utilities.GroupId}/join", accessToken: accessToken);
            IEnumerable<UserMemberResponse> groups = await this.GetAsync<IEnumerable<UserMemberResponse>>($"/api/{ApiVersion}/users/{Utilities.GrouplessUserId}/groups", accessToken: accessToken);

            Assert.Collection(groups, item => Assert.Equal(new Guid(Utilities.GroupId), item.Group.Id));
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId)]
        [InlineData(Utilities.GroupMember1UserId)]
        public async Task TestUserCanNotJoinGroup(string userId)
        {
            string accessToken = this.GetToken(userId)!;

            Exception? ex = await Record.ExceptionAsync(async () => await this.PostAsync<object>($"/api/{ApiVersion}/groups/{Utilities.GroupId}/join", accessToken: accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Conflict, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(UserAlreadyInGroupException), ((HttpErrorException)ex!).Type);

            IEnumerable<UserMemberResponse> groups = await this.GetAsync<IEnumerable<UserMemberResponse>>($"/api/{ApiVersion}/users/{userId}/groups", accessToken: accessToken);

            Assert.Collection(groups, item => Assert.Equal(new Guid(Utilities.GroupId), item.Group.Id));
        }

        [Fact]
        public async Task TestUserCanLeaveGroup()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            await this.PostAsync<object>($"/api/{ApiVersion}/groups/{Utilities.GroupId}/leave", accessToken: accessToken);
            IEnumerable<UserMemberResponse> groups = await this.GetAsync<IEnumerable<UserMemberResponse>>($"/api/{ApiVersion}/users/{Utilities.GrouplessUserId}/groups", accessToken: accessToken);

            Assert.Empty(groups);
        }

        [Fact]
        public async Task TestUserCanNotLeaveGroup()
        {
            string accessToken = this.GetToken(Utilities.GrouplessUserId)!;

            Exception? ex = await Record.ExceptionAsync(async () => await this.PostAsync<object>($"/api/{ApiVersion}/groups/{Utilities.GroupId}/leave", accessToken: accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(GroupMemberNotFoundException), ((HttpErrorException)ex!).Type);

            IEnumerable<UserMemberResponse> groups = await this.GetAsync<IEnumerable<UserMemberResponse>>($"/api/{ApiVersion}/users/{Utilities.GrouplessUserId}/groups", accessToken: accessToken);

            Assert.Empty(groups);
        }

        [Fact]
        public async Task TestOwnerCanDeleteGroup()
        {
            string accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;

            await this.DeleteAsync($"/api/{ApiVersion}/groups/{Utilities.GroupId}", accessToken);
            Exception? ex = await Record.ExceptionAsync(async () => await this.GetAsync<GroupResponse>($"/api/{ApiVersion}/groups/{Utilities.GroupId}", accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(GroupNotFoundException), ((HttpErrorException)ex!).Type);
        }

        [Fact]
        public async Task TestMemberCanNotDeleteGroup()
        {
            string accessToken = this.GetToken(Utilities.GroupMember1UserId)!;

            Exception? ex = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/groups/{Utilities.GroupId}", accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);

            ex = await Record.ExceptionAsync(async () => await this.GetAsync<GroupResponse>($"/api/{ApiVersion}/groups/{Utilities.GroupId}", accessToken: accessToken));

            Assert.Null(ex);
        }

        [Fact]
        public async Task TestNonMemberCanNotDeleteGroup()
        {
            string accessToken = this.GetToken(Utilities.GrouplessUserId)!;

            Exception? ex = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/groups/{Utilities.GroupId}", accessToken));

            Assert.IsType<HttpErrorException>(ex);
            Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
            Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);

            accessToken = this.GetToken(Utilities.GroupOwnerUserId)!;
            ex = await Record.ExceptionAsync(async () => await this.GetAsync<GroupResponse>($"/api/{ApiVersion}/groups/{Utilities.GroupId}", accessToken: accessToken));

            Assert.Null(ex);
        }
    }
}
