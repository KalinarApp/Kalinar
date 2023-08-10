using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;

using Xunit;

namespace Kalinar.Test
{
    public class UserTests : TestBase
    {
        [Fact]
        public async Task TestUserLifecycle()
        {
            //this.Initialize();

            string userId = Guid.NewGuid().ToString();
            string accessToken = this.GetToken(userId)!;

            UserResponse? userResponse = await this.PostAsync<UserCreateRequest, UserResponse>($"/api/{ApiVersion}/users/register", new() { Username = "Test" }, accessToken);

            Assert.NotNull(userResponse);
            Assert.Equal("Test", userResponse!.Username);

            userResponse = await this.PutAsync<UserUpdateRequest, UserResponse>($"/api/{ApiVersion}/users/{userId}", new() { Username = "Test2" }, accessToken);

            Assert.NotNull(userResponse);
            Assert.Equal("Test2", userResponse!.Username);

            await this.PostAsync($"/api/{ApiVersion}/users/{userResponse!.Id}/devices", new { DeviceId = "Testdevice" }, accessToken);
            userResponse = await this.GetAsync<UserResponse>($"/api/{ApiVersion}/users/{userResponse!.Id}", accessToken);

            Assert.NotNull(userResponse);
            Assert.Equal("Test2", userResponse!.Username);
            Assert.Collection(userResponse!.DeviceIds, deviceId => Assert.Equal("Testdevice", deviceId));

            await this.DeleteAsync($"/api/{ApiVersion}/users/{userResponse!.Id}/devices/Testdevice", accessToken);
            userResponse = await this.GetAsync<UserResponse>($"/api/{ApiVersion}/users/{userResponse!.Id}", accessToken);

            Assert.NotNull(userResponse);
            Assert.Equal("Test2", userResponse!.Username);
            Assert.Empty(userResponse!.DeviceIds);

            await this.DeleteAsync($"/api/{ApiVersion}/users/{userResponse!.Id}", accessToken);
        }
    }
}
