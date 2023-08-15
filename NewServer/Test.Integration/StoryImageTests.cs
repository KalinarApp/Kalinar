using Kalinar.Core.Exceptions;
using Kalinar.Messages.Requests;
using Kalinar.Messages.Responses;
using Kalinar.Test.Integration.Seeding;

using System.Net;

using Xunit;

namespace Kalinar.Test.Integration
{
    public class StoryImageTests : TestBase
    {
        // write the integration tests for StoryImagesController here
        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        [InlineData(Utilities.GrouplessUserId, false)]
        public async Task CanCreateStoryImage(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            StoryImageCreateRequest request = new()
            {
                GroupId = new Guid(Utilities.GroupId),
                Title = "Test Story Image",
                Order = 1,
                ImageUrl = "https://www.google.com",
            };
            StoryImageResponse? response = default;
            Exception? ex = await Record.ExceptionAsync(async () => response = await this.PostAsync<StoryImageCreateRequest, StoryImageResponse>($"/api/{ApiVersion}/story-images", request, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(response);
                Assert.Equal(request.Title, response.Title);
                Assert.Equal(request.Order, response.Order);
            }
            else
            {
                Assert.Null(response);
                Assert.IsType<HttpErrorException>(ex);
                Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
                Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
            }
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanUpdateStoryImage(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            StoryImageResponse? response = await this.GetAsync<StoryImageResponse>($"/api/{ApiVersion}/story-images/{Utilities.StoryImageId}", accessToken);

            Assert.NotNull(response);

            StoryImageUpdateRequest request = new()
            {
                Title = "Test Story Image",
                Order = 2,
                ImageUrl = "https://www.google.com",
            };

            StoryImageResponse? updatedResponse = default;
            Exception? ex = await Record.ExceptionAsync(async () => updatedResponse = await this.PutAsync<StoryImageUpdateRequest, StoryImageResponse>($"/api/{ApiVersion}/story-images/{Utilities.StoryImageId}", request, accessToken));

            if (hasPermissions)
            {
                Assert.NotNull(updatedResponse);
                Assert.Equal(request.Title, updatedResponse!.Title);
            }
            else
            {
                Assert.Null(updatedResponse);
                Assert.IsType<HttpErrorException>(ex);
                Assert.Equal(HttpStatusCode.Forbidden, ((HttpErrorException)ex!).StatusCode);
                Assert.Equal(nameof(ForbiddenAccessException), ((HttpErrorException)ex!).Type);
            }
        }

        [Theory]
        [InlineData(Utilities.GroupOwnerUserId, true)]
        [InlineData(Utilities.GroupMember1UserId, false)]
        [InlineData(Utilities.GroupMember2UserId, false)]
        public async Task CanDeleteStoryImage(string userId, bool hasPermissions)
        {
            string accessToken = GetToken(userId)!;

            StoryImageResponse? response = default;
            Exception? deleteException = await Record.ExceptionAsync(async () => await this.DeleteAsync($"/api/{ApiVersion}/story-images/{Utilities.StoryImageId}", accessToken));
            Exception? getException = await Record.ExceptionAsync(async () => response = await this.GetAsync<StoryImageResponse>($"/api/{ApiVersion}/story-images/{Utilities.StoryImageId}", accessToken));

            if (hasPermissions)
            {
                Assert.IsType<HttpErrorException>(getException);
                Assert.Equal(HttpStatusCode.NotFound, ((HttpErrorException)getException!).StatusCode);
                Assert.Equal(nameof(StoryImageNotFoundException), ((HttpErrorException)getException!).Type);
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
